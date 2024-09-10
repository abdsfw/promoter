import 'driver.dart';
import 'envelop.dart';
import 'inventory.dart';

class InventoryModel {
  int? id;
  String? name;
  Driver? driver;
  List<Envelop>? envelops;
  List<Inventory>? inventories;

  InventoryModel({
    this.id,
    this.name,
    this.driver,
    this.envelops,
    this.inventories,
  });

  factory InventoryModel.fromJson(Map<String, dynamic> json) {
    return InventoryModel(
      id: json['id'] as int?,
      name: json['name'] as String?,
      driver: json['driver'] == null
          ? null
          : Driver.fromJson(json['driver'] as Map<String, dynamic>),
      envelops: (json['envelops'] as List<dynamic>?)
          ?.map((e) => Envelop.fromJson(e as Map<String, dynamic>))
          .toList(),
      inventories: (json['inventories'] as List<dynamic>?)
          ?.map((e) => Inventory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'driver': driver?.toJson(),
        'envelops': envelops?.map((e) => e.toJson()).toList(),
        'inventories': inventories?.map((e) => e.toJson()).toList(),
      };
}
