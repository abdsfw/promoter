part of 'inventory_cat_cubit.dart';

@immutable
sealed class InventoryCatState {}

final class InventoryCatInitial extends InventoryCatState {}

// ------------ get inventory without details state ---------------
class LoadingFetchInventoryState extends InventoryCatState {}

class FailureFetchInventoryState extends InventoryCatState {
  final String errMessage;

  FailureFetchInventoryState(this.errMessage);
}

class SuccessFetchInventoryState extends InventoryCatState {}

// ----------------------------------------------------------------

// ------------ get inventory details state ---------------
class LoadingFetchInventoryDetailsState extends InventoryCatState {}

class FailureFetchInventoryDetailsState extends InventoryCatState {
  final String errMessage;

  FailureFetchInventoryDetailsState(this.errMessage);
}

class SuccessFetchInventoryDetailsState extends InventoryCatState {}

// ----------------------------------------------------------------
// ------------ get active category state ---------------
class LoadingFEtchAllActiveCategory extends InventoryCatState {}

class FailureFEtchAllActiveCategory extends InventoryCatState {
  final String errMessage;

  FailureFEtchAllActiveCategory(this.errMessage);
}

class SuccessFEtchAllActiveCategory extends InventoryCatState {}

// ----------------------------------------------------------------
// ------------ put  category state ---------------
class LoadingPutAllActiveCategory extends InventoryCatState {}

class FailurePutAllActiveCategory extends InventoryCatState {
  final String errMessage;

  FailurePutAllActiveCategory(this.errMessage);
}

class SuccessPutAllActiveCategory extends InventoryCatState {}

// ----------------------------------------------------------------
// ------------ post inventory state ---------------
class LoadingPostInventory extends InventoryCatState {}

class FailurePostInventory extends InventoryCatState {
  final String errMessage;

  FailurePostInventory(this.errMessage);
}

class SuccessPostInventory extends InventoryCatState {}
// ----------------------------------------------------------------

// ---------------- delete inventory states --------------
class LoadingDeleteInventory extends InventoryCatState {}

class FailureDeleteInventory extends InventoryCatState {
  final String errMessage;
  FailureDeleteInventory(this.errMessage);
}

class SuccessDeleteInventory extends InventoryCatState {}

class LoadingDeleteCategoryOfInventory extends InventoryCatState {}

class FailureDeleteCategoryOfInventory extends InventoryCatState {
  final String errMessage;

  FailureDeleteCategoryOfInventory(this.errMessage);
}

class SuccessDeleteCategoryOfInventory extends InventoryCatState {}
