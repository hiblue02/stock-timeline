
// 샘플 데이터 모델
class ChartData {
  final int id;
  late final String title;
  final DateTime updateDateTime;

  ChartData(
      { required this.id,
        required this.title,
        required this.updateDateTime});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      id: json['id'],
      title: json['title'],
      updateDateTime: DateTime.parse(json['updateDateTime']),
    );
  }
}

// 샘플 데이터 생성
List<ChartData> getSampleCharts() {
  return [
    ChartData(
      id: 1,
      title: "월별 판매량",
      updateDateTime: DateTime.now(),
    ),
    ChartData(
      id: 2,
      title: "주별 방문자 수",
      updateDateTime: DateTime.now(),
    ),
    ChartData(
      id: 3,
      title: "연도별 수익",
      updateDateTime: DateTime.now(),
    ),
  ];
}
