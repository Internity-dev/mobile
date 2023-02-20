import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';
import '../../profile/model/user.dart';
import '../data/auth_remote_source.dart';
import '../model/login_state.dart';

final authRemoteSourceProvider = Provider<AuthRemoteSource>((ref) {
  return AuthRemoteSource(
    dio: ref.watch(dioProvider(null)),
    ref: ref,
  );
});

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
final authProvider = StateNotifierProvider.autoDispose<Auth, AuthState>((ref) {
  return Auth(
    ref.watch(authRemoteSourceProvider),
  );
});

// get user data
final userProvider = FutureProvider.autoDispose<UserModel>((ref) async {
  final result = await ref.read(authRemoteSourceProvider).getUserAuth();

  return result.fold(
    (error) => throw Exception(error),
    (success) => success,
  );
});

// Check if user is login
final isUserLoginProvider = FutureProvider.autoDispose<bool>((ref) async {
  ref.watch(authProvider);
  ref.watch(userProvider);

  final prefs = await SharedPreferences.getInstance();

  print(prefs.getString('token'));

  return prefs.getString('token') != null;
});
