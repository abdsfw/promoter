import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/active_category_model_controller.dart';
import '../models/inventory_details/inventory_details.dart';
import '../models/inventory_sp.dart';

abstract class InventoryCatRepo {
  Future<Either<Failure, List<InventorySp>>> getInventory(
      {required int spID, required Map<String, dynamic> body});
  Future<Either<Failure, InventoryDetails>> getInventoryDetails(
      {required int inventoryID});

  Future<Either<Failure, List<ActiveCategoryModelController>>>
      getActiveCategory();
  Future<Either<Failure, String>> putInventoryCategory(
      {required int categoryID, required Map<String, dynamic> body});
  Future<Either<Failure, String>> postInventory(
      {required int spID, required Map<String, dynamic> body});

  Future<Either<Failure, String>> postInventoryCat({
    required int spID,
    required Map<String, dynamic> body,
    required int? inventoryID,
  });
  Future<Either<Failure, String>> deleteInventory({
    required int id,
  });

  Future<Either<Failure, String>> deleteCategory({
    required int id,
  });
}
