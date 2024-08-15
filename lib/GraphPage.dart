import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'AppColors.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  _LineChart createState() => _LineChart();
}

class _LineChart extends State<GraphPage> {
  int? selectedPointIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('테슬라 주식 변화 1900~2100')),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(80, 30, 80, 10),
            child: LineChart(sampleData)));
  }

  final List<double> spotData_amount = [
    10.0,
    20.0,
    30.0,
    40.0,
    50.0,
    60.0,
    70.0,
    80.0,
    90.0,
  ];

  final List<String> spotData_Date = [
    '2024-01-01',
    '2024-01-02',
    '2024-01-03',
    '2024-01-04',
    '2024-01-05',
    '2024-01-06',
    '2024-01-07',
    '2024-01-08',
    '2024-01-09',
  ];

  double get minY => spotData_amount.reduce((a, b) => a < b ? a : b) - 5;
  double get maxY => spotData_amount.reduce((a, b) => a > b ? a : b) + 5;
  double get intervalY => (maxY - minY) / spotData_amount.length;

  LineChartData get sampleData => LineChartData(
        lineTouchData: lineTouchData,
        gridData: gridData,
        titlesData: titlesData,
        borderData: borderData,
        lineBarsData: lineBarsData,
        minX: 0,
        maxX: spotData_Date.length.toDouble() - 1,
        minY: minY,
        maxY: maxY,
      );

  FlTitlesData get titlesData => FlTitlesData(
        bottomTitles: AxisTitles(
          sideTitles: bottomTitles,
        ),
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        leftTitles: AxisTitles(
          sideTitles: leftTitles(),
        ),
      );

  LineTouchData get lineTouchData => LineTouchData(
        handleBuiltInTouches: true,
        touchTooltipData: LineTouchTooltipData(
          getTooltipColor: (touchedSpot) => AppColors.mainBeige,
        ),
      );

  List<LineChartBarData> get lineBarsData => [
        lineChartBarData,
      ];

  FlGridData get gridData => const FlGridData(show: false);

  FlBorderData get borderData => FlBorderData(
        show: true,
        border: Border(
          bottom:
              BorderSide(color: AppColors.mainBlue.withOpacity(0.2), width: 2),
          left: const BorderSide(color: Colors.transparent),
          right: const BorderSide(color: Colors.transparent),
          top: const BorderSide(color: Colors.transparent),
        ),
      );

  LineChartBarData get lineChartBarData => LineChartBarData(
      isCurved: true,
      color: AppColors.mainBlue,
      barWidth: 3,
      isStrokeCapRound: true,
      dotData: const FlDotData(show: true),
      belowBarData: BarAreaData(show: false),
      spots: List.generate(spotData_Date.length,
          (index) => FlSpot(index.toDouble(), spotData_amount[index])));

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    return Text(value.toString(), style: style, textAlign: TextAlign.center);
  }

  SideTitles leftTitles() => SideTitles(
        getTitlesWidget: leftTitleWidgets,
        showTitles: true,
        interval: intervalY,
        reservedSize: 50,
      );

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    const style = TextStyle(
      fontWeight: FontWeight.normal,
      fontSize: 10,
    );
    int index = value.toInt();
    if (index >= 0 && index < spotData_Date.length) {
      return Transform.rotate(
        angle: -0.8,
        child: Container(
          margin: const EdgeInsets.only(top: 20.0), // 위쪽 여백 추가
          child: Text(
            spotData_Date[index],
            style: style,
            textAlign: TextAlign.center,
          ),
        ),
      );
    } else {
      return const Text('');
    }
  }

  SideTitles get bottomTitles => SideTitles(
        showTitles: true,
        reservedSize: 100,
        interval: 1,
        getTitlesWidget: bottomTitleWidgets,
      );


  Widget buildTooltips() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(spotData_Date.length, (index) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5.0),
          child: Column(
            children: [
              Text(spotData_Date[index]),
              Container(
                margin: const EdgeInsets.only(top: 5.0),
                padding: const EdgeInsets.all(5.0),
                decoration: BoxDecoration(
                  color: Colors.blueGrey.withOpacity(0.8),
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  spotData_amount[index].toString(),
                  style: const TextStyle(color: Colors.white),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }
}

