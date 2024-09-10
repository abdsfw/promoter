import 'package:dartz/dartz.dart';

import '../../../../core/error/failures.dart';
import '../models/active_category_model.dart';
import '../models/bill_of_sp_model.dart';
import '../models/bill_of_sp_to_sp_model.dart';
import '../models/category_bill_model/category_bill_model.dart';
import '../models/promoter_sp_model/promoter_sp_model.dart';
import '../models/sell_point_model.dart';

abstract class BillRepo {
  Future<Either<Failure, List<ActiveCategoryModel>>> getActiveCategory();
  Future<Either<Failure, List<PromoterSpModel>>> getAllPromoterSp();
  Future<Either<Failure, List<CategoryBillModel>>> getBillDetails(
      {required int billId});
  Future<Either<Failure, List<CategoryBillModel>>> getBillDetailsToSp(
      {required int billId});

  Future<Either<Failure, String>> deleteBIll({
    required int id,
  });
  Future<Either<Failure, String>> deleteBIllFromSpTpSp({
    required int id,
  });
  Future<Either<Failure, String>> postToAddBill(
    Map<String, dynamic> data,
    int sellPontId,
  );
  Future<Either<Failure, String>> postToAddBillToSp(
    Map<String, dynamic> data,
    int sellPontId,
  );

  Future<Either<Failure, String>> postToAddCategoryToBill(
    Map<String, dynamic> data,
    int billId,
  );
  Future<Either<Failure, String>> deleteCategory({
    required Map<String, dynamic> data,
  });
  Future<Either<Failure, String>> deleteCategorySpToSp({
    required int id,
  });
  Future<Either<Failure, String>> postToUpdateCategoryAmount(
    Map<String, dynamic> data,
    int categoryId,
  );
  Future<Either<Failure, String>> postToUpdateCategoryAmountSpTpSp(
    Map<String, dynamic> data,
    int categoryId,
  );

  Future<Either<Failure, List<BillOfSpModel>>> getBillsOfSp(
    Map<String, dynamic> data,
    int spId,
  );
  Future<Either<Failure, List<BillOfSpToSpModel>>> getBillsOfSpToSp(
    Map<String, dynamic> data,
    int spId,
  );
  Future<Either<Failure, List<SellPointModel>>> getSellPoint();

  Future<Either<Failure, String>> updateDateBIll(
    Map<String, dynamic> data,
    int billId,
  );
  Future<Either<Failure, String>> holidayApiGet({required int sellPointId});
}
