import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

const _kOnboardingSeenKey = 'onboarding_seen_v1';

/// Whether the first-run onboarding has already been completed. Read once
/// at startup; the app shell shows [OnboardingFlow] instead of the gate
/// until this flips to true.
final onboardingSeenProvider = FutureProvider<bool>((ref) async {
  final prefs = await SharedPreferences.getInstance();
  return prefs.getBool(_kOnboardingSeenKey) ?? false;
});

class OnboardingActions {
  Future<void> markSeen() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_kOnboardingSeenKey, true);
  }
}

final onboardingActionsProvider = Provider<OnboardingActions>((ref) => OnboardingActions());
