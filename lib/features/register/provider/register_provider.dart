import '../../../shared/riverpod_and_hooks.dart';
import '../model/post_register_model.dart';
import '../repository/register_repository.dart';

final registerProvider =
    FutureProvider.autoDispose.family<void, PostRegisterModel>(
  (ref, data) async {
    return await ref.read(registerRepositoryProvider).register(data);
  },
);
