import 'package:dio/dio.dart';

class PostUserModel {
  PostUserModel({
    required this.name,
    required this.email,
    this.gender,
    this.bio,
    this.address,
    this.phone,
    this.dateOfBirth,
    this.skills,
  });

  late final String name;
  late final String email;

  String? gender;
  String? bio;
  String? address;
  String? phone;
  String? dateOfBirth;
  String? skills;

  Map<String, dynamic> toJson() {
    final data = <String, dynamic>{};
    data['name'] = name;
    data['email'] = email;
    data['gender'] = gender;
    data['bio'] = bio;
    data['address'] = address;
    data['phone'] = phone;
    data['date_of_birth'] = dateOfBirth;
    data['skills'] = skills;

    return data;
  }
}
