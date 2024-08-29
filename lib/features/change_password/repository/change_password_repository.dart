import 'package:dio/dio.dart';
import 'package:internity/features/change_password/model/change_password_model.dart';
import 'package:internity/features/change_password/model/error_validation_model.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';

class ChangePasswordRepository {
  final Ref ref;
  final Dio dio;

  ChangePasswordRepository({
    required this.ref,
    required this.dio,
  });

  Future changePassword(ChangePasswordModel data) async {
    try {
      final response =
          await dio.put('/api/change-password', data: data.toJson());

      return response.data;
    } on DioException catch (e) {
      throw ErrorValidationModel.fromJson(e.response?.data);
    }
  }
}

final changePasswordRepositoryProvider = Provider<ChangePasswordRepository>(
  (ref) => ChangePasswordRepository(
    ref: ref,
    dio: ref.read(dioProvider),
  ),
);
