import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:internity/features/profile/model/post_profile_model.dart';

import '../../../shared/riverpod_and_hooks.dart';
import '../model/profile_model.dart';
import '../repository/profile_repository.dart';

final profileProvider = FutureProvider.autoDispose<UserModel>((ref) async {
  return await ref.watch(profileRepositoryProvider).getProfile();
});

final getLocalProfilePictureProvider =
    FutureProvider.autoDispose<XFile>((ref) async {
  return await ref.watch(profileRepositoryProvider).getLocaleProfilePicture();
});

final editProfileProvider =
    FutureProvider.autoDispose.family<void, PostUserModel>((ref, data) async {
  await ref.watch(profileRepositoryProvider).editProfile(data);
});

final uploadProfilePictureProvider =
    FutureProvider.autoDispose.family<void, MultipartFile>((ref, data) async {
  await ref.watch(profileRepositoryProvider).changeProfilePicture(data);
});
