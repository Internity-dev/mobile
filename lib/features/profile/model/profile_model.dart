class UserModel {
  UserModel({
    required this.id,
    required this.name,
    required this.email,
    this.emailVerifiedAt,
    this.twoFactorSecret,
    this.twoFactorRecoveryCodes,
    this.twoFactorConfirmedAt,
    this.gender,
    this.bio,
    this.address,
    this.phone,
    this.dateOfBirth,
    this.avatar,
    this.skills,
    required this.status,
    required this.passwordByAdmin,
    this.lastLogin,
    this.lastLoginIp,
    required this.createdAt,
    required this.updatedAt,
  });
  late final int id;
  late final String name;
  late final String email;
  String? emailVerifiedAt;
  String? twoFactorSecret;
  String? twoFactorRecoveryCodes;
  String? twoFactorConfirmedAt;
  String? gender;
  String? bio;
  String? address;
  String? phone;
  String? dateOfBirth;
  String? avatar;
  String? skills;
  late final int status;
  late final int passwordByAdmin;
  String? lastLogin;
  String? lastLoginIp;
  late final String createdAt;
  late final String updatedAt;

  List<String>? get getSkills => skills?.split(',');

  UserModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    emailVerifiedAt = json['email_verified_at'];
    twoFactorSecret = json['two_factor_secret'];
    twoFactorRecoveryCodes = json['two_factor_recovery_codes'];
    twoFactorConfirmedAt = json['two_factor_confirmed_at'];
    gender = json['gender'];
    bio = json['bio'];
    address = json['address'];
    phone = json['phone'];
    dateOfBirth = json['date_of_birth'];
    avatar = json['avatar'];
    skills = json['skills'];
    status = json['status'];
    passwordByAdmin = json['password_by_admin'];
    lastLogin = json['last_login'];
    lastLoginIp = json['last_login_ip'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
  }

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['email_verified_at'] = emailVerifiedAt;
    data['two_factor_secret'] = twoFactorSecret;
    data['two_factor_recovery_codes'] = twoFactorRecoveryCodes;
    data['two_factor_confirmed_at'] = twoFactorConfirmedAt;
    data['gender'] = gender;
    data['bio'] = bio;
    data['address'] = address;
    data['phone'] = phone;
    data['date_of_birth'] = dateOfBirth;
    data['avatar'] = avatar;
    data['skills'] = skills;
    data['status'] = status;
    data['password_by_admin'] = passwordByAdmin;
    data['last_login'] = lastLogin;
    data['last_login_ip'] = lastLoginIp;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    return data;
  }
}
