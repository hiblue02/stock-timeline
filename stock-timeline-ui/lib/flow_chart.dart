import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:ui/model/server_api.dart';

import 'model/data.dart';

class FlowChart extends StatefulWidget {
  final int chartId;

  const FlowChart({super.key, required this.chartId});

  @override
  State createState() => _FlowChartState();
}

class _FlowChartState extends State<FlowChart> {
  late Future<List<RecordData>> recordsFuture;

  @override
  void initState() {
    super.initState();
    recordsFuture = fetchDayRecord(widget.chartId);
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Syncfusion Flutter Charts Demo'),
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
                  title: AxisTitle(text: 'price'), // X축 제목
                ),
                primaryYAxis: NumericAxis(
                  title: AxisTitle(text: 'date'), // Y축 제목
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
                ),
                series: <CartesianSeries>[
                  LineSeries<RecordData, String>(
                    dataSource: records,
                    xValueMapper: (RecordData record, _) =>
                        DateFormat('yyyy-MM-dd').format(record.date),
                    yValueMapper: (RecordData record, _) =>
                        record.price,
                    name: 'Day',
                    color: Colors.blue,
                  )
                ],
              );
            },
          ),
        ));
  }
}
