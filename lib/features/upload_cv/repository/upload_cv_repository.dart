import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';

import '../../../shared/provider/dio_provider.dart';
import '../../../shared/riverpod_and_hooks.dart';

class UploadCVRepository {
  UploadCVRepository({required this.dio, required this.ref});

  final Dio dio;
  final Ref ref;

  Future<MultipartFile> getLocalFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    try {
      if (result != null && result.files.first.extension == 'pdf') {
        PlatformFile file = result.files.first;
        MultipartFile multipartFile = MultipartFile.fromFileSync(file.path!);

        return multipartFile;
      } else {
        throw 'File yang diupload harus berupa PDF';
      }
    } catch (e) {
      rethrow;
    }
  }

  Future uploadCVFile() async {
    try {
      var file = await getLocalFile();
      var formData = FormData.fromMap({
        "resume": file,
      });

      var response = await dio.post(
        'api/resumes',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-type': 'multipart/form-data',
          },
        ),
      );

      return response;
    } catch (e) {
      rethrow;
    }
  }
}

final uploadCVRepositoryProvider = Provider((ref) {
  return UploadCVRepository(dio: ref.watch(dioProvider), ref: ref);
});
