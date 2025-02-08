import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';

class FilePickerService {
  Future<File?> pickFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
      );
      if (result != null) {
        return File(result.files.single.path!);
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error picking file: $e");
      }
    }
    return null;
  }
}
