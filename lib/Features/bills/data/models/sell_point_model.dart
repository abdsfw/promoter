class SellPointModel {
  int? id;
  String? name;

  SellPointModel({this.id, this.name});

  factory SellPointModel.fromJson(Map<String, dynamic> json) {
    return SellPointModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
      };
}
