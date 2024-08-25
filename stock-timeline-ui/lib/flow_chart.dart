import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class FlowChart extends StatelessWidget {
  const FlowChart({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Syncfusion Flutter Charts Demo'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SfCartesianChart(
          primaryXAxis: CategoryAxis(
            title: AxisTitle(text: 'X Axis Title'), // X축 제목
          ),
          primaryYAxis: NumericAxis(
            title: AxisTitle(text: 'Y Axis Title'), // Y축 제목
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
            LineSeries<SalesData, String>(
              dataSource: <SalesData>[
                SalesData('Jan', 35),
                SalesData('Feb', 28),
                SalesData('Mar', 34),
                SalesData('Apr', 32),
                SalesData('May', 40),
              ],
              xValueMapper: (SalesData sales, _) => sales.month,
              yValueMapper: (SalesData sales, _) => sales.sales,
              name: 'Sales',
              color: Colors.blue,
            )
          ],
        ),
      ),
    );
  }
}

class SalesData {
  SalesData(this.month, this.sales);

  final String month;
  final double sales;
}
