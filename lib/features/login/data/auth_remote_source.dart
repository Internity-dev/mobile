import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:internity/features/profile/model/user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';
import '../model/auth.dart';

class AuthRemoteSource {
  final Dio dio;
  final Ref ref;

  AuthRemoteSource({required this.dio, required this.ref});

  // Login Method
  Future<Either<String, AuthModel>> login(
      {required String email, required String password}) async {
    try {
      final response = await dio.post(
        'api/login',
        data: {
          'email': email,
          'password': password,
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
          },
        ),
      );

      AuthModel jsonResult = AuthModel.fromJson(response.data);

      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', jsonResult.accessToken);

      return Right(jsonResult);
    } on DioError catch (e) {
      return Left(e.message);
    }
  }

  // Get user auth method
  Future<Either<String, UserModel>> getUserAuth() async {
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await dio.get(
        'api/me',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
            'Authorization': 'Bearer ${prefs.getString('token')}'
          },
        ),
      );

      UserModel jsonResult = UserModel.fromJson(response.data);

      print(jsonResult);

      return Right(jsonResult);
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        final prefs = await SharedPreferences.getInstance();
        prefs.remove('token');

        return Left(e.message);
      }

      return Left(e.message);
    }
  }

  // Logout method
  Future<Either<String, dynamic>> logout() async {
    print("dikilcas");
    final prefs = await SharedPreferences.getInstance();

    try {
      final response = await dio.post(
        'api/logout',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
            'Authorization': 'Bearer ${prefs.getString('token')}'
          },
        ),
      );

      prefs.remove('token');

      print(response.data);

      return Right(response.data);
    } on DioError catch (e) {
      return Left(e.message);
    }
  }
}
