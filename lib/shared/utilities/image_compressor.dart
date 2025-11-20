import 'dart:io';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

class ImageCompressor {
  /// Compresses an image until it's under 2MB
  static Future<File> compressImage(File file) async {
    const maxSizeInBytes = 2 * 1024 * 1024; // 2MB
    int quality = 90;
    File compressedFile = file;

    while (compressedFile.lengthSync() > maxSizeInBytes && quality > 10) {
      final dir = await getTemporaryDirectory();
      final targetPath = path.join(
        dir.path,
        '${DateTime.now().millisecondsSinceEpoch}_compressed.jpg',
      );

      final result = await FlutterImageCompress.compressAndGetFile(
        file.absolute.path,
        targetPath,
        quality: quality,
      );

      if (result == null) break;

      compressedFile = File(result.path);
      quality -= 10; // reduce quality gradually
    }

    return compressedFile;
  }
}
