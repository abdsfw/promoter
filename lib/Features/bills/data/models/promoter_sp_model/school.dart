class School {
  int? id;
  String? nameAr;
  String? nameEn;
  String? region;
  String? type;
  DateTime? createdAt;
  DateTime? updatedAt;

  School({
    this.id,
    this.nameAr,
    this.nameEn,
    this.region,
    this.type,
    this.createdAt,
    this.updatedAt,
  });

  factory School.fromJson(Map<String, dynamic> json) => School(
        id: json['id'] as int?,
        nameAr: json['name_ar'] as String?,
        nameEn: json['name_en'] as String?,
        region: json['region'] as String?,
        type: json['type'] as String?,
        createdAt: json['createdAt'] == null
            ? null
            : DateTime.parse(json['createdAt'] as String),
        updatedAt: json['updatedAt'] == null
            ? null
            : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name_ar': nameAr,
        'name_en': nameEn,
        'region': region,
        'type': type,
        'createdAt': createdAt?.toIso8601String(),
        'updatedAt': updatedAt?.toIso8601String(),
      };
}
