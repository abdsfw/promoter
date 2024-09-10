// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `sss`
  String get s {
    return Intl.message(
      'sss',
      name: 's',
      desc: '',
      args: [],
    );
  }

  /// `Bills`
  String get bills {
    return Intl.message(
      'Bills',
      name: 'bills',
      desc: '',
      args: [],
    );
  }

  /// `Envelopes`
  String get envelope {
    return Intl.message(
      'Envelopes',
      name: 'envelope',
      desc: '',
      args: [],
    );
  }

  /// `All sell point for You`
  String get allSellPointsForYou {
    return Intl.message(
      'All sell point for You',
      name: 'allSellPointsForYou',
      desc: '',
      args: [],
    );
  }

  /// `Delete`
  String get delete {
    return Intl.message(
      'Delete',
      name: 'delete',
      desc: '',
      args: [],
    );
  }

  /// `Envelopes for `
  String get envelopesFor {
    return Intl.message(
      'Envelopes for ',
      name: 'envelopesFor',
      desc: '',
      args: [],
    );
  }

  /// `Search by Sell Point Name`
  String get searchBySellPointName {
    return Intl.message(
      'Search by Sell Point Name',
      name: 'searchBySellPointName',
      desc: '',
      args: [],
    );
  }

  /// `All fields are required and must be valid.`
  String get allFieldsRequiredAndValid {
    return Intl.message(
      'All fields are required and must be valid.',
      name: 'allFieldsRequiredAndValid',
      desc: '',
      args: [],
    );
  }

  /// `Add New Envelope`
  String get addNewEnvelope {
    return Intl.message(
      'Add New Envelope',
      name: 'addNewEnvelope',
      desc: '',
      args: [],
    );
  }

  /// `Cash`
  String get cash {
    return Intl.message(
      'Cash',
      name: 'cash',
      desc: '',
      args: [],
    );
  }

  /// `Number`
  String get number {
    return Intl.message(
      'Number',
      name: 'number',
      desc: '',
      args: [],
    );
  }

  /// `Date (YYYY-MM-DD)`
  String get dateYYYYMMDD {
    return Intl.message(
      'Date (YYYY-MM-DD)',
      name: 'dateYYYYMMDD',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `Add`
  String get add {
    return Intl.message(
      'Add',
      name: 'add',
      desc: '',
      args: [],
    );
  }

  /// `Envelope added successfully`
  String get envelopeAddedSuccessfully {
    return Intl.message(
      'Envelope added successfully',
      name: 'envelopeAddedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to add envelope`
  String get failedToAddEnvelope {
    return Intl.message(
      'Failed to add envelope',
      name: 'failedToAddEnvelope',
      desc: '',
      args: [],
    );
  }

  /// `Confirm Deletion`
  String get confirmDeletion {
    return Intl.message(
      'Confirm Deletion',
      name: 'confirmDeletion',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure you want to delete this envelope?`
  String get confirmDeleteEnvelope {
    return Intl.message(
      'Are you sure you want to delete this envelope?',
      name: 'confirmDeleteEnvelope',
      desc: '',
      args: [],
    );
  }

  /// `No envelopes found.`
  String get noEnvelopesFound {
    return Intl.message(
      'No envelopes found.',
      name: 'noEnvelopesFound',
      desc: '',
      args: [],
    );
  }

  /// `Envelope Number`
  String get envelopeNumber {
    return Intl.message(
      'Envelope Number',
      name: 'envelopeNumber',
      desc: '',
      args: [],
    );
  }

  /// `The cash`
  String get theCash {
    return Intl.message(
      'The cash',
      name: 'theCash',
      desc: '',
      args: [],
    );
  }

  /// `Date`
  String get date {
    return Intl.message(
      'Date',
      name: 'date',
      desc: '',
      args: [],
    );
  }

  /// `Envelope deleted successfully`
  String get envelopeDeletedSuccessfully {
    return Intl.message(
      'Envelope deleted successfully',
      name: 'envelopeDeletedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `Failed to delete envelope`
  String get failedToDeleteEnvelope {
    return Intl.message(
      'Failed to delete envelope',
      name: 'failedToDeleteEnvelope',
      desc: '',
      args: [],
    );
  }

  /// `Update`
  String get update {
    return Intl.message(
      'Update',
      name: 'update',
      desc: '',
      args: [],
    );
  }

  /// `Cash updated successfully`
  String get cashUpdatedSuccessfully {
    return Intl.message(
      'Cash updated successfully',
      name: 'cashUpdatedSuccessfully',
      desc: '',
      args: [],
    );
  }

  /// `New Cash`
  String get newCash {
    return Intl.message(
      'New Cash',
      name: 'newCash',
      desc: '',
      args: [],
    );
  }

  /// `Edit Cash`
  String get editCash {
    return Intl.message(
      'Edit Cash',
      name: 'editCash',
      desc: '',
      args: [],
    );
  }

  /// `Good day`
  String get goodDay {
    return Intl.message(
      'Good day',
      name: 'goodDay',
      desc: '',
      args: [],
    );
  }

  /// `Hello promoter`
  String get helloPromoter {
    return Intl.message(
      'Hello promoter',
      name: 'helloPromoter',
      desc: '',
      args: [],
    );
  }

  /// `Add bill`
  String get addBill {
    return Intl.message(
      'Add bill',
      name: 'addBill',
      desc: '',
      args: [],
    );
  }

  /// `You don't choose any category`
  String get noCategoryChosen {
    return Intl.message(
      'You don\'t choose any category',
      name: 'noCategoryChosen',
      desc: '',
      args: [],
    );
  }

  /// `Ok`
  String get ok {
    return Intl.message(
      'Ok',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Price`
  String get price {
    return Intl.message(
      'Price',
      name: 'price',
      desc: '',
      args: [],
    );
  }

  /// `Amount`
  String get amount {
    return Intl.message(
      'Amount',
      name: 'amount',
      desc: '',
      args: [],
    );
  }

  /// `Add Category to bill`
  String get addCategoryTobill {
    return Intl.message(
      'Add Category to bill',
      name: 'addCategoryTobill',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this bill?`
  String get confirmDeleteBill {
    return Intl.message(
      'Do you want to delete this bill?',
      name: 'confirmDeleteBill',
      desc: '',
      args: [],
    );
  }

  /// `Edit amount bill`
  String get editAmountBill {
    return Intl.message(
      'Edit amount bill',
      name: 'editAmountBill',
      desc: '',
      args: [],
    );
  }

  /// `please enter amount`
  String get pleaseEnterAmount {
    return Intl.message(
      'please enter amount',
      name: 'pleaseEnterAmount',
      desc: '',
      args: [],
    );
  }

  /// `save`
  String get save {
    return Intl.message(
      'save',
      name: 'save',
      desc: '',
      args: [],
    );
  }

  /// `Create PDF`
  String get pdf {
    return Intl.message(
      'Create PDF',
      name: 'pdf',
      desc: '',
      args: [],
    );
  }

  /// `Schools`
  String get school {
    return Intl.message(
      'Schools',
      name: 'school',
      desc: '',
      args: [],
    );
  }

  /// `sp name`
  String get spName {
    return Intl.message(
      'sp name',
      name: 'spName',
      desc: '',
      args: [],
    );
  }

  /// `driver name`
  String get driverName {
    return Intl.message(
      'driver name',
      name: 'driverName',
      desc: '',
      args: [],
    );
  }

  /// `amount of envelop`
  String get amountOfEnvelop {
    return Intl.message(
      'amount of envelop',
      name: 'amountOfEnvelop',
      desc: '',
      args: [],
    );
  }

  /// `sp expenses`
  String get spExpenses {
    return Intl.message(
      'sp expenses',
      name: 'spExpenses',
      desc: '',
      args: [],
    );
  }

  /// `total amount`
  String get totalAmount {
    return Intl.message(
      'total amount',
      name: 'totalAmount',
      desc: '',
      args: [],
    );
  }

  /// `total price`
  String get totalPrice {
    return Intl.message(
      'total price',
      name: 'totalPrice',
      desc: '',
      args: [],
    );
  }

  /// `price`
  String get priceAin {
    return Intl.message(
      'price',
      name: 'priceAin',
      desc: '',
      args: [],
    );
  }

  /// `amount`
  String get amountAin {
    return Intl.message(
      'amount',
      name: 'amountAin',
      desc: '',
      args: [],
    );
  }

  /// `Inventory by date`
  String get inventoryByDate {
    return Intl.message(
      'Inventory by date',
      name: 'inventoryByDate',
      desc: '',
      args: [],
    );
  }

  /// `delete bill filure`
  String get deleteBillFilure {
    return Intl.message(
      'delete bill filure',
      name: 'deleteBillFilure',
      desc: '',
      args: [],
    );
  }

  /// `you don't choose any category`
  String get youDontChooseAnyCategory {
    return Intl.message(
      'you don\'t choose any category',
      name: 'youDontChooseAnyCategory',
      desc: '',
      args: [],
    );
  }

  /// `No data to display`
  String get noDatatoDisplay {
    return Intl.message(
      'No data to display',
      name: 'noDatatoDisplay',
      desc: '',
      args: [],
    );
  }

  /// `foods`
  String get foods {
    return Intl.message(
      'foods',
      name: 'foods',
      desc: '',
      args: [],
    );
  }

  /// `Raw materials`
  String get rawMaterials {
    return Intl.message(
      'Raw materials',
      name: 'rawMaterials',
      desc: '',
      args: [],
    );
  }

  /// `material`
  String get material {
    return Intl.message(
      'material',
      name: 'material',
      desc: '',
      args: [],
    );
  }

  /// `choose date`
  String get chooseDate {
    return Intl.message(
      'choose date',
      name: 'chooseDate',
      desc: '',
      args: [],
    );
  }

  /// `order`
  String get order {
    return Intl.message(
      'order',
      name: 'order',
      desc: '',
      args: [],
    );
  }

  /// `You didn't choose a date`
  String get dialogForUnselectedDate {
    return Intl.message(
      'You didn\'t choose a date',
      name: 'dialogForUnselectedDate',
      desc: '',
      args: [],
    );
  }

  /// `Select invoice type`
  String get typeBill {
    return Intl.message(
      'Select invoice type',
      name: 'typeBill',
      desc: '',
      args: [],
    );
  }

  /// `Select Order Type`
  String get selectOrderType {
    return Intl.message(
      'Select Order Type',
      name: 'selectOrderType',
      desc: '',
      args: [],
    );
  }

  /// `Food Order`
  String get foodOrder {
    return Intl.message(
      'Food Order',
      name: 'foodOrder',
      desc: '',
      args: [],
    );
  }

  /// `Raw materials order`
  String get rawMaterialsOrder {
    return Intl.message(
      'Raw materials order',
      name: 'rawMaterialsOrder',
      desc: '',
      args: [],
    );
  }

  /// `Error in fetch data`
  String get errorInFetchData {
    return Intl.message(
      'Error in fetch data',
      name: 'errorInFetchData',
      desc: '',
      args: [],
    );
  }

  /// `delete data successfully`
  String get successInDeleteData {
    return Intl.message(
      'delete data successfully',
      name: 'successInDeleteData',
      desc: '',
      args: [],
    );
  }

  /// `Select Item Type`
  String get selectItemType {
    return Intl.message(
      'Select Item Type',
      name: 'selectItemType',
      desc: '',
      args: [],
    );
  }

  /// `Invoice addition operation failed`
  String get errorInAddingInvoice {
    return Intl.message(
      'Invoice addition operation failed',
      name: 'errorInAddingInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Invoice addition has been completed successfully`
  String get successInAddingInvoice {
    return Intl.message(
      'Invoice addition has been completed successfully',
      name: 'successInAddingInvoice',
      desc: '',
      args: [],
    );
  }

  /// `Select invoice type`
  String get firstDialogInBIllTitle {
    return Intl.message(
      'Select invoice type',
      name: 'firstDialogInBIllTitle',
      desc: '',
      args: [],
    );
  }

  /// `General Invoices`
  String get firstDialogInBIllOne {
    return Intl.message(
      'General Invoices',
      name: 'firstDialogInBIllOne',
      desc: '',
      args: [],
    );
  }

  /// `Invoices for other Sell Point`
  String get firstDialogInBIllTwo {
    return Intl.message(
      'Invoices for other Sell Point',
      name: 'firstDialogInBIllTwo',
      desc: '',
      args: [],
    );
  }

  /// `Invoices for external`
  String get invoicesForExternal {
    return Intl.message(
      'Invoices for external',
      name: 'invoicesForExternal',
      desc: '',
      args: [],
    );
  }

  /// `kindergarten`
  String get kindergarten {
    return Intl.message(
      'kindergarten',
      name: 'kindergarten',
      desc: '',
      args: [],
    );
  }

  /// `school`
  String get school2 {
    return Intl.message(
      'school',
      name: 'school2',
      desc: '',
      args: [],
    );
  }

  /// `total price`
  String get totalPRice {
    return Intl.message(
      'total price',
      name: 'totalPRice',
      desc: '',
      args: [],
    );
  }

  /// `total amount`
  String get totalAMount {
    return Intl.message(
      'total amount',
      name: 'totalAMount',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to delete this item?`
  String get confirmDeleteCategory {
    return Intl.message(
      'Do you want to delete this item?',
      name: 'confirmDeleteCategory',
      desc: '',
      args: [],
    );
  }

  /// `select sell point`
  String get selectSellPoint {
    return Intl.message(
      'select sell point',
      name: 'selectSellPoint',
      desc: '',
      args: [],
    );
  }

  /// `you don't you didn't choose a sell point`
  String get errorSellPOint {
    return Intl.message(
      'you don\'t you didn\'t choose a sell point',
      name: 'errorSellPOint',
      desc: '',
      args: [],
    );
  }

  /// `please Enter A Value`
  String get pleaseEnterAValue {
    return Intl.message(
      'please Enter A Value',
      name: 'pleaseEnterAValue',
      desc: '',
      args: [],
    );
  }

  /// `Do you want to send an inventory of items??`
  String get inventoryMessage {
    return Intl.message(
      'Do you want to send an inventory of items??',
      name: 'inventoryMessage',
      desc: '',
      args: [],
    );
  }

  /// `Inventory`
  String get inventory {
    return Intl.message(
      'Inventory',
      name: 'inventory',
      desc: '',
      args: [],
    );
  }

  /// `Inventory information has been sent successfully.`
  String get successInInventory {
    return Intl.message(
      'Inventory information has been sent successfully.',
      name: 'successInInventory',
      desc: '',
      args: [],
    );
  }

  /// `Total expenses price`
  String get totalExpenses {
    return Intl.message(
      'Total expenses price',
      name: 'totalExpenses',
      desc: '',
      args: [],
    );
  }

  /// `Total price`
  String get totalPriceE {
    return Intl.message(
      'Total price',
      name: 'totalPriceE',
      desc: '',
      args: [],
    );
  }

  /// `amount of returns`
  String get amountOfReturns {
    return Intl.message(
      'amount of returns',
      name: 'amountOfReturns',
      desc: '',
      args: [],
    );
  }

  /// `amount of expenses`
  String get amountOfExpenses {
    return Intl.message(
      'amount of expenses',
      name: 'amountOfExpenses',
      desc: '',
      args: [],
    );
  }

  /// `returns`
  String get returns {
    return Intl.message(
      'returns',
      name: 'returns',
      desc: '',
      args: [],
    );
  }

  /// `Supervisor expenses`
  String get expenses {
    return Intl.message(
      'Supervisor expenses',
      name: 'expenses',
      desc: '',
      args: [],
    );
  }

  /// `Management expenses`
  String get expensesManager {
    return Intl.message(
      'Management expenses',
      name: 'expensesManager',
      desc: '',
      args: [],
    );
  }

  /// `doctor expenses`
  String get expensesDoctor {
    return Intl.message(
      'doctor expenses',
      name: 'expensesDoctor',
      desc: '',
      args: [],
    );
  }

  /// `external`
  String get external {
    return Intl.message(
      'external',
      name: 'external',
      desc: '',
      args: [],
    );
  }

  /// `holiday`
  String get holiday {
    return Intl.message(
      'holiday',
      name: 'holiday',
      desc: '',
      args: [],
    );
  }

  /// `Economic situations`
  String get expens_eco {
    return Intl.message(
      'Economic situations',
      name: 'expens_eco',
      desc: '',
      args: [],
    );
  }

  /// `enter amount of returns`
  String get enterAmountOfReturns {
    return Intl.message(
      'enter amount of returns',
      name: 'enterAmountOfReturns',
      desc: '',
      args: [],
    );
  }

  /// `enter amount of expenses`
  String get enterAmountOfExpenses {
    return Intl.message(
      'enter amount of expenses',
      name: 'enterAmountOfExpenses',
      desc: '',
      args: [],
    );
  }

  /// `please enter an amount`
  String get pleaseEnterAmountD {
    return Intl.message(
      'please enter an amount',
      name: 'pleaseEnterAmountD',
      desc: '',
      args: [],
    );
  }

  /// `error in edit item`
  String get errorInEdit {
    return Intl.message(
      'error in edit item',
      name: 'errorInEdit',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to send this inventory??`
  String get areYouSureToSendThisInventory {
    return Intl.message(
      'Are you sure to send this inventory??',
      name: 'areYouSureToSendThisInventory',
      desc: '',
      args: [],
    );
  }

  /// `search`
  String get search {
    return Intl.message(
      'search',
      name: 'search',
      desc: '',
      args: [],
    );
  }

  /// `total amount`
  String get amountOfPrice {
    return Intl.message(
      'total amount',
      name: 'amountOfPrice',
      desc: '',
      args: [],
    );
  }

  /// `enter the rest`
  String get enterAmountOfAmount {
    return Intl.message(
      'enter the rest',
      name: 'enterAmountOfAmount',
      desc: '',
      args: [],
    );
  }

  /// `rest`
  String get rest {
    return Intl.message(
      'rest',
      name: 'rest',
      desc: '',
      args: [],
    );
  }

  /// `other bills`
  String get otherBills {
    return Intl.message(
      'other bills',
      name: 'otherBills',
      desc: '',
      args: [],
    );
  }

  /// `edit date`
  String get editDate {
    return Intl.message(
      'edit date',
      name: 'editDate',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to save this edit?`
  String get editDateTitle {
    return Intl.message(
      'Are you sure to save this edit?',
      name: 'editDateTitle',
      desc: '',
      args: [],
    );
  }

  /// `Date updated successfully`
  String get successEditDate {
    return Intl.message(
      'Date updated successfully',
      name: 'successEditDate',
      desc: '',
      args: [],
    );
  }

  /// `do you want to delete this Inventory`
  String get confirmDeleteInventory {
    return Intl.message(
      'do you want to delete this Inventory',
      name: 'confirmDeleteInventory',
      desc: '',
      args: [],
    );
  }

  /// `Are you sure to perform the operation?`
  String get holidayConfirm {
    return Intl.message(
      'Are you sure to perform the operation?',
      name: 'holidayConfirm',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'ar'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
