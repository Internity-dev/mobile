import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';
import '../model/user.dart';

class AuthRemoteSource {
  final Dio dio;
  final Ref ref;

  AuthRemoteSource({required this.dio, required this.ref});

  // Login Method
  Future<Either<String, User>> login(
      {required String email, required String password}) async {
    try {
      final response = await dio.post(
        'api/login',
        data: {
          'email': "student@test.de",
          'password': "123qweasd",
        },
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-type': 'application/json',
          },
        ),
      );

      return Right(User.fromJson(response.data));
    } on DioError catch (e) {
      return Left(e.response?.data['message'] ?? 'Something went wrong');
    }
  }
}

final authRemoteSourceProvider = Provider<AuthRemoteSource>((ref) {
  return AuthRemoteSource(
    dio: ref.read(dioProvider),
    ref: ref,
  );
});
