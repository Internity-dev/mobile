import 'package:dio/dio.dart';
import 'package:fpdart/fpdart.dart';
import 'package:internity/features/profile/model/profile_model.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/provider/shared_pref_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';
import '../model/auth.dart';

class AuthRepository {
  final Dio dio;
  final Ref ref;

  AuthRepository({required this.dio, required this.ref});

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
    } on DioException catch (e) {
      return Left(e.message ?? 'Something went wrong');
    }
  }

  // Get user auth method
  Future getUserAuth() async {
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

      return jsonResult;
    } on DioException catch (e) {
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
          },
        ),
      );

      prefs.remove('token');

      return Right(response.data);
    } on DioException catch (e) {
      return Left(e.message ?? 'Something went wrong');
    }
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(
    dio: ref.watch(dioProvider),
    ref: ref,
  );
});
