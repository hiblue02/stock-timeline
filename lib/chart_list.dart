
import 'package:flutter/material.dart';
import 'package:ui/app_colors.dart';
import 'package:ui/app_style.dart';
import 'package:ui/edit.dart';
import 'package:ui/model/data.dart';
import 'package:ui/app_function.dart';
import 'package:intl/intl.dart';

import 'flow_chart.dart';



class ChartsListPage extends StatelessWidget {
  const ChartsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 샘플 데이터 가져오기
    final List<ChartData> chartsData = getSampleCharts();

    return Scaffold(
        appBar: AppBar(
          title: Text('Chart List'),
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
                    DataColumn(label: Container(width: 300, child: Text('title'))),
                    DataColumn(
                        label: Container(width: 100, child: Text('updated at'))),
                    DataColumn(
                        label: Container(width: 80, child: Text('update'))),
                    DataColumn(
                        label: Container(width: 80, child: Text('download'))),
                    DataColumn(label: Container(width: 80, child: Text('graph')))
                  ],
                  rows: chartsData.map((chart) {
                    return DataRow(
                      cells: [
                        DataCell(Text(chart.title)),
                        DataCell(Text(DateFormat("yyyy-MM-dd HH:mm:ss").format(chart.updateDateTime))),
                        DataCell(appButton("update", () {
                          edit(context, chart);
                        })),

                        DataCell(appButton("download", () {
                          downloadExcel();
                        })),
                        DataCell(appButton("graph", () {
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

}
