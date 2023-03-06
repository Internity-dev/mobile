class ErrorValidationModel {
  ErrorValidationModel({
    required this.message,
    required this.errors,
  });
  late final String message;
  late final Errors errors;

  ErrorValidationModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    errors = Errors.fromJson(json['errors']);
  }
}

class Errors {
  Errors({
    required this.oldPassword,
    required this.password,
  });
  late final List<String> oldPassword;
  late final List<String> password;

  Errors.fromJson(Map<String, dynamic> json) {
    oldPassword = List.castFrom<dynamic, String>(json['old_password']);
    password = List.castFrom<dynamic, String>(json['password']);
  }
}
