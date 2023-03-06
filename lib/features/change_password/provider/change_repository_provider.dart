import '../../../shared/riverpod_and_hooks.dart';
import '../model/change_password_model.dart';
import '../repository/change_password_repository.dart';

final changePasswordProvider = FutureProvider.autoDispose
    .family<void, ChangePasswordModel>((ref, data) async {
  return await ref.watch(changePasswordRepositoryProvider).changePassword(data);
});
