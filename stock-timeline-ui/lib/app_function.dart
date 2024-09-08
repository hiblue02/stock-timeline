import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';
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
