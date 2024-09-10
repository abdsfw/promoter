part of 'inventory_cubit.dart';

@immutable
sealed class InventoryState {}

final class InventoryInitial extends InventoryState {}

class LoadingFetchInventory extends InventoryState {}

class FailuerFetchInventory extends InventoryState {
  final String errMessage;

  FailuerFetchInventory(this.errMessage);
}

class SuccessFetchInventory extends InventoryState {}

class LoadingPostInventory extends InventoryState {}

class FailuerPostInventory extends InventoryState {
  final String errMessage;

  FailuerPostInventory(this.errMessage);
}

class SuccessPostInventory extends InventoryState {}

class LoadingFEtchAllActiveCategory extends InventoryState {}

class FailureFEtchAllActiveCategory extends InventoryState {
  final String errMessage;

  FailureFEtchAllActiveCategory(this.errMessage);
}

class SuccessFEtchAllActiveCategory extends InventoryState {}
