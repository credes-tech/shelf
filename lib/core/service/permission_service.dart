import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  /// Request Storage Permission
  Future<bool> requestStoragePermission() async {
    // Check if permission is already granted
    if (await Permission.storage.isGranted) {
      return true;
    }

    // Request permission
    var status = await Permission.storage.request();

    // Return true if granted, false otherwise
    return status == PermissionStatus.granted;
  }

  /// Request Storage Permission for Android 13+
  Future<bool> requestMediaPermission() async {
    if (await Permission.photos.isGranted &&
        await Permission.videos.isGranted &&
        await Permission.audio.isGranted) {
      return true;
    }

    var statusImages = await Permission.photos.request();
    var statusVideos = await Permission.videos.request();
    var statusAudio = await Permission.audio.request();

    return statusImages == PermissionStatus.granted &&
        statusVideos == PermissionStatus.granted &&
        statusAudio == PermissionStatus.granted;
  }
}
