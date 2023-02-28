import 'package:internity/shared/riverpod_and_hooks.dart';

import '../../../shared/provider/dio_provider.dart';
import '../repository/upload_cv_repository.dart';

final uploadCVProvider = Provider((ref) {
  return ref.watch(uploadCVRepositoryProvider);
});
