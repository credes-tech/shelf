import 'dart:io';
import 'package:share_plus/share_plus.dart';

class ShareService {
  static Future<void> shareFile(String filePath, {String? message}) async {
    try {
      File file = File(filePath);
      if (!await file.exists()) {
        return;
      }
      await Share.shareXFiles([XFile(filePath)]);
    } catch (e) {
      print("Error sharing file: $e");
    }
  }
}
