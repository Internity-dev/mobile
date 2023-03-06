class PostRegisterModel {
  PostRegisterModel({
    required this.name,
    required this.email,
    required this.password,
    required this.passwordConfirmation,
    required this.courseCode,
  });
  late final String name;
  late final String email;
  late final String password;
  late final String passwordConfirmation;
  late final String courseCode;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['password'] = password;
    data['password_confirmation'] = passwordConfirmation;
    data['course_code'] = courseCode;
    return data;
  }
}
