import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  // static Future<bool> requestStoragePermission() async {
  //   PermissionStatus status = await Permission.storage.request();
  //   if (status.isGranted) {
  //     return true;
  //   } else if (status.isPermanentlyDenied) {
  //     openAppSettings();
  //   }
  //   return false;
  // }
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
