import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:ui/app_colors.dart';
import 'package:ui/app_function.dart';
import 'package:ui/edit.dart';
import 'package:ui/model/data.dart';
import 'package:ui/model/server_api.dart';

import 'flow_chart.dart';

class ChartsListPage extends StatefulWidget {
  const ChartsListPage({super.key});

  @override
  State<StatefulWidget> createState() => _ChartsListPageState();
}

class _ChartsListPageState extends State<ChartsListPage> {
  late Future<List<ChartData>> charts;

  @override
  void initState() {
    super.initState();
    charts = fetchCharts();
  }

  @override
  Widget build(BuildContext context) {
    final body = FutureBuilder<List<ChartData>>(
        future: charts,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('차트가 없습니다.'));
          } else {
            final rowData = snapshot.data!;
            final DataTable dataTable = DataTable(
              headingTextStyle: const TextStyle(
                  color: AppColors.mainBlue, fontWeight: FontWeight.bold),
              columns: const [
                DataColumn(label: SizedBox(width: 300, child: Text('title'))),
                DataColumn(
                    label: SizedBox(width: 100, child: Text('updated at'))),
                DataColumn(label: SizedBox(width: 80, child: Text('update'))),
                DataColumn(label: SizedBox(width: 80, child: Text('download'))),
                DataColumn(label: SizedBox(width: 80, child: Text('graph')))
              ],
              rows: rowData.map((chart) {
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
                        downloadChart(chart);
                      },
                      child: const Text("download"),
                    )),
                    DataCell(ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => FlowChart(chart: chart)),
                        );
                      },
                      child: const Text("graph"),
                    )),
                  ],
                );
              }).toList(),
            );
            return Align(
              alignment: Alignment.topCenter,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  return SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: dataTable,
                  );
                },
              ),
            );
          }
        });

    return Scaffold(
        appBar: AppBar(
          title: const Center(child: Text('Chart List')),
          actions: [
            Row(children: [
              TextButton(
                  onPressed: () {
                    edit(context, null);
                  },
                  child: const Text("Create")),
              TextButton(
                  onPressed: () {
                    downloadExample();
                  },
                  child: const Text("Example")),
            ]),
            const SizedBox(width: 50),
          ],
        ),
        body: body);
  }
}
