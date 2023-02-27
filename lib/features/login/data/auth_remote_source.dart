import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:internity/features/profile/model/profile_model.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/provider/shared_pref_provider.dart';
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

      final prefs = await ref.watch(sharedPrefProvider);
      prefs.setString('token', jsonResult.accessToken);

      return Right(jsonResult);
    } on DioError catch (e) {
      return Left(e.message);
    }
  }

  // Get user auth method
  Future getUserAuth() async {
    final prefs = await ref.watch(sharedPrefProvider);

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

      return jsonResult;
    } on DioError catch (e) {
      if (e.response?.statusCode == 401) {
        prefs.remove('token');

        return e.message;
      }

      return e.message;
    }
  }

  // Logout method
  Future<Either<String, dynamic>> logout() async {
    final prefs = await ref.watch(sharedPrefProvider);

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

      return Right(response.data);
    } on DioError catch (e) {
      return Left(e.message);
    }
  }
}

final authRemoteSourceProvider = Provider<AuthRemoteSource>((ref) {
  return AuthRemoteSource(
    dio: ref.watch(dioProvider(null)),
    ref: ref,
  );
});
