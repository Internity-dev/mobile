import '../../../shared/riverpod_and_hooks.dart';
import '../data/auth_remote_source.dart';
import '../model/auth_state.dart';

class Auth extends StateNotifier<AuthState> {
  Auth(this._authRemoteSource) : super(const AuthState.initial());

  final AuthRemoteSource _authRemoteSource;

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
      (error) => AuthState.failure(error),
      (success) => AuthState.success(success),
    );
  }
}

final authProvider = StateNotifierProvider<Auth, AuthState>((ref) {
  return Auth(
    ref.read(authRemoteSourceProvider),
  );
});
