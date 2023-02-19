import 'package:freezed_annotation/freezed_annotation.dart';

import 'auth.dart';

part 'login_state.freezed.dart';

@freezed
abstract class LoginState with _$LoginState {
  const factory LoginState.initial() = _Initial;
  const factory LoginState.loading() = _Loading;
  const factory LoginState.success(AuthModel auth) = _AuthModel;
  const factory LoginState.failure(String errorMessage) = _Failure;
}
