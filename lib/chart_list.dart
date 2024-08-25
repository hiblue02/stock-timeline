import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/app_colors.dart';
import 'package:ui/app_function.dart';
import 'package:ui/edit.dart';
import 'package:ui/model/data.dart';

import 'flow_chart.dart';

class ChartsListPage extends StatelessWidget {
  const ChartsListPage({super.key});

  @override
  Widget build(BuildContext context) {
    // 샘플 데이터 가져오기
    final List<ChartData> chartsData = getSampleCharts();

    final DataTable dataTable = DataTable(
      headingTextStyle: const TextStyle(
          color: AppColors.mainBlue, fontWeight: FontWeight.bold),
      columns: const [
        DataColumn(label: SizedBox(width: 300, child: Text('title'))),
        DataColumn(label: SizedBox(width: 100, child: Text('updated at'))),
        DataColumn(label: SizedBox(width: 80, child: Text('update'))),
        DataColumn(label: SizedBox(width: 80, child: Text('download'))),
        DataColumn(label: SizedBox(width: 80, child: Text('graph')))
      ],
      rows: chartsData.map((chart) {
        return DataRow(
          cells: [
            DataCell(Text(chart.title)),
            DataCell(Text(DateFormat("yyyy-MM-dd HH:mm:ss")
                .format(chart.updateDateTime))),
            DataCell(ElevatedButton(
              onPressed: () {
                edit(context, chart);
              },
              child: const Text("update"),
            )),
            DataCell(ElevatedButton(
              onPressed: () {
                downloadExcel();
              },
              child: const Text("download"),
            )),
            DataCell(ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const FlowChart()),
                );
              },
              child: const Text("graph"),
            )),
          ],
        );
      }).toList(),
    );

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Chart List')),
          actions: [
            Container(
                alignment: Alignment.centerRight,
                child: TextButton(onPressed: () {
                  edit(context, null);
                }, child: const Text("Create"))),
            const SizedBox(width: 50),
          ],
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: LayoutBuilder(
            builder: (context, constraints) {
              return SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: dataTable,
              );
            },
          ),
        ));
  }
}
