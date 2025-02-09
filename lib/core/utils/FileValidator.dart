

class FileValidator {

  static bool isValidAudioFile(String filePath) {
    List<String> allowedFormats = ['mp3', 'wav', 'aac', 'm4a', 'flac', 'ogg'];
    String fileExtension = filePath.split('.').last.toLowerCase();
    return allowedFormats.contains(fileExtension);
  }

}