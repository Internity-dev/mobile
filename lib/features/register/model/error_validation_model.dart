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
    this.name,
    this.email,
    this.password,
    this.courseCode,
  });
  late final List<String>? name;
  late final List<String>? email;
  late final List<String>? password;
  late final List<String>? courseCode;

  Errors.fromJson(Map<String, dynamic> json) {
    name = List.castFrom<dynamic, String>(json['name']);
    email = List.castFrom<dynamic, String>(json['email']);
    password = List.castFrom<dynamic, String>(json['password']);
    courseCode = List.castFrom<dynamic, String>(json['course_code']);
  }
}
