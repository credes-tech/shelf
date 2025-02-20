import 'package:my_shelf_project/modules/home/data/datasource/local/audio_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/datasource/local/media_hive_service.dart';
import 'package:my_shelf_project/modules/home/data/repositories/audio_repo_impl.dart';
import 'package:my_shelf_project/modules/home/data/repositories/media_repo_impl.dart';


class FileValidator {


  static bool isValidAudioFile(String filePath) {
    List<String> allowedFormats = ['mp3', 'wav', 'aac', 'm4a', 'flac', 'ogg'];
    String fileExtension = filePath.split('.').last.toLowerCase();
    return allowedFormats.contains(fileExtension);
  }

  static Future<bool> isDuplicateAudioFile(String filePath) async {
    String fileName = filePath.split('/').last;
    final audioRepository = AudioRepository(AudioHiveService());
    return await audioRepository.isAudioExists(fileName);
  }

  static bool isValidMediaFile(String filePath) {
    List<String> mediaFormats = [
      "jpg", "png", "gif", "webp", "mp4", "mov", "avi", "mkv"];
    String fileExtension = filePath.split('.').last.toLowerCase();
    return mediaFormats.contains(fileExtension);
  }

  static Future<bool> isDuplicateMediaFile(String filePath) async {
    String fileName = filePath.split('/').last;
    final mediaRepository = MediaRepository(MediaHiveService());
    return await mediaRepository.isMediaExists(fileName);
  }

}