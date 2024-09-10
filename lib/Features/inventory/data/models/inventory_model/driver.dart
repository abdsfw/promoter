class Driver {
  int? id;
  String? nameAr;
  String? nameEn;

  Driver({this.id, this.nameAr, this.nameEn});

  factory Driver.fromJson(Map<String, dynamic> json) => Driver(
        id: json['id'] as int?,
        nameAr: json['name_ar'] as String?,
        nameEn: json['name_en'] as String?,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name_ar': nameAr,
        'name_en': nameEn,
      };
}
