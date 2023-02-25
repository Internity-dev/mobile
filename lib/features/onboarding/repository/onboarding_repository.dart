import '../../../shared/provider/shared_pref_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';

class OnboardingRepository {
  OnboardingRepository({required this.ref});

  final Ref ref;

  Future<void> setOnboardingStatus(bool status) async {
    final prefs = await ref.watch(sharedPrefProvider);
    prefs.setBool('is_onboarding', status);
  }

  Future<bool> getOnboardingStatus() async {
    final prefs = await ref.watch(sharedPrefProvider);
    return prefs.getBool('is_onboarding') ?? false;
  }
}

final onboardingRepositoryProvider = StateProvider<OnboardingRepository>((ref) {
  return OnboardingRepository(
    ref: ref,
  );
});
