import 'package:file_picker/file_picker.dart';

class UploadCVFileLocalSource {
  UploadCVFileLocalSource();

  Future getLocalFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();

    if (result != null) {
      PlatformFile file = result.files.first;

      return file;
    } else {}
  }

  Future uploadCVFile() async {}
}
