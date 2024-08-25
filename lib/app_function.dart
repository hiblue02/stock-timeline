import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';

Future<void> uploadExcel() async {
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

Future<void> downloadExcel() async {
  // 엑셀 파일 생성
  var excel = Excel.createExcel();
  Sheet sheet = excel['Sheet1'];

  // 샘플 데이터
  List<List<String>> data = [
    ['제목', 'X축 이름', 'Y축 이름'],
    ['월별 판매량', '월', '판매량'],
    ['주별 방문자 수', '주', '방문자 수'],
    ['연도별 수익', '연도', '수익'],
    ['분기별 성장률', '분기', '성장률'],
    ['분야별 점유율', '분야', '점유율'],
    ['연도별 비용', '연도', '비용'],
  ];

  // 데이터 추가
  for (var row in data) {
    sheet.appendRow(row);
  }

  // Excel 파일을 Uint8List로 변환
  var bytes = excel.encode();

  final directory = await getApplicationDocumentsDirectory();
  final path = "${directory.path}/data.xlsx";
  final file = File(path);
  await file.writeAsBytes(bytes!);
}
