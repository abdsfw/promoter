import 'package:bloc/bloc.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:meta/meta.dart';
import 'package:promoter/Features/inventoryUpdate/data/models/inventory_sp.dart';

import '../../../data/models/active_category_model_controller.dart';
import '../../../data/models/inventory_details/inventory_details.dart';
import '../../../data/repo/inventoryCat_repo.dart';

part 'inventory_cat_state.dart';

class InventoryCatCubit extends Cubit<InventoryCatState> {
  InventoryCatCubit(this.inventoryRepo) : super(InventoryCatInitial());
  static InventoryCatCubit get(context) => BlocProvider.of(context);
  final InventoryCatRepo inventoryRepo;
  // -----------------------------------------------------
  List<InventorySp> inventoryCat = [];
  InventoryDetails inventoryCatDetails = InventoryDetails();
  DateTime selectDateForAddInventory = DateTime.now();

  List<ActiveCategoryModelController> allActiveCat = [];
  List<ActiveCategoryModelController> currentActiveCat = [];
  List<ActiveCategoryModelController> allActiveCatKg = [];
  List<ActiveCategoryModelController> currentActiveCatKg = [];

  TextEditingController storeSearchController = TextEditingController();
  TextEditingController storeKgSearchController = TextEditingController();

  // -----------------------------------------------------

  // -------------------- api methods --------------------
  Future<void> fetchInventory(
      {required int spID, required Map<String, dynamic> body}) async {
    emit(LoadingFetchInventoryState());
    var result = await inventoryRepo.getInventory(spID: spID, body: body);
    result.fold((failure) {
      print(failure.errMassage);
      emit(FailureFetchInventoryState(failure.errMassage));
    }, (data) {
      print('data length : ${data.length}');
      inventoryCat = data;
      emit(SuccessFetchInventoryState());
    });
  }

  Future<void> fetchInventoryDetails({required int inventoryID}) async {
    emit(LoadingFetchInventoryDetailsState());
    var result =
        await inventoryRepo.getInventoryDetails(inventoryID: inventoryID);
    result.fold((failure) {
      print(failure.errMassage);
      emit(FailureFetchInventoryDetailsState(failure.errMassage));
    }, (data) {
      // print('data length : ${data.length}');
      inventoryCatDetails = data;
      emit(SuccessFetchInventoryDetailsState());
    });
  }

  Future<void> editInventoryCategoryAmount(
      {required int categoryID,
      required Map<String, dynamic> data,
      required int inventoryID}) async {
    emit(LoadingPutAllActiveCategory());
    var result = await inventoryRepo.putInventoryCategory(
      body: data,
      categoryID: categoryID,
    );
    result.fold((failure) {
      print(failure.errMassage);
      emit(FailurePutAllActiveCategory(failure.errMassage));
    }, (data) {
      emit(SuccessPutAllActiveCategory());
      fetchInventoryDetails(
        inventoryID: inventoryID,
      );
    });
  }

  Future<void> fetchAllActiveCAtegory() async {
    emit(LoadingFEtchAllActiveCategory());
    var result = await inventoryRepo.getActiveCategory();
    result.fold((failure) {
      emit(FailureFEtchAllActiveCategory(failure.errMassage));
    }, (data) async {
      List<ActiveCategoryModelController> store = [];
      List<ActiveCategoryModelController> storeKg = [];
      // for (var i = 0; i < data.length; i++) {
      //   if (data[i].type == "store") {
      //     if (data[i].schoolType == "school") {
      //       store.add(data[i]);
      //       print(store[i].nameAr);
      //       // store[i].controllerReturns = TextEditingController(text: '0');
      //       // store[i].controllerExpenses = TextEditingController(text: '0');
      //     } else {
      //       storeKg.add(data[i]);
      //       print(storeKg[i].nameAr);
      //       // storeKg[i].controllerReturns = TextEditingController(text: '0');
      //       // storeKg[i].controllerExpenses = TextEditingController(text: '0');
      //     }
      //   }
      // }

      for (var cat in data) {
        if (cat.type == "store") {
          if (cat.schoolType == "school") {
            store.add(cat);
          } else {
            storeKg.add(cat);
          }
        }
      }

      for (var element in store) {
        element.controllerReturns = TextEditingController(text: '0');
        // element.controllerExpenses = TextEditingController(text: '0');
      }
      for (var element in storeKg) {
        element.controllerReturns = TextEditingController(text: '0');
        // element.controllerExpenses = TextEditingController(text: '0');
      }

      allActiveCat = store;
      currentActiveCat = store;
      allActiveCatKg = storeKg;
      currentActiveCatKg = storeKg;

      print('success fetch all bills');
      emit(SuccessFEtchAllActiveCategory());
    });
  }

  Future<void> postInventory(
      {required int spID, required Map<String, dynamic> body}) async {
    emit(LoadingPostInventory());
    var result = await inventoryRepo.postInventory(spID: spID, body: body);
    result.fold((failure) {
      emit(FailurePostInventory(failure.errMassage));
    }, (data) {
      print('success Post all bills');
      emit(SuccessPostInventory());
      // fetchInventory(
      //   body: {
      //     "date": DateFormat('yyyy-MM-dd','en').format(date),
      //   },
      //   spID: spID,
      // );
    });
  }

  Future<void> postInventoryCat({
    required int spID,
    required Map<String, dynamic> body,
    required int inventoryID,
  }) async {
    emit(LoadingPostInventory());
    var result = await inventoryRepo.postInventoryCat(
        spID: spID, body: body, inventoryID: inventoryID);
    result.fold((failure) {
      emit(FailurePostInventory(failure.errMassage));
    }, (data) {
      print('success Post catgory');
      emit(SuccessPostInventory());
      fetchInventoryDetails(
        inventoryID: inventoryID,
      );
      // fetchInventory(
      //   body: {
      //     "date": DateFormat('yyyy-MM-dd','en').format(date),
      //   },
      //   spID: spID,
      // );
    });
  }

  Future<void> deleteInventory(
      {required int id, required int spID, required var body}) async {
    emit(LoadingDeleteInventory());
    var result = await inventoryRepo.deleteInventory(id: id);

    result.fold(
      (failure) {
        emit(FailureDeleteInventory(failure.errMassage));
      },
      (data) async {
        await fetchInventory(spID: spID, body: body);
        emit(SuccessDeleteInventory());
      },
    );
  }

  Future<void> deleteCategory(
      {required int id, required int inventoryId}) async {
    emit(LoadingDeleteCategoryOfInventory());
    var result = await inventoryRepo.deleteCategory(id: id);

    result.fold(
      (failure) {
        emit(FailureDeleteCategoryOfInventory(failure.errMassage));
      },
      (data) async {
        await fetchInventoryDetails(inventoryID: inventoryId);
        emit(SuccessDeleteCategoryOfInventory());
      },
    );
  }
  // -----------------------------------------------------

  // ------------------------- cubit methods -------------------------

  void searchData({
    required String value,
    required List<ActiveCategoryModelController> allData,
    required bool isSchool,
  }) {
    List<ActiveCategoryModelController> result = allData.where(
      (element) {
        return element.nameAr!.toLowerCase().contains(
              value.toLowerCase(),
            );
        //      ||
        // element.nameEn.toString().toLowerCase().contains(
        //       value.toLowerCase(),
        //     );
      },
    ).toList();
    if (isSchool) {
      currentActiveCat = result;
    } else {
      currentActiveCatKg = result;
    }
    emit(SuccessFEtchAllActiveCategory());
  }

  void updateDate(DateTime selectedDate) {
    selectDateForAddInventory = selectedDate;
    emit(SuccessFEtchAllActiveCategory());
  }
  // -----------------------------------------------------------------
}
