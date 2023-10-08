import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';
import '../model/post_profile_model.dart';
import '../model/profile_model.dart';

class ProfileRepository {
  final Ref ref;
  final Dio dio;

  ProfileRepository({required this.ref, required this.dio});

  Future getProfile() async {
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
      throw e.response?.data['message'] ?? 'Something went wrong';
    }
  }

  Future editProfile(PostUserModel data) async {
    await dio.put('/api/change-profile', data: data.toJson());
  }

  Future changeProfilePicture(MultipartFile data) async {
    var formData = FormData.fromMap({
      "avatar": data,
    });

    await dio.post(
      '/api/avatars',
      data: formData,
      options: Options(
        headers: {
          'Accept': 'application/json',
          'Content-type': 'multipart/form-data',
        },
      ),
    );
  }

  Future<XFile> getLocaleProfilePicture() async {
    final ImagePicker picker = ImagePicker();
    // Pick an image
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    return image!;
  }
}

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return ProfileRepository(ref: ref, dio: dio);
});
