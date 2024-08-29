import 'package:dio/dio.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/provider/shared_pref_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';
import '../model/error_validation_model.dart';
import '../model/post_register_model.dart';

class RegisterRepository {
  final Ref ref;
  final Dio dio;

  RegisterRepository({required this.ref, required this.dio});

  Future register(PostRegisterModel data) async {
    try {
      final response = await dio.post('/api/register', data: data.toJson());

      final prefs = await ref.watch(sharedPrefProvider);

      prefs.setString('token', response.data['access_token']);

      return response.data;
    } on DioException catch (e) {
      throw ErrorValidationModel.fromJson(e.response?.data);
    }
  }
}

final registerRepositoryProvider = Provider.autoDispose<RegisterRepository>(
  (ref) => RegisterRepository(
    ref: ref,
    dio: ref.read(dioProvider),
  ),
);
