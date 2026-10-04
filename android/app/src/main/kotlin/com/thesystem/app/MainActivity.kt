package com.thesystem.app

import android.app.AppOpsManager
import android.app.usage.UsageStatsManager
import android.content.Context
import android.content.Intent
import android.content.pm.PackageManager
import android.net.Uri
import android.os.Process
import android.provider.Settings
import java.util.Calendar
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

/// Backs the screen-time-as-currency feature: reads on-device app usage
/// via UsageStatsManager (Android-only, requires the person to grant
/// "Usage access" manually in system settings — see
/// PACKAGE_USAGE_STATS in AndroidManifest.xml) and lists installed
/// launchable apps for the blocked-apps picker. Nothing here reads or
/// sends data anywhere off-device.
class MainActivity : FlutterActivity() {
    private val channelName = "com.thesystem.app/screen_time"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, channelName).setMethodCallHandler { call, result ->
            when (call.method) {
                "hasUsageAccess" -> result.success(hasUsageAccess())
                "openUsageAccessSettings" -> {
                    startActivity(Intent(Settings.ACTION_USAGE_ACCESS_SETTINGS))
                    result.success(null)
                }
                "getInstalledLaunchableApps" -> result.success(getInstalledLaunchableApps())
                "getTodayUsageMinutes" -> {
                    val pkg = call.argument<String>("packageName")
                    if (pkg == null) {
                        result.error("bad_args", "packageName required", null)
                    } else {
                        result.success(getTodayUsageMinutes(pkg))
                    }
                }
                else -> result.notImplemented()
            }
        }
    }

    private fun hasUsageAccess(): Boolean {
        val appOps = getSystemService(Context.APP_OPS_SERVICE) as AppOpsManager
        val mode = appOps.checkOpNoThrow(AppOpsManager.OPSTR_GET_USAGE_STATS, Process.myUid(), packageName)
        return mode == AppOpsManager.MODE_ALLOWED
    }

    private fun getInstalledLaunchableApps(): List<Map<String, String>> {
        val pm = packageManager
        val intent = Intent(Intent.ACTION_MAIN, null).addCategory(Intent.CATEGORY_LAUNCHER)
        val apps = pm.queryIntentActivities(intent, 0)
        return apps
            .distinctBy { it.activityInfo.packageName }
            .filter { it.activityInfo.packageName != packageName } // don't let the app block itself
            .map {
                mapOf(
                    "packageName" to it.activityInfo.packageName,
                    "label" to it.loadLabel(pm).toString()
                )
            }
            .sortedBy { it["label"] }
    }

    private fun getTodayUsageMinutes(pkg: String): Long {
        if (!hasUsageAccess()) return 0L
        val usm = getSystemService(Context.USAGE_STATS_SERVICE) as UsageStatsManager
        val cal = Calendar.getInstance()
        cal.set(Calendar.HOUR_OF_DAY, 0)
        cal.set(Calendar.MINUTE, 0)
        cal.set(Calendar.SECOND, 0)
        cal.set(Calendar.MILLISECOND, 0)
        val startOfDay = cal.timeInMillis
        val now = System.currentTimeMillis()

        // queryUsageStats can return several buckets for the same package;
        // the aggregated query merges them instead of picking one at random.
        val stats = usm.queryAndAggregateUsageStats(startOfDay, now)
        return (stats[pkg]?.totalTimeInForeground ?: 0L) / 60000L
    }
}
