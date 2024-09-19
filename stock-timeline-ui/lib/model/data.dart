// 샘플 데이터 모델


class ChartData {
  final int id;
  late final String title;
  final DateTime updateDateTime;

  ChartData(
      {required this.id, required this.title, required this.updateDateTime});

  factory ChartData.fromJson(Map<String, dynamic> json) {
    return ChartData(
      id: json['id'],
      title: json['title'],
      updateDateTime: DateTime.parse(json['updateDateTime']),
    );
  }
}

class RecordData {
  final DateTime date;
  final double price;
  final String description;

  RecordData(
      {
      required this.date,
      required this.price,
      required this.description});

  factory RecordData.fromJson(Map<String, dynamic> json) {
    return RecordData(
        date: DateTime.parse(json['date']),
        price: json['price'],
        description: json['description']);
  }
}
