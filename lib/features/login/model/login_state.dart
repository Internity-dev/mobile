import 'package:freezed_annotation/freezed_annotation.dart';

import '../../profile/model/profile_model.dart';
import 'auth.dart';

part 'login_state.freezed.dart';

@freezed
abstract class AuthState with _$AuthState {
  const factory AuthState.initial() = _Initial;
  const factory AuthState.loading() = _Loading;

  const factory AuthState.loginSuccess(AuthModel data) = _LoginSuccess;
  const factory AuthState.loginError(String errorMessage) = _LoginError;

  const factory AuthState.registerSuccess(AuthModel data) = _RegisterSuccess;
  const factory AuthState.registerError(String errorMessage) = _RegisterError;

  const factory AuthState.logoutSuccess() = _LogoutSuccess;
  const factory AuthState.logoutError(String errorMessage) = _LogoutError;

  const factory AuthState.getUserSuccess(UserModel data) = _GetUserSuccess;
  const factory AuthState.getUserError(String errorMessage) = _GetUserError;
}
