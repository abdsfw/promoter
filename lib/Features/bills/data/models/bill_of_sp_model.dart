class BillOfSpModel {
  int? id;
  DateTime? date;
  String? type;

  BillOfSpModel({this.id, this.date, this.type});

  factory BillOfSpModel.fromJson(Map<String, dynamic> json) => BillOfSpModel(
        id: json['id'] as int?,
        date: json['date'] == null
            ? null
            : DateTime.parse(json['date'] as String),
        type: json['type'] as String,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'date': date?.toIso8601String(),
        'type': type,
      };
}
