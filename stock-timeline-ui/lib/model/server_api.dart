
import 'dart:convert';

import 'package:ui/model/data.dart';
import 'package:http/http.dart' as http;

Future<List<ChartData>> fetchCharts() async {
  final response = await http.get(Uri.parse('localhost:8080/charts'));

  if(response.statusCode == 200) {
    List<dynamic> data = json.decode(response.body);
    return data.map((json) => ChartData.fromJson(json)).toList();
  } else {
    throw Exception('차트를 가져오는 데 실패했습니다.');
  }
}
