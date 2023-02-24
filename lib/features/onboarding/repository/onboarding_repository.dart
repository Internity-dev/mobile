import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/riverpod_and_hooks.dart';

class OnboardingRepository {
  Future<void> setOnboardingStatus(bool status) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('is_onboarding', status);
  }

  Future<bool> getOnboardingStatus() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('is_onboarding') ?? false;
  }
}

final onboardingRepositoryProvider = StateProvider<OnboardingRepository>((ref) {
  return OnboardingRepository();
});
