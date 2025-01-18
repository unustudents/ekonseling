import 'dart:io';

import 'package:path_provider/path_provider.dart';

class PathDirectory {
  getPath() async {
    final Directory? tempDir = await getExternalStorageDirectory();
    final filePath = Directory('${tempDir!.path}/ekonseling');
    if (await filePath.exists()) {
      return filePath.path;
    } else {
      await filePath.create(recursive: true);
      return filePath.path;
    }
  }
}
