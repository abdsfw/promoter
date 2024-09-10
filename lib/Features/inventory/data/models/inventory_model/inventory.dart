import 'inventory_category.dart';

class Inventory {
  int? id;
  var totalPrice;
  var totalAmount;
  List<InventoryCategory>? inventoryCategory;

  Inventory({
    this.id,
    this.totalPrice,
    this.totalAmount,
    this.inventoryCategory,
  });

  factory Inventory.fromJson(Map<String, dynamic> json) => Inventory(
        id: json['id'] as int?,
        totalPrice: json['total_price'],
        totalAmount: json['total_amount'],
        inventoryCategory: (json['inventory_category'] as List<dynamic>?)
            ?.map((e) => InventoryCategory.fromJson(e as Map<String, dynamic>))
            .toList(),
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'total_price': totalPrice,
        'total_amount': totalAmount,
        'inventory_category':
            inventoryCategory?.map((e) => e.toJson()).toList(),
      };
}
