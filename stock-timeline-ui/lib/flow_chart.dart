import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ui/model/server_api.dart';

import 'model/data.dart';

class FlowChart extends StatefulWidget {
  final ChartData chart;

  const FlowChart({super.key, required this.chart});

  @override
  State createState() => _FlowChartState();
}

class _FlowChartState extends State<FlowChart> {
  late Future<List<RecordData>> recordsFuture;

  @override
  void initState() {
    super.initState();
    recordsFuture = fetchDayRecord(widget.chart.id);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Center(child: Text(widget.chart.title)),
          actions: [
            Row(children: [
              TextButton(
                  onPressed: () {
                    setState(() {
                      recordsFuture = fetchDayRecord(widget.chart.id);
                    });
                  },
                  child: const Text("Day")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      recordsFuture = fetchWeekRecord(widget.chart.id);
                    });
                  },
                  child: const Text("Week")),
              TextButton(
                  onPressed: () {
                    setState(() {
                      recordsFuture = fetchMonthRecord(widget.chart.id);
                    });
                  },
                  child: const Text("Month")),
            ]),
            const SizedBox(width: 50),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<List<RecordData>>(
            future: recordsFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              }
              if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No data available.'));
              }

              final records = snapshot.data!;
              return SfCartesianChart(
                primaryXAxis: CategoryAxis(
                  title: AxisTitle(text: 'date'), // X축 제목
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'price'), // Y축 제목
                ),
                crosshairBehavior: CrosshairBehavior(
                  enable: false,
                  lineColor: Colors.red,
                  lineWidth: 2,
                  activationMode: ActivationMode.singleTap,
                ),
                tooltipBehavior: TooltipBehavior(
                    enable: true,
                    format: 'point.x: point.y',
                    canShowMarker: true,
                    builder: (dynamic data, dynamic point, dynamic series,
                        int pointIndex, int seriesIndex) {
                      final record = records[pointIndex];
                      return Container(
                        padding: EdgeInsets.all(8),
                        color: Colors.black87,
                        child: Text(
                          '${DateFormat('yyyy-MM-dd').format(record.date)} :: ${record.price}\n${record.description}',
                          style: TextStyle(color: Colors.white),
                        ),
                      );
                    }),
                series: <CartesianSeries>[
                  LineSeries<RecordData, String>(
                    dataSource: records,
                    xValueMapper: (RecordData record, _) =>
                        DateFormat('yyyy-MM-dd').format(record.date),
                    yValueMapper: (RecordData record, _) => record.price,
                    color: Colors.blue,
                  )
                ],
              );
            },
          ),
        ));
  }
}
