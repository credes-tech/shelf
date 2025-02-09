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

  //
  // static Future<void> requestMediaPermission() async {
  //   final videoPermission = Permission.videos;
  //   final imagePermission = Permission.photos;
  //
  //   if (await videoPermission.isDenied) {
  //     await videoPermission.request();
  //   }
  //   if (await imagePermission.isDenied) {
  //     await imagePermission.request();
  //   }
  // }

  // static Future<bool> checkMediaPermission() async {
  //   PermissionStatus videoStatus = await Permission.videos.status;
  //   PermissionStatus photosStatus = await Permission.photos.status;
  //   if (videoStatus.isGranted && photosStatus.isGranted) {
  //     return true;
  //   } else {
  //     return false;
  //   }
  // }
  //
  // //  check if the permission is granted or not previously.
  // static Future<bool> checkAudioPermission() async {
  //   PermissionStatus status = await Permission.audio.status;
  //   return status.isGranted;
  // }

  static Future<bool> checkStoragePermission() async {
    PermissionStatus status = await Permission.storage.status;
    return status.isGranted;
  }
}
