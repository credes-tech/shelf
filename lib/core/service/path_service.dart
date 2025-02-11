import 'dart:io';

import 'package:path_provider/path_provider.dart';

class DirectoryPathService {


  static Future<String?> getAudioFilePath(File file) async {
    try{
      final appDir = await getApplicationDocumentsDirectory();
      Directory subDir = Directory("${appDir.path}/Audio");
      if (!await subDir.exists()) {
        await subDir.create(recursive: true);
      }
      return "${subDir.path}/${file.uri.pathSegments.last}";
    }catch(err){
      return null;
    }
  }

}