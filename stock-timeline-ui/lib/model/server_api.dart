import 'dart:convert';
import 'dart:typed_data';

import 'package:excel/excel.dart';
import 'package:http/http.dart' as http;
import 'package:ui/model/data.dart';

Future<List<RecordData>> fetchDayRecord(int chartId) async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/charts/$chartId/day'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => RecordData.fromJson(json)).toList();
  } else {
    throw Exception("일간 데이터를 가져오는데 실패했습니다.");
  }
}

Future<List<RecordData>> fetchWeekRecord(int chartId) async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/charts/$chartId/week'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => RecordData.fromJson(json)).toList();
  } else {
    throw Exception("주간 데이터를 가져오는데 실패했습니다.");
  }
}

Future<List<RecordData>> fetchMonthRecord(int chartId) async {
  final response =
      await http.get(Uri.parse('http://localhost:8080/charts/$chartId/month'));

  if (response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => RecordData.fromJson(json)).toList();
  } else {
    throw Exception("월간 데이터를 가져오는데 실패했습니다.");
  }
}

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

    var excel = Excel.decodeBytes(bytes);
    excel.save(fileName: 'sample.xlsx');
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

Future<void> downloadChart(ChartData chart) async {
  final response =
  await http.get(Uri.parse('http://localhost:8080/charts/${chart.id}/download'));

  if (response.statusCode == 200) {
    final bytes = response.bodyBytes;

    var excel = Excel.decodeBytes(bytes);
    excel.save(fileName: '${chart.title}.xlsx');
  } else {
    throw Exception('파일 다운로드에 실패했습니다.. Status code: ${response.statusCode}');
  }
}
