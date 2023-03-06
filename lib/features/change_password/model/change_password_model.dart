class ChangePasswordModel {
  ChangePasswordModel({
    required this.oldPassword,
    required this.password,
    required this.passwordConfirmation,
  });
  late final String oldPassword;
  late final String password;
  late final String passwordConfirmation;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['old_password'] = oldPassword;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    return data;
  }
}
