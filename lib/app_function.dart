import 'dart:io';

import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

Future<void> uploadFile() async {
  final result = await FilePicker.platform.pickFiles(
    type: FileType.custom,
    allowedExtensions: ['xlsx'],
  );

  if (result != null) {
    var file = File(result.files.single.path!);
    await _readExcelFile(file.path);
  } else {
    print('No file selected');
  }
}

Future<void> _readExcelFile(String path) async {
  var file = File(path);
  var bytes = file.readAsBytesSync();
  var excel = Excel.decodeBytes(bytes);

  for (var table in excel.tables.keys) {
    for (var row in excel.tables[table]!.rows) {
      print('$row'); // Print each row
    }
  }
}
