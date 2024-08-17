import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import 'app_colors.dart';
import 'description_with_line.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({super.key});

  @override
  _LineChart createState() => _LineChart();
}

class _LineChart extends State<GraphPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('테슬라 주식 변화 1900~2100')),
        body: Padding(
            padding: const EdgeInsets.fromLTRB(30, 30, 100, 30),
            child: Stack(children: [
              LineChart(sampleData),
              Positioned.fill(child: description)
            ])));
  }

  Stack get description => Stack(
          children: List.generate(spotData_Date.length, (index) {
        double chartHeight = MediaQuery.of(context).size.height;
        double chartWidth = MediaQuery.of(context).size.width;
        double positionX = ((chartWidth + 30) / spotData_Date.length) * (index) ;
        double amount = spotData_amount[index];
        double positionY = ((amount - minY) / (maxY - minY)) * (chartHeight-80);

        return DescriptionWithLine(
            description: spotData_description[index],
            positionX: positionX,
            positionY: positionY,
            chartHeight: chartHeight,
            chartWidth: chartWidth);
      }));

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

  final List<String> spotData_description = [
    '날이 밝으면 태양이 당신에게 새로운 힘을 주기를',
    '밤이 되면 달이 당신을 부드럽게 회복시켜 주기를',
    '비가 당신의 근심걱정을 모두 씻어 주기를',
    '산들바람이 당신의 몸에 새로운 활력을 불어넣어 주기를',
    '당신이 이 세상을 사뿐사뿐 걸어갈 수 있기를',
    '당신이 살아 있는 동안 내내 그 아름다움을 깨닫게 되기를',
    '아파치족의 기도',
    '어도비',
    '옥수수가 익어가는 달',
  ];

  double get minY => spotData_amount.reduce((a, b) => a < b ? a : b) - 10;

  double get maxY => spotData_amount.reduce((a, b) => a > b ? a : b) + 10;

  double get intervalY => double.parse(((maxY - minY) / spotData_amount.length).toStringAsFixed(2));

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
            tooltipBorder: const BorderSide(color: AppColors.mainBlue),
            maxContentWidth: 500,
            getTooltipColor: (color) => Colors.white,
            getTooltipItems: (touchedSpots) {
              return touchedSpots.map((touchedSpot) {
                int index = touchedSpot.x.toInt();
                return LineTooltipItem(spotData_description[index],
                    const TextStyle(color: AppColors.mainBlue));
              }).toList();
            }),
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
}
