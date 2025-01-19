import 'package:permission_handler/permission_handler.dart';

class CheckPermission {
  isStoragePermission() async {
    // check status storage permission
    var status = await Permission.storage.status;
    // jika belum diizinkan
    if (!status.isGranted) {
      // request izin storage
      await Permission.storage.request();
      // cek status storage permission
      return !status.isGranted ? false : true;
    } else {
      // jika sudah diizinkan
      return true;
    }
  }
}
