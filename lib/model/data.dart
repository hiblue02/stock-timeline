// 샘플 데이터 모델
class ChartData {
  late final String title;
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
