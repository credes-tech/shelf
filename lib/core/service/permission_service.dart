import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:permission_handler/permission_handler.dart';

Future<int> getAndroidSdkVersion() async {
  if (Platform.isAndroid) {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo.version.sdkInt;
  }
  return 0;
}

class PermissionService {
  static Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      await openAppSettings();
    }
    return false;
  }

  static Future<bool> requestAudioPermission() async {
    if (Platform.isAndroid) {
      int sdkInt = await getAndroidSdkVersion();
      if (sdkInt >= 33) {
        // Android 13 and above
        PermissionStatus audioStatus = await Permission.audio.request();
        if (audioStatus.isGranted) {
          return true;
        } else if (audioStatus.isPermanentlyDenied) {
          await openAppSettings();
        } else {
          return false;
        }
      } else {
        // Android 12 and below
        var status = await PermissionService.requestStoragePermission();
        if (status) {
          return true;
        } else {
          return false;
        }
      }
    } else if (Platform.isIOS) {
      var status = await Permission.audio.request();
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static Future<bool> requestMediaPermission() async {
    if (Platform.isAndroid) {
      int sdkInt = await getAndroidSdkVersion();
      if (sdkInt >= 33) {
        // Android 13 and above
        PermissionStatus photoStatus = await Permission.photos.request();
        PermissionStatus videoStatus = await Permission.videos.request();
        if (photoStatus.isGranted && videoStatus.isGranted) {
          return true;
        } else if (photoStatus.isPermanentlyDenied ||
            videoStatus.isPermanentlyDenied) {
          await openAppSettings();
        } else {
          return false;
        }
      } else {
        // Android 12 and below
        var status = await PermissionService.requestStoragePermission();
        if (status) {
          return true;
        } else {
          return false;
        }
      }
    } else if (Platform.isIOS) {
      var status = await Permission.mediaLibrary.request();
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static Future<bool> requestFilePermission() async {
    if (Platform.isAndroid) {
      int sdkInt = await getAndroidSdkVersion();
      if (sdkInt >= 33) {
        // Android 13 and above
        PermissionStatus fileStatus =
            await Permission.manageExternalStorage.request();
        if (fileStatus.isGranted) {
          return true;
        } else if (fileStatus.isPermanentlyDenied) {
          await openAppSettings();
        } else {
          return false;
        }
      } else {
        // Android 12 and below
        var status = await PermissionService.requestStoragePermission();
        if (status) {
          return true;
        } else {
          return false;
        }
      }
    } else if (Platform.isIOS) {
      var status = await Permission.storage.request();
      if (status.isGranted) {
        return true;
      } else {
        return false;
      }
    }
    return false;
  }

  static Future<bool> checkStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    return status.isGranted;
  }
}
