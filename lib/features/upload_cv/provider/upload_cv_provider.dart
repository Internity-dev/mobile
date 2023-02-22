import 'package:internity/shared/riverpod_and_hooks.dart';

import '../../../shared/provider/dio_provider.dart';
import '../data/upload_cv_local_source.dart';

final uploadCVProvider = Provider((ref) {
  return UploadCVFileLocalSource(dio: ref.watch(dioProvider(null)), ref: ref);
});
