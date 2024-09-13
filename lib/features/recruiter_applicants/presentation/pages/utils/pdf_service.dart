import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class PdfService {
  Future<String?> loadPdf(String url) async {
    if (url.isEmpty || !Uri.parse(url).isAbsolute) {
      return null;
    }

    try {
      final tempDir = await getTemporaryDirectory();
      final fileName = url.split('/').last;
      final filePath = '${tempDir.path}/$fileName';

      final file = File(filePath);
      if (!await file.exists()) {
        await Dio().download(url, filePath);
      }

      return filePath;
    } catch (e) {
      return null;
    }
  }
}
