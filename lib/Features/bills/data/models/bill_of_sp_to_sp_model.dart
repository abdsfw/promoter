class BillOfSpToSpModel {
  int? id;
  String? type;
  String? toSellPointName;
  DateTime? date;

  BillOfSpToSpModel({
    this.id,
    this.type,
    this.toSellPointName,
    this.date,
  });

  factory BillOfSpToSpModel.fromJson(Map<String, dynamic> json) {
    return BillOfSpToSpModel(
      id: json['id'] as int?,
      type: json['type'] as String?,
      toSellPointName: json['from_sell_point.name'] as String?,
      date: json['date'] == null
          ? null
          : DateTime.parse(json['date'] as String),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'type': type,
        'from_sell_point.name': toSellPointName,
        'date': date?.toIso8601String(),
      };
}
