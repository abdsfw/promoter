import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../../../bills/data/models/active_category_model.dart';
import '../models/inventory_model/inventory_model.dart';

abstract class InventoryRepo {
  Future<Either<Failure, InventoryModel>> getInventory(
      {required int schoolID, required Map<String, dynamic> body});
  Future<Either<Failure, String>> postInventory(
      {required int spID, required Map<String, dynamic> body});
  Future<Either<Failure, List<ActiveCategoryModel>>> getActiveCategory();
}
