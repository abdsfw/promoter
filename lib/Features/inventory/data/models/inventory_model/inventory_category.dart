import 'category.dart';

class InventoryCategory {
  int? id;
  var amount;
  Category? category;

  InventoryCategory({this.id, this.amount, this.category});

  factory InventoryCategory.fromJson(Map<String, dynamic> json) {
    return InventoryCategory(
      id: json['id'] as int?,
      amount: json['amount'],
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'category': category?.toJson(),
      };
}
