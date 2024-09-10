class Category {
  int? id;
  String? nameAr;
  String? nameEn;
  var price;
  // String? photo;
  // String? source;
  // String? type;
  // String? schoolType;
  // bool? visibility;
  // DateTime? createdAt;
  // DateTime? updatedAt;

  Category({
    this.id,
    this.nameAr,
    this.nameEn,
    this.price,
    // this.photo,
    // this.source,
    // this.type,
    // this.schoolType,
    // this.visibility,
    // this.createdAt,
    // this.updatedAt,
  });

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as int?,
        nameAr: json['name_ar'] as String?,
        nameEn: json['name_en'] as String?,
        price: json['price'],
        // photo: json['photo'] as String?,
        // source: json['source'] as String?,
        // type: json['type'] as String?,
        // schoolType: json['school_type'] as String?,
        // visibility: json['visibility'] as bool?,
        // createdAt: json['createdAt'] == null
        //     ? null
        //     : DateTime.parse(json['createdAt'] as String),
        // updatedAt: json['updatedAt'] == null
        //     ? null
        //     : DateTime.parse(json['updatedAt'] as String),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name_ar': nameAr,
        'name_en': nameEn,
        'price': price,
        // 'photo': photo,
        // 'source': source,
        // 'type': type,
        // 'school_type': schoolType,
        // 'visibility': visibility,
        // 'createdAt': createdAt?.toIso8601String(),
        // 'updatedAt': updatedAt?.toIso8601String(),
      };
}
