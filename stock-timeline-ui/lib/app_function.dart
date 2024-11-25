import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';

Future<Uint8List?> uploadExcel() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx'],
  );

  if (result == null || result.files.isEmpty) {
    throw Exception("파일이 선택되지 않았습니다.");
  }

  return result.files.single.bytes;
}
