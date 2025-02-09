import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class PermissionService {
  static Future<bool> requestStoragePermission() async {
    var status = await Permission.storage.request();
    if (status.isGranted) {
      return true;
    } else if (status.isPermanentlyDenied) {
      openAppSettings();
    }
    return false;
  }

  static Future<bool> requestAudioPermission() async {
    if (Platform.isAndroid) {
      var status = await PermissionService.requestStoragePermission();
      if (status) {
        return true;
      } else {
        return false;
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
