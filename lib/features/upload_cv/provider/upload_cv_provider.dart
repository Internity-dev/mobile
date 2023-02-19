import 'package:internity/shared/riverpod_and_hooks.dart';

import '../data/upload_cv_local_source.dart';

final uploadCVProvider = Provider((ref) {
  return UploadCVFileLocalSource();
});
