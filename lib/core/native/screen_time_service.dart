import 'dart:io';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Thin wrapper over the native `com.thesystem.app/screen_time`
/// MethodChannel (see MainActivity.kt), which reads on-device app usage
/// via Android's UsageStatsManager. Android-only — every method fails
/// gracefully (returns a safe default) on other platforms or if the
/// person hasn't granted "Usage access" yet, so callers never need to
/// special-case the platform themselves.
class ScreenTimeService {
  static const _channel = MethodChannel('com.thesystem.app/screen_time');

  bool get isSupported => Platform.isAndroid;

  Future<bool> hasUsageAccess() async {
    if (!isSupported) return false;
    try {
      return await _channel.invokeMethod<bool>('hasUsageAccess') ?? false;
    } catch (_) {
      return false;
    }
  }

  /// Opens the system "Usage access" settings screen where the person
  /// must manually grant this app permission — Android does not allow
  /// this to be requested via a normal runtime permission dialog.
  Future<void> openUsageAccessSettings() async {
    if (!isSupported) return;
    try {
      await _channel.invokeMethod('openUsageAccessSettings');
    } catch (_) {}
  }

  /// `[{packageName, label}, ...]` for every launchable app on-device
  /// except this one — used to populate the blocked-apps picker.
  Future<List<Map<String, String>>> getInstalledLaunchableApps() async {
    if (!isSupported) return [];
    try {
      final result = await _channel.invokeMethod<List<dynamic>>('getInstalledLaunchableApps');
      if (result == null) return [];
      return result.map((e) => Map<String, String>.from(e as Map)).toList();
    } catch (_) {
      return [];
    }
  }

  Future<int> getTodayUsageMinutes(String packageName) async {
    if (!isSupported) return 0;
    try {
      final result = await _channel.invokeMethod<int>('getTodayUsageMinutes', {'packageName': packageName});
      return result ?? 0;
    } catch (_) {
      return 0;
    }
  }
}

final screenTimeServiceProvider = Provider<ScreenTimeService>((ref) => ScreenTimeService());
