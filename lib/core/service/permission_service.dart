import 'package:permission_handler/permission_handler.dart';

class PermissionService {

  static Future<bool> requestStoragePermission() async {
    PermissionStatus status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    return false;
  }

  static Future<bool> checkStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    return status.isGranted;
  }

  static Future<void> openSettings() async {
    await openAppSettings();
  }
}
