import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';

import '../../../../bills/data/models/active_category_model.dart';
import '../../../data/models/inventory_model/inventory_model.dart';
import '../../../data/repo/inventory_repo.dart';

part 'inventory_state.dart';

class InventoryCubit extends Cubit<InventoryState> {
  InventoryCubit(this.inventoryRepo) : super(InventoryInitial());
  static InventoryCubit get(context) => BlocProvider.of(context);
  final InventoryRepo inventoryRepo;
  // ------------------------
  DateTime pickerDate = DateTime.now();
  InventoryModel? inventory = InventoryModel(inventories: []);

  List<TextEditingController> controllers = [];
  List<TextEditingController> controllerskg = [];
  List<Map<String, int>> selectedCAtAllCat = [];
  List<ActiveCategoryModel> activeCAt = [];
  List<ActiveCategoryModel> activeCAtkg = [];

  var keyForm = GlobalKey<FormState>();

  // ----------------------------
  Future<void> fetchInventory(
      {required int schoolID, required Map<String, dynamic> body}) async {
    emit(LoadingFetchInventory());
    var result =
        await inventoryRepo.getInventory(schoolID: schoolID, body: body);
    result.fold((failure) {
      emit(FailuerFetchInventory(failure.errMassage));
    }, (data) {
      inventory = data;
      // isUpdated = false;
      print('success fetch all bills');
      emit(SuccessFetchInventory());
    });
  }

  Future<void> postInventory(
      {required int spID, required Map<String, dynamic> body}) async {
    emit(LoadingPostInventory());
    var result = await inventoryRepo.postInventory(spID: spID, body: body);
    result.fold((failure) {
      emit(FailuerPostInventory(failure.errMassage));
    }, (data) {
      print('success Post all bills');
      emit(SuccessPostInventory());
    });
  }

  Future<void> fetchAllActiveCAtegory() async {
    emit(LoadingFEtchAllActiveCategory());
    var result = await inventoryRepo.getActiveCategory();
    result.fold((failure) {
      emit(FailureFEtchAllActiveCategory(failure.errMassage));
    }, (data) async {
      // activeCAt = data;
      List<ActiveCategoryModel> store = [];
      List<ActiveCategoryModel> storekg = [];

      // controllersDamage.clear();
      // controllersDamagekg.clear();
      controllers.clear();
      controllerskg.clear();

      for (var cat in data) {
        if (cat.type == "store") {
          if (cat.schoolType == "school") {
            store.add(cat);
            controllers.add(TextEditingController(text: '0'));
          } else {
            storekg.add(cat);
            controllerskg.add(TextEditingController(text: '0'));
          }
        }
      }
      activeCAt = store;
      activeCAtkg = storekg;

      emit(SuccessFEtchAllActiveCategory());
    });
  }
}
