import 'package:internity/shared/riverpod_and_hooks.dart';

import '../model/post_presences_model.dart';
import '../repository/presences_repository.dart';

final presencesPostProvider = FutureProvider.autoDispose
    .family<void, PostPresencesModel>((ref, PostPresencesModel data) {
  return ref.watch(presencesRepositoryProvider).postPresences(data);
});
