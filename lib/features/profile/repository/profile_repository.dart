import 'package:dio/dio.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/provider/shared_pref_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';
import '../model/profile_model.dart';

class ProfileRepository {
  final Ref ref;
  final Dio dio;

  ProfileRepository({required this.ref, required this.dio});

  Future getProfile() async {
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
      throw e.message;
    }
  }
}

final profileRepositoryProvider =
    Provider.autoDispose<ProfileRepository>((ref) {
  final dio = ref.watch(dioProvider(null));
  return ProfileRepository(ref: ref, dio: dio);
});
