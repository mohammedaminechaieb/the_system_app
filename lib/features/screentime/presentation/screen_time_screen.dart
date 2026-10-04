import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:the_system/core/providers/core_providers.dart';

import '../../../core/database/app_database.dart';
import '../../../core/native/screen_time_service.dart';
import '../../../core/theme/app_palette.dart';
import '../../../core/widgets/shared_widgets.dart';
import '../data/screen_time_providers.dart';

const _kRedeemPresets = [5, 10, 15, 30];

class ScreenTimeScreen extends ConsumerStatefulWidget {
  const ScreenTimeScreen({super.key});

  @override
  ConsumerState<ScreenTimeScreen> createState() => _ScreenTimeScreenState();
}

class _ScreenTimeScreenState extends ConsumerState<ScreenTimeScreen> with WidgetsBindingObserver {
  bool _hasAccess = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _refreshAccess();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Re-check after the person comes back from the system settings screen.
    if (state == AppLifecycleState.resumed) _refreshAccess();
  }

  Future<void> _refreshAccess() async {
    final has = await ref.read(screenTimeServiceProvider).hasUsageAccess();
    if (mounted) setState(() => _hasAccess = has);
  }

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    final service = ref.watch(screenTimeServiceProvider);
    final blockedAppsAsync = ref.watch(blockedAppsProvider);
    final creditsAsync = ref.watch(todayScreenTimeCreditsProvider);
    final todayKey = ref.watch(todayKeyProvider);

    if (!service.isSupported) {
      return Scaffold(
        appBar: AppBar(title: const Text('Screen time')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Text('Screen-time tracking uses Android\'s usage stats API and isn\'t available on this platform.', textAlign: TextAlign.center, style: TextStyle(color: p.textFaint)),
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Screen time')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          if (!_hasAccess)
            SectionCard(
              title: 'Usage access needed',
              titleIcon: Icons.lock_outline,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('To read your screen time, grant "Usage access" in system settings — Android requires this to be done manually.', style: TextStyle(color: p.textSecondary)),
                  const SizedBox(height: 12),
                  ElevatedButton(onPressed: () => service.openUsageAccessSettings(), child: const Text('Open settings')),
                ],
              ),
            )
          else
            creditsAsync.when(
              data: (credits) {
                final earned = credits?.earnedMinutes ?? 0;
                final used = credits?.usedMinutes ?? 0;
                final available = (earned - used).clamp(0, 1 << 30);
                return SectionCard(
                  title: "Today's balance",
                  titleIcon: Icons.savings_outlined,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        _BalanceStat(label: 'Earned', value: '$earned min'),
                        _BalanceStat(label: 'Used', value: '$used min'),
                        _BalanceStat(label: 'Available', value: '$available min', highlight: true),
                      ]),
                      const SizedBox(height: 14),
                      Text('Redeem for blocked apps', style: TextStyle(fontSize: 11.5, color: p.textFaint, fontWeight: FontWeight.w600)),
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          for (final preset in _kRedeemPresets)
                            OutlinedButton(
                              onPressed: available >= preset
                                  ? () async {
                                      final redeemed = await ref.read(screenTimeManagementProvider).redeemMinutes(todayKey, preset);
                                      if (context.mounted && redeemed > 0) {
                                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unlocked $redeemed min')));
                                      }
                                    }
                                  : null,
                              child: Text('$preset min'),
                            ),
                        ],
                      ),
                    ],
                  ),
                );
              },
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('$e'),
            ),
          const SizedBox(height: AppSpacing.lg),
          SectionCard(
            title: 'Blocked apps',
            titleIcon: Icons.block,
            trailing: IconButton(icon: const Icon(Icons.add), onPressed: () => _showAddAppSheet(context, service)),
            child: blockedAppsAsync.when(
              data: (apps) => apps.isEmpty
                  ? Text('No apps blocked yet. Add one to start earning screen time back by logging activity.', style: TextStyle(color: p.textFaint))
                  : Column(children: [for (final app in apps) _BlockedAppTile(app: app, hasAccess: _hasAccess)]),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => Text('$e'),
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Text(
            '10 minutes of logged exercise, hobby, learning, or martial arts time earns back 15 minutes on blocked apps. Every habit tick earns a flat 15 minutes too.',
            style: TextStyle(fontSize: 11.5, color: p.textFaint),
          ),
        ],
      ),
    );
  }

  void _showAddAppSheet(BuildContext context, ScreenTimeService service) async {
    final selected = await showModalBottomSheet<Map<String, String>>(
      context: context,
      isScrollControlled: true,
      builder: (sheetContext) => _AddAppSheet(service: service),
    );
    if (selected == null) return;
    await ref.read(screenTimeManagementProvider).addBlockedApp(selected['packageName']!, selected['label']!);
  }
}

class _BalanceStat extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;
  const _BalanceStat({required this.label, required this.value, this.highlight = false});

  @override
  Widget build(BuildContext context) {
    final p = AppPalette.of(context);
    return Column(
      children: [
        Text(value, style: TextStyle(fontSize: 17, fontWeight: FontWeight.w800, color: highlight ? p.primary : p.textPrimary)),
        Text(label, style: TextStyle(fontSize: 10.5, color: p.textFaint)),
      ],
    );
  }
}

class _BlockedAppTile extends ConsumerWidget {
  final BlockedApp app;
  final bool hasAccess;
  const _BlockedAppTile({required this.app, required this.hasAccess});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<int>(
      future: hasAccess ? ref.read(screenTimeServiceProvider).getTodayUsageMinutes(app.packageName) : Future.value(0),
      builder: (context, snapshot) {
        final usage = snapshot.data ?? 0;
        return ListTile(
          contentPadding: EdgeInsets.zero,
          title: Text(app.label, style: const TextStyle(fontSize: 13.5, fontWeight: FontWeight.w600)),
          subtitle: hasAccess ? Text('$usage min today') : null,
          trailing: IconButton(icon: const Icon(Icons.close, size: 18), onPressed: () => ref.read(screenTimeManagementProvider).removeBlockedApp(app.packageName)),
        );
      },
    );
  }
}

class _AddAppSheet extends StatefulWidget {
  final ScreenTimeService service;
  const _AddAppSheet({required this.service});

  @override
  State<_AddAppSheet> createState() => _AddAppSheetState();
}

class _AddAppSheetState extends State<_AddAppSheet> {
  List<Map<String, String>> _apps = [];
  bool _loading = true;
  String _query = '';

  @override
  void initState() {
    super.initState();
    widget.service.getInstalledLaunchableApps().then((apps) {
      if (mounted) {
        setState(() {
          _apps = apps;
          _loading = false;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final filtered = _apps.where((a) => (a['label'] ?? '').toLowerCase().contains(_query.toLowerCase())).toList();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Add app to block', style: Theme.of(context).textTheme.displaySmall),
            const SizedBox(height: 10),
            TextField(decoration: const InputDecoration(hintText: 'Search apps…', prefixIcon: Icon(Icons.search)), onChanged: (v) => setState(() => _query = v)),
            const SizedBox(height: 10),
            SizedBox(
              height: 360,
              child: _loading
                  ? const Center(child: CircularProgressIndicator())
                  : ListView.builder(
                      itemCount: filtered.length,
                      itemBuilder: (context, i) {
                        final app = filtered[i];
                        return ListTile(
                          title: Text(app['label'] ?? ''),
                          onTap: () => Navigator.of(context).pop(app),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
