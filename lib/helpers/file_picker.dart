import 'dart:io';

import 'package:file_picker/file_picker.dart';

Future<File?> pickerFile() async {
  FilePickerResult? result = await FilePicker.platform.pickFiles();
  if(result != null) {
    File file = File(result.files.single.path!);
    return file;
  }
  return null;
}