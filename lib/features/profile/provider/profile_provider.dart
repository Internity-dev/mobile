import '../../../shared/riverpod_and_hooks.dart';
import '../model/profile_model.dart';
import '../repository/profile_repository.dart';

final profileProvider = FutureProvider.autoDispose<UserModel>((ref) async {
  return await ref.watch(profileRepositoryProvider).getProfile();
});
