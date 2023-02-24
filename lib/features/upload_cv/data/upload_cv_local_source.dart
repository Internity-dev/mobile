import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../shared/riverpod_and_hooks.dart';

class UploadCVFileLocalSource {
  UploadCVFileLocalSource({required this.dio, required this.ref});

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

      final prefs = await SharedPreferences.getInstance();

      var response = await dio.post(
        'api/resumes',
        data: formData,
        options: Options(
          headers: {
            'Accept': 'application/json',
            'Content-type': 'multipart/form-data',
            'Authorization': 'Bearer ${prefs.getString('token')}',
          },
        ),
      );

      print(response);

      return response;
    } catch (e) {
      rethrow;
    }
  }
}
