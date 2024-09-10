import 'category.dart';

class CategoryBillModel {
  int? id;
  var amount;
  var totalPrice;
  // DateTime? createdAt;
  // DateTime? updatedAt;
  // int? billId;
  // int? categoryId;
  Category? category;

  CategoryBillModel({
    this.id,
    this.amount,
    this.totalPrice,
    // this.createdAt,
    // this.updatedAt,
    // this.billId,
    // this.categoryId,
    this.category,
  });

  factory CategoryBillModel.fromJson(Map<String, dynamic> json) {
    return CategoryBillModel(
      id: json['id'] as int?,
      amount: json['amount'],
      totalPrice: json['total_price'],
      // createdAt: json['createdAt'] == null
      //     ? null
      //     : DateTime.parse(json['createdAt'] as String),
      // updatedAt: json['updatedAt'] == null
      //     ? null
      //     : DateTime.parse(json['updatedAt'] as String),
      // billId: json['bill_id'] as int?,
      // categoryId: json['category_id'] as int?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'total_price': totalPrice,
        // 'createdAt': createdAt?.toIso8601String(),
        // 'updatedAt': updatedAt?.toIso8601String(),
        // 'bill_id': billId,
        // 'category_id': categoryId,
        'category': category?.toJson(),
      };
}
