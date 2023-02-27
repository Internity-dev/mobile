import '../../../shared/riverpod_and_hooks.dart';
import '../repository/onboarding_repository.dart';

final onboardingPageIndexProvider = StateProvider((ref) => 0);
final onboardingPageCountProvider = Provider((ref) => 3);

class Onboarding extends StateNotifier<bool> {
  Onboarding(this._onboardingRepository) : super(true);

  final OnboardingRepository _onboardingRepository;

  Future<void> setOnboardingStatus(bool status) async {
    state = false;
    await _onboardingRepository.setOnboardingStatus(status);
  }
}

final onboardingProvider = StateNotifierProvider<Onboarding, bool>((ref) {
  return Onboarding(
    ref.watch(onboardingRepositoryProvider),
  );
});
