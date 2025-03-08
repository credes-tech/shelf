import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_shelf_project/core/utils/FileValidator.dart';

class FilePickerService {

  static Future<String?> getFilePath(List<String> allowedFormat) async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowMultiple: false,
        allowedExtensions: allowedFormat
      );
      if (result != null) {
        return result.files.single.path!;
      } else {
        return null;
      }
  }

  Future<String?> pickAudioFile() async {
    List<String> allowedFormat = ['mp3', 'wav', 'aac', 'm4a', 'flac', 'ogg'];
    String? audioFilePath = await getFilePath(allowedFormat);
    if(FileValidator.isValidAudioFile(audioFilePath!) && !(await FileValidator.isDuplicateAudioFile(audioFilePath))){
      String? audioPath = await saveFileToLocalStorage(audioFilePath,"Audio");
      return audioPath;
    }
    return null;
  }

  Future<String?> pickMediaFile() async {
    List<String> allowedFormat = ["jpg", "png", "gif", "webp", "mp4", "mov", "mkv"];
    String? mediaFilePath = await getFilePath(allowedFormat);
    if(FileValidator.isValidMediaFile(mediaFilePath!) && !(await FileValidator.isDuplicateMediaFile(mediaFilePath))){
      String? mediaPath = await saveFileToLocalStorage(mediaFilePath,"Media");
      return mediaPath;
    }
    return null;
  }

  Future<String?> pickDocFile() async {
    List<String> allowedFormat = ['pdf'];
    String? docFilePath = await getFilePath(allowedFormat);
    if(FileValidator.isValidDocFile(docFilePath!) && !(await FileValidator.isDuplicateDocFile(docFilePath))){
      String? filePath = await saveFileToLocalStorage(docFilePath,"Files");
      return filePath;
    }
    return null;
  }



  static Future<String?> saveFileToLocalStorage(String filePath,String type) async {
    try {
      File originalFile = File(filePath);
      String newFilePath = await getLocalFilePath(originalFile,type) as String;
      await originalFile.copy(newFilePath);
      return newFilePath;
    } catch (e) {
      return null;
    }
  }


  static Future<String?> getLocalFilePath(File file,String dir) async {
    try{
      final appDir = await getApplicationDocumentsDirectory();
      Directory subDir = Directory("${appDir.path}/$dir");
      if (!await subDir.exists()) {
        await subDir.create(recursive: true);
      }
      return "${subDir.path}/${file.uri.pathSegments.last}";
    }catch(err){
      return null;
    }
  }

}
