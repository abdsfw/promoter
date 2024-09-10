import 'inventory_category.dart';

class InventoryDetails {
  int? id;
  num? totalPrice;
  // num? totalExpenses;
  DateTime? date;
  List<InventoryCategory>? inventoryCategory;

  InventoryDetails({
    this.id,
    this.totalPrice,
    // this.totalExpenses,
    this.date,
    this.inventoryCategory,
  });

  factory InventoryDetails.fromJson(Map<String, dynamic> json) {
    return InventoryDetails(
      id: json['id'] as int?,
      totalPrice: json['total_price'] as num?,
      // totalExpenses: json['total_expenses'] as num?,
      date: json['date'] == null
          ? null
          : DateTime.parse(json['date'] as String),
      inventoryCategory: (json['inventory_category'] as List<dynamic>?)
          ?.map((e) => InventoryCategory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'total_price': totalPrice,
        // 'total_expenses': totalExpenses,
        'date': date?.toIso8601String(),
        'inventory_category':
            inventoryCategory?.map((e) => e.toJson()).toList(),
      };
}
