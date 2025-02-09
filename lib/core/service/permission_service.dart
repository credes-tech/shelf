import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<void> requestStoragePermission() async {
    final permission = Permission.storage;
    if (await permission.isDenied) {
      await permission.request();
    }
  }

  static Future<void> requestAudioPermission() async {
    final permission = Permission.audio;

    if (await permission.isDenied) {
      await permission.request();
    }
  }

  static Future<void> requestMediaPermission() async {
    final videoPermission = Permission.videos;
    final imagePermission = Permission.photos;

    if (await videoPermission.isDenied) {
      await videoPermission.request();
    }
    if (await imagePermission.isDenied) {
      await imagePermission.request();
    }
  }

  static Future<bool> checkMediaPermission() async {
    PermissionStatus videoStatus = await Permission.videos.status;
    PermissionStatus photosStatus = await Permission.photos.status;
    if (videoStatus.isGranted && photosStatus.isGranted) {
      return true;
    } else {
      return false;
    }
  }

  //  check if the permission is granted or not previously.
  static Future<bool> checkAudioPermission() async {
    PermissionStatus status = await Permission.audio.status;
    return status.isGranted;
  }

  static Future<bool> checkStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    return status.isGranted;
  }

  static Future<void> openSettings() async {
    await openAppSettings();
  }
}
