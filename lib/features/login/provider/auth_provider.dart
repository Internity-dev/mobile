import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../../onboarding/provider/onboarding_provider.dart';

import '../data/auth_remote_source.dart';
import '../model/login_state.dart';

class Auth extends StateNotifier<AuthState> {
  Auth(this._authRemoteSource) : super(const AuthState.initial());

  final AuthRemoteSource _authRemoteSource;

  // Login Method implementation
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const AuthState.loading();
    final result = await _authRemoteSource.login(
      email: email,
      password: password,
    );
    state = result.fold(
      (error) => AuthState.loginError(error),
      (success) => AuthState.loginSuccess(success),
    );
  }

  // Logout
  Future<void> logout() async {
    state = const AuthState.loading();
    final result = await _authRemoteSource.logout();
    state = result.fold(
      (error) => AuthState.logoutError(error),
      (success) => const AuthState.logoutSuccess(),
    );
  }
}

// Login function
final authProvider = StateNotifierProvider<Auth, AuthState>((ref) {
  return Auth(
    ref.watch(authRemoteSourceProvider),
  );
});

// Get auth User data
final authUserProvider = FutureProvider((ref) async {
  return await ref.watch(authRemoteSourceProvider).getUserAuth();
});

// Check user Auth status
enum UserStatus { loggedIn, loggedOut, onboarding }

final isUserLoginProvider = FutureProvider<UserStatus>((ref) async {
  ref.watch(authProvider);
  ref.watch(onboardingProvider);
  await ref.watch(authUserProvider.future);

  final prefs = await SharedPreferences.getInstance();

  if (prefs.getBool('is_onboarding') == true ||
      prefs.getBool('is_onboarding') == null) {
    return UserStatus.onboarding;
  } else if (prefs.getString('token') != null) {
    return UserStatus.loggedIn;
  } else {
    return UserStatus.loggedOut;
  }
});
