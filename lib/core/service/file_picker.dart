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

  static Future<List<File>?> pickAudioFile() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['mp3', 'aac', 'wav'],
      );
      if (result != null) {
        List<File> files = result.paths.map((path) => File(path!)).toList();
        return files;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error picking file: $e");
      }
    }
  }
}
