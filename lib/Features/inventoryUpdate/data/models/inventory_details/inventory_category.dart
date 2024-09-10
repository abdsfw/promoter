import 'category.dart';

class InventoryCategory {
  int? id;
  num? amount;
  num? spExpenses;
  Category? category;

  InventoryCategory({this.id, this.amount, this.spExpenses, this.category});

  factory InventoryCategory.fromJson(Map<String, dynamic> json) {
    return InventoryCategory(
      id: json['id'] as int?,
      amount: json['amount'] as num?,
      spExpenses: json['sp_expenses'] as num?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'amount': amount,
        'sp_expenses': spExpenses,
        'category': category?.toJson(),
      };
}
