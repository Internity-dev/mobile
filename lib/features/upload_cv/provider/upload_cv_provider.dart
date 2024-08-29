import 'package:internity/shared/riverpod_and_hooks.dart';

import '../repository/upload_cv_repository.dart';

final uploadCVProvider = Provider((ref) {
  return ref.watch(uploadCVRepositoryProvider);
});
