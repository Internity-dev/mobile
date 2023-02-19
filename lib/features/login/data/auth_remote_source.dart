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
    try {
      final response = await dio.get(
        'api/me',
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
          },
        ),
      );

      UserModel jsonResult = UserModel.fromJson(response.data);

      return Right(jsonResult);
    } on DioError catch (e) {
      return Left(e.message);
    }
  }
}

final authRemoteSourceProvider = Provider<AuthRemoteSource>((ref) {
  String? token;

  void getToken() async {
    final prefs = await SharedPreferences.getInstance();
    token = prefs.getString('token');
  }

  getToken();

  return AuthRemoteSource(
    dio: ref.read(dioProvider(token)),
    ref: ref,
  );
});
