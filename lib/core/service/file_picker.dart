import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shelf/modules/home/data/datasource/local/audio_hive_service.dart';

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
    List<File>? files;
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: true,
        type: FileType.custom,
        allowedExtensions: ['mp3', 'aac', 'wav'],
      );
      if (result != null) {
        result.files.forEach((file) async {
          final File nfile = File(file.path!);
          final File savedFile = await saveFileToLocalStorage(nfile, file.name);
          files!.add(savedFile);
          // await AudioHiveService.saveAudioToHive(
          //    file.name, file.extension!, file.bytes as int, DateTime.now());
          print("saved file $savedFile");
        });
        return files;
      }
    } catch (e) {
      if (kDebugMode) {
        print("Error picking file: $e");
      }
    }
  }

  static Future<String> getLocalFilePath(String filename) async {
    final directory = await getApplicationDocumentsDirectory();
    return "${directory.path}/$filename";
  }

  static Future<File> saveFileToLocalStorage(File file, String filename) async {
    final String path = await getLocalFilePath(filename);
    return file.copy(path);
  }
  // static Future<void> storeAudioFile() async {}
}
