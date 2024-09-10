import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:ui/model/data.dart';


Future<List<ChartData>> fetchCharts() async {
  final response = await http.get(Uri.parse('http://localhost:8080/charts'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => ChartData.fromJson(json)).toList();
  } else {
    throw Exception('차트를 가져오는 데 실패했습니다.');
  }
}

Future<void> downloadExample() async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/charts/download'));

  if (response.statusCode == 200) {
    final bytes = response.bodyBytes;

    // 저장할 디렉토리를 가져옵니다.
    final directory = await getExternalStorageDirectory();
    if (directory == null) {
      throw Exception("다운로드 폴더에 접근하지 못했습니다.");
    }

    final filePath = '${directory.path}/sample.xlsx';
    final file = File(filePath);

    // 파일에 데이터를 기록합니다.
    await file.writeAsBytes(bytes);

    print("File saved to $filePath");
  } else {
    throw Exception('파일 다운로드에 실패했습니다.. Status code: ${response.statusCode}');
  }
}

Future<void> sendFileToServer(Uint8List fileBytes, String title) async {
  try {
    final request = http.MultipartRequest(
      'POST',
      Uri.parse('http://localhost:8080/charts/upload'), // 서버의 업로드 URL
    );

    request.files.add(http.MultipartFile.fromBytes(
      'file',
      fileBytes,
      filename: title,
    ));
    request.fields['title'] = title;

    final response = await request.send();

    // 응답 처리
    if (response.statusCode == 200) {
      print('파일 업로드 성공');
    } else {
      print('파일 업로드 실패. 상태 코드: ${response.statusCode}');
    }
  } catch (e) {
    print('파일 업로드 중 오류 발생: $e');
  }
}
