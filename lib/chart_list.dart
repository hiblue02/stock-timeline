import 'dart:html' as html;

import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:ui/app_colors.dart';
import 'package:ui/app_style.dart';

import 'flow_chart.dart';

// 샘플 데이터 모델
class ChartData {
  final String title;
  final String xAxisName;
  final String yAxisName;
  final DateTime updateDateTime;

  ChartData(
      {required this.title,
      required this.xAxisName,
      required this.yAxisName,
      required this.updateDateTime});
}

// 샘플 데이터 생성
List<ChartData> getSampleCharts() {
  return [
    ChartData(
      title: "월별 판매량",
      xAxisName: "월",
      yAxisName: "판매량",
      updateDateTime: DateTime.now(),
    ),
    ChartData(
      title: "주별 방문자 수",
      xAxisName: "주",
      yAxisName: "방문자 수",
      updateDateTime: DateTime.now(),
    ),
    ChartData(
      title: "연도별 수익",
      xAxisName: "연도",
      yAxisName: "수익",
      updateDateTime: DateTime.now(),
    ),
  ];
}

class ChartsListPage extends StatelessWidget {
  const ChartsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 샘플 데이터 가져오기
    final List<ChartData> chartsData = getSampleCharts();

    return Scaffold(
        appBar: AppBar(
          title: Text('Charts Data Table'),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: DataTable(
                  headingTextStyle: const TextStyle(
                      color: AppColors.mainBlue, fontWeight: FontWeight.bold),
                  // columnSpacing: constraints.maxWidth / 6, // 열 사이 간격 설정
                  columns: [
                    DataColumn(label: Container(width: 300, child: Text('제목'))),
                    DataColumn(
                        label: Container(width: 300, child: Text('X축 이름'))),
                    DataColumn(
                        label: Container(width: 300, child: Text('Y축 이름'))),
                    DataColumn(
                        label: Container(width: 100, child: Text('업데이트 날짜'))),
                    DataColumn(
                        label: Container(width: 80, child: Text('수정하기'))),
                    DataColumn(
                        label: Container(width: 80, child: Text('자료받기'))),
                    DataColumn(label: Container(width: 80, child: Text('그래프')))
                  ],
                  rows: chartsData.map((chart) {
                    return DataRow(
                      cells: [
                        DataCell(Text(chart.title)),
                        DataCell(Text(chart.xAxisName)),
                        DataCell(Text(chart.yAxisName)),
                        DataCell(Text(chart.updateDateTime.toString())),
                        DataCell(appButton("수정하기", () {})),

                        DataCell(appButton("다운로드", () {
                          _downloadExcel();
                        })),
                        DataCell(appButton("그래프", () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const FlowChart()),
                          );
                        })),
                      ],
                    );
                  }).toList(),
                ),
              );
            },
          ),
        ));
  }

  Future<void> _downloadExcel() async {
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

    // Blob 객체를 생성하고 다운로드 링크를 만들기
    final blob = html.Blob([bytes]);
    final url = html.Url.createObjectUrlFromBlob(blob);
    final anchor = html.AnchorElement(href: url)
      ..setAttribute('download', 'data.xlsx')
      ..click();

    // 다운로드 후 URL 해제
    html.Url.revokeObjectUrl(url);
  }
}
