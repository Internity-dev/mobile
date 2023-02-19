import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../../profile/model/user.dart';
import '../data/auth_remote_source.dart';
import '../model/login_state.dart';

class Login extends StateNotifier<LoginState> {
  Login(this._authRemoteSource) : super(const LoginState.initial());

  final AuthRemoteSource _authRemoteSource;

  // Login Method implementation
  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = const LoginState.loading();
    final result = await _authRemoteSource.login(
      email: email,
      password: password,
    );
    state = result.fold(
      (error) => LoginState.failure(error),
      (success) => LoginState.success(success),
    );
  }
}

// Login function
final authProvider = StateNotifierProvider<Login, LoginState>((ref) {
  return Login(
    ref.read(authRemoteSourceProvider),
  );
});

// Get auth user
final getUserAuthProvider = FutureProvider<UserModel>((ref) async {
  final result = await ref.read(authRemoteSourceProvider).getUserAuth();
  return result.fold(
    (error) => throw Exception(error),
    (success) => success,
  );
});

// Check if user is login
final isUserLoginProvider = FutureProvider<bool>((ref) async {
  ref.watch(authProvider);

  final prefs = await SharedPreferences.getInstance();

  return prefs.getString('token') != null;
});
