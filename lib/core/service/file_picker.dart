import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:my_shelf_project/core/utils/FileValidator.dart';

class FilePickerService {

  static Future<String?> getFilePath() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
      );
      if (result != null) {
        return result.files.single.path!;
      } else {
        return null;
      }
  }

  Future<String?> pickAudioFile() async {
    String? audioFilePath = await getFilePath();
    if(FileValidator.isValidAudioFile(audioFilePath!) && !(await FileValidator.isDuplicateAudioFile(audioFilePath))){
      String? audioPath = await saveFileToLocalStorage(audioFilePath,"Audio");
      return audioPath;
    }
    return null;
  }

  Future<String?> pickMediaFile() async {
    String? mediaFilePath = await getFilePath();
    if(FileValidator.isValidMediaFile(mediaFilePath!) && !(await FileValidator.isDuplicateMediaFile(mediaFilePath))){
      String? mediaPath = await saveFileToLocalStorage(mediaFilePath,"Media");
      return mediaPath;
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
