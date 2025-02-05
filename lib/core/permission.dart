import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class CheckPermission {
  Future<bool> isStoragePermission() async {
    // // check status storage permission
    // var status = await Permission.storage.status;
    // // jika belum diizinkan
    // if (!status.isGranted) {
    //   // request izin storage
    //   status = await Permission.storage.request();
    //   // cek status storage permission
    //   //   return !status.isGranted ? false : true;
    //   // } else {
    //   //   // jika sudah diizinkan
    //   //   return true;
    // }
    // return status.isGranted;

    // if (await Permission.storage.request().isGranted) {
    //   return true;
    // }
    // if (await Permission.accessMediaLocation.request().isGranted) {
    //   return true;
    // }
    // if (await Permission.manageExternalStorage.request().isGranted) {
    //   return true;
    // }
    // return false;
    if (Platform.isAndroid) {
      int sdkInt = (await Permission.storage.status).index;
      if (sdkInt < 29) {
        // Android < 10 (API < 29) hanya membutuhkan Permission.storage
        return await _requestPermission(Permission.storage);
      } else if (sdkInt == 29) {
        // Android 10 (API 29) membutuhkan Permission.storage & Permission.accessMediaLocation
        bool storageGranted = await _requestPermission(Permission.storage);
        bool mediaLocationGranted = await _requestPermission(Permission.accessMediaLocation);
        return storageGranted && mediaLocationGranted;
      } else {
        // Android 11+ (API >= 30) membutuhkan Permission.manageExternalStorage
        return await _requestPermission(Permission.manageExternalStorage);
      }
    }
    return false;
  }

  /// Fungsi untuk meminta izin tertentu
  Future<bool> _requestPermission(Permission permission) async {
    if (await permission.isGranted) {
      return true;
    } else {
      var status = await permission.request();
      return status.isGranted;
    }
  }
}
