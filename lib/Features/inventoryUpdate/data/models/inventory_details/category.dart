class Category {
  int? id;
  String? nameAr;
  String? nameEn;
  double? price;

  Category({this.id, this.nameAr, this.nameEn, this.price});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json['id'] as int?,
        nameAr: json['name_ar'] as String?,
        nameEn: json['name_en'] as String?,
        price: (json['price'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name_ar': nameAr,
        'name_en': nameEn,
        'price': price,
      };
}
