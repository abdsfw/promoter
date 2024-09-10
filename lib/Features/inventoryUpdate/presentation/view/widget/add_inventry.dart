import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:promoter/Features/bills/presentation/view/widgets/conferm_dialog.dart';
// import 'package:promoter/Features/bills/presentation/manager/cubit/bill_page_cubit.dart';
// import 'package:promoter/Features/inventoryUpdate/presentation/view/widget/inventory_bill_page.dart';
import 'package:promoter/core/utils/styles.dart';
import 'package:promoter/core/utils/widgets/custom_text_form_field.dart';

import '../../../../../core/utils/widgets/custom_error_widget.dart';
import '../../../../../core/utils/widgets/custom_loading_indicator.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/inventory_cat_cubit.dart';

class AddInventory extends StatelessWidget {
  const AddInventory({
    super.key,
    required this.spID,
    required this.isEdit, this.inventoryID,
  });

  // final int sellPointId;
  // final bool isEdit;
  // final bool isStore;
  // final int billID;
  // final bool isToSp;
  final int spID;
  final int? inventoryID;
  final bool isEdit;
  @override
  Widget build(BuildContext context) {
    print("object");
    // BillPageCubit billCubit = BillPageCubit.get(context);
    InventoryCatCubit inventoryCubit = InventoryCatCubit.get(context);
    var formKey = GlobalKey<FormState>();
    var formKey2 = GlobalKey<FormState>();
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            // ---- material ----
            S.of(context).material,
            // ------------------
            style: Styles.textStyle16,
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left_outlined,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              inventoryCubit.allActiveCat = [];
              inventoryCubit.currentActiveCat = [];
              inventoryCubit.allActiveCatKg = [];
              inventoryCubit.currentActiveCatKg = [];
              inventoryCubit.storeSearchController.clear();
              inventoryCubit.storeKgSearchController.clear();
              inventoryCubit.selectDateForAddInventory = DateTime.now();
            },
          ),
          actions: [
            if (!isEdit)
              ElevatedButton(
                onPressed: () {
                  showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(2020),
                    lastDate: DateTime(2030),
                  ).then(
                    (value) {
                      if (value != null) {
                        inventoryCubit.updateDate(value);
                      }
                    },
                    // (value) => print('baabab'),
                  );
                },
                child: Text(
                  // ---- chooseDate ------
                  S.of(context).chooseDate,
                  // ----------------------
                  style: Styles.textStyle14,
                ),
              ),
          ],
        ),
        body: Column(
          children: [
            TabBar(
              // indicatorColor: Colors.amber,
              // labelColor: Colors.amber,
              tabs: [
                Tab(
                  child: Text(
                    // ---- school ----------
                    S.of(context).school2,
                    // ----------------------
                    style: Styles.textStyle16,
                  ),
                ),
                Tab(
                  // icon: const Icon(
                  //   Icons.school,
                  // ),
                  child: Text(
                    // ----- kindergarten ----
                    S.of(context).kindergarten,
                    // ----------------
                    style: Styles.textStyle16,
                  ),
                ),
              ],
            ),
            BlocConsumer<InventoryCatCubit, InventoryCatState>(
              listener: (context, state) {
                // TODO: implement listener
              },
              builder: (context, state) {
                if (state is LoadingFEtchAllActiveCategory) {
                  return const Expanded(
                    child: CustomLoadingIndicator(
                      color: Colors.white,
                    ),
                  );
                } else if (state is FailureFEtchAllActiveCategory) {
                  return CustomErrorWidget(errMessage: state.errMessage);
                } else {
                  return Expanded(
                    child: TabBarView(
                      children: [
                        // tab bar 1
                        Form(
                            key: formKey,
                            child: StoreFoodSection(formKey: formKey)),
                        // tab bar 2
                        Form(
                            key: formKey2,
                            child: StoreFoodSectionKg(formKey: formKey))
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
        floatingActionButton: BlocBuilder<InventoryCatCubit, InventoryCatState>(
          builder: (context, state) {
            if (inventoryCubit.currentActiveCat.length ==
                    inventoryCubit.allActiveCat.length &&
                inventoryCubit.currentActiveCatKg.length ==
                    inventoryCubit.allActiveCatKg.length) {
              return FloatingActionButton(
                child: Text(
                  S.of(context).save,
                  style: Styles.textStyle16,
                ),
                onPressed: () {
                  if (formKey.currentState!.validate() ||
                      formKey2.currentState!.validate()) {
                    showDialog(
                      context: context,
                      builder: (context) => AlertDialog(
                        title:
                            BlocConsumer<InventoryCatCubit, InventoryCatState>(
                          listener: (context, state) {
                            if (state is SuccessPostInventory) {
                              Navigator.of(context).pop();
                              Navigator.of(context).pop();
                            } else if (state is FailurePostInventory) {
                              showDialog(
                                context: context,
                                builder: (context) => ConfermDialog(
                                  title: state.errMessage,
                                  isAlert: true,
                                ),
                              );
                            }
                          },
                          builder: (context, state) {
                            if (state is LoadingPostInventory) {
                              return const CustomLoadingIndicator(
                                color: Colors.white,
                              );
                            } else {
                              return Text(
                                S.of(context).areYouSureToSendThisInventory,
                                style: Styles.textStyle16,
                              );
                            }
                          },
                        ),
                        actionsAlignment: MainAxisAlignment.start,
                        actions: [
                          ElevatedButton(
                            onPressed: () {
                              List<Map<String, num>> body = [];
                              for (var cat in inventoryCubit.currentActiveCat) {
                                if (cat.controllerReturns!.text != '0') {
                                  body.add({
                                    "category_id": cat.id!,
                                    "amount":
                                        int.parse(cat.controllerReturns!.text),
                                    // "xp_exp": int.parse(cat.controllerExpenses!.text)
                                  });
                                }
                              }
                              for (var cat
                                  in inventoryCubit.currentActiveCatKg) {
                                if (cat.controllerReturns!.text != '0') {
                                  body.add({
                                    "category_id": cat.id!,
                                    "amount":
                                        int.parse(cat.controllerReturns!.text),
                                    // "xp_exp": int.parse(cat.controllerExpenses!.text)
                                  });
                                }
                              }
                              var data = {
                                "date": DateFormat('yyyy-MM-dd', 'en').format(
                                    inventoryCubit.selectDateForAddInventory),
                                "bills": body,
                              };
                              if (isEdit) {
                                inventoryCubit.postInventoryCat(
                                  body: data,
                                  spID: spID,
                                  inventoryID: inventoryID!, 

                                );
                              } else {
                                inventoryCubit.postInventory(
                                  body: data,
                                  spID: spID,
                                );
                              }
                            },
                            child: Text(
                              S.of(context).ok,
                              style: Styles.textStyle16,
                            ),
                          ),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.red,
                            ),
                            child: Text(
                              S.of(context).cancel,
                              style: Styles.styleCanselButton,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                },
              );
            } else {
              return const SizedBox();
            }
          },
        ),
      ),
    );
  }
}

class StoreFoodSection extends StatelessWidget {
  const StoreFoodSection({
    super.key,
    required this.formKey,
    // required this.isKg,
  });
  // final bool isKg;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    InventoryCatCubit inventoryCubit = InventoryCatCubit.get(context);

    // BillPageCubit billCubit = BillPageCubit.get(context);
    // List<TextEditingController> controllers = [];
    // List<Map<String, int>> selectedCAt = [];
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: inventoryCubit.storeSearchController,
                hintText: S.of(context).search,
                onTap: (x) {},
                onChange: (x) {
                  inventoryCubit.searchData(
                    allData: inventoryCubit.allActiveCat,
                    value: x,
                    isSchool: true,
                  );
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<InventoryCatCubit, InventoryCatState>(
                builder: (context, state) {
                  return Text(
                    DateFormat('yyyy-MM-dd', 'en')
                        .format(inventoryCubit.selectDateForAddInventory),
                    style: Styles.textStyle18,
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
          ],
        ),
        // TextFormField(),
        BlocBuilder<InventoryCatCubit, InventoryCatState>(
          builder: (context, state) {
            return Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  // controllers.add(TextEditingController());
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              inventoryCubit.currentActiveCat[index].nameAr!,
                              style: Styles.textStyle12.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     IconButton(
                          //       onPressed: () {
                          //         billCubit.addOneMethod(
                          //           index: index,
                          //           isSchool: true,
                          //           isStore: true,
                          //         );
                          //       },
                          //       icon: const Icon(
                          //         Icons.add,
                          //       ),
                          //       color: Colors.white,
                          //       style: IconButton.styleFrom(
                          //         backgroundColor: AppColor.hBackgroundColor,
                          //       ),
                          //     ),
                          //     IconButton(
                          //       onPressed: () {
                          //         billCubit.minusOneMethod(
                          //           index: index,
                          //           isSchool: true,
                          //           isStore: true,
                          //         );
                          //       },
                          //       icon: const Icon(
                          //         Icons.remove,
                          //       ),
                          //       color: Colors.white,
                          //       style: IconButton.styleFrom(
                          //         backgroundColor: AppColor.kActiveIconColor,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const Divider(),
                          Card(
                            color: Colors.pink[50],
                            child: Column(
                              children: [
                                Text(
                                  S.of(context).rest,
                                  style: Styles.textStyle12.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                BlocBuilder<InventoryCatCubit,
                                    InventoryCatState>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      // onChanged: (value) {
                                      //   if (value.isEmpty) {
                                      //     inventoryCubit.currentActiveCat[index]
                                      //         .controllerReturns!.text = '0';
                                      //     inventoryCubit.emit(
                                      //         SuccessFEtchAllActiveCategory());
                                      //   }
                                      // },
                                      // onSaved: (newValue) {

                                      // },
                                      onFieldSubmitted: (value) {
                                        if (inventoryCubit
                                            .currentActiveCat[index]
                                            .controllerReturns!
                                            .text
                                            .isEmpty) {
                                          inventoryCubit.currentActiveCat[index]
                                              .controllerReturns!.text = '0';
                                          inventoryCubit.emit(
                                              SuccessFEtchAllActiveCategory());
                                        }
                                      },
                                      // onTap: () {

                                      // },
                                      validator: (x) {
                                        if (x!.isEmpty) {
                                          return S
                                              .of(context)
                                              .pleaseEnterAmount;
                                        }
                                      },
                                      onTapOutside: (event) {
                                        if (inventoryCubit
                                            .currentActiveCat[index]
                                            .controllerReturns!
                                            .text
                                            .isEmpty) {
                                          inventoryCubit.currentActiveCat[index]
                                              .controllerReturns!.text = '0';
                                          inventoryCubit.emit(
                                              SuccessFEtchAllActiveCategory());
                                        }
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      controller: inventoryCubit
                                          .currentActiveCat[index]
                                          .controllerReturns,
                                      textAlign: TextAlign.center,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                          // Card(
                          //   color: Colors.pink[50],
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         S.of(context).expenses,
                          //         style: Styles.textStyle12.copyWith(
                          //           fontWeight: FontWeight.bold,
                          //         ),
                          //       ),
                          //       BlocBuilder<InventoryCatCubit,
                          //           InventoryCatState>(
                          //         builder: (context, state) {
                          //           return TextFormField(
                          //             validator: (x) {
                          //               if (x!.isEmpty) {
                          //                 return S
                          //                     .of(context)
                          //                     .pleaseEnterAmount;
                          //               }
                          //             },
                          //             onFieldSubmitted: (value) {
                          //               if (inventoryCubit
                          //                   .currentActiveCat[index]
                          //                   .controllerExpenses!
                          //                   .text
                          //                   .isEmpty) {
                          //                 inventoryCubit.currentActiveCat[index]
                          //                     .controllerExpenses!.text = '0';
                          //                 inventoryCubit.emit(
                          //                     SuccessFEtchAllActiveCategory());
                          //               }
                          //             },
                          //             onTapOutside: (event) {
                          //               if (inventoryCubit
                          //                   .currentActiveCat[index]
                          //                   .controllerExpenses!
                          //                   .text
                          //                   .isEmpty) {
                          //                 inventoryCubit.currentActiveCat[index]
                          //                     .controllerExpenses!.text = '0';
                          //                 inventoryCubit.emit(
                          //                     SuccessFEtchAllActiveCategory());
                          //               }
                          //               FocusManager.instance.primaryFocus
                          //                   ?.unfocus();
                          //             },
                          //             keyboardType: TextInputType.number,
                          //             inputFormatters: [
                          //               FilteringTextInputFormatter.digitsOnly,
                          //             ],
                          //             controller: inventoryCubit
                          //                 .currentActiveCat[index]
                          //                 .controllerExpenses,
                          //             textAlign: TextAlign.center,
                          //           );
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: inventoryCubit.currentActiveCat.length,
              ),
            );
          },
        ),
      ],
    );
  }
}

class StoreFoodSectionKg extends StatelessWidget {
  const StoreFoodSectionKg({
    super.key,
    required this.formKey,
    // required this.isKg,
  });
  // final bool isKg;
  final GlobalKey<FormState> formKey;
  @override
  Widget build(BuildContext context) {
    InventoryCatCubit inventoryCubit = InventoryCatCubit.get(context);

    // BillPageCubit billCubit = BillPageCubit.get(context);
    // List<TextEditingController> controllers = [];
    // List<Map<String, int>> selectedCAt = [];
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: CustomTextFormField(
                controller: inventoryCubit.storeSearchController,
                hintText: S.of(context).search,
                onTap: (x) {},
                onChange: (x) {
                  inventoryCubit.searchData(
                      allData: inventoryCubit.allActiveCatKg,
                      value: x,
                      isSchool: false);
                },
              ),
            ),
            Expanded(
              child: BlocBuilder<InventoryCatCubit, InventoryCatState>(
                builder: (context, state) {
                  return Text(
                    DateFormat('yyyy-MM-dd', 'en')
                        .format(inventoryCubit.selectDateForAddInventory),
                    style: Styles.textStyle18,
                    textAlign: TextAlign.center,
                  );
                },
              ),
            ),
          ],
        ),
        BlocBuilder<InventoryCatCubit, InventoryCatState>(
          builder: (context, state) {
            return Expanded(
              child: GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  // childAspectRatio: 3 / 4,
                ),
                itemBuilder: (context, index) {
                  // controllers.add(TextEditingController());
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              inventoryCubit.currentActiveCatKg[index].nameAr!,
                              style: Styles.textStyle12.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 2,
                            ),
                          ),
                          // Row(
                          //   children: [
                          //     IconButton(
                          //       onPressed: () {
                          //         billCubit.addOneMethod(
                          //           index: index,
                          //           isSchool: false,
                          //           isStore: true,
                          //         );
                          //       },
                          //       icon: const Icon(
                          //         Icons.add,
                          //       ),
                          //       color: Colors.white,
                          //       style: IconButton.styleFrom(
                          //         backgroundColor: AppColor.hBackgroundColor,
                          //       ),
                          //     ),
                          //     IconButton(
                          //       onPressed: () {
                          //         billCubit.minusOneMethod(
                          //           index: index,
                          //           isSchool: false,
                          //           isStore: true,
                          //         );
                          //       },
                          //       icon: const Icon(
                          //         Icons.remove,
                          //       ),
                          //       color: Colors.white,
                          //       style: IconButton.styleFrom(
                          //         backgroundColor: AppColor.kActiveIconColor,
                          //       ),
                          //     ),
                          //   ],
                          // ),
                          // const Divider(),
                          Card(
                            color: Colors.pink[50],
                            child: Column(
                              children: [
                                Text(
                                  S.of(context).rest,
                                  style: Styles.textStyle12.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                BlocBuilder<InventoryCatCubit,
                                    InventoryCatState>(
                                  builder: (context, state) {
                                    return TextFormField(
                                      onFieldSubmitted: (value) {
                                        if (inventoryCubit
                                            .currentActiveCatKg[index]
                                            .controllerReturns!
                                            .text
                                            .isEmpty) {
                                          inventoryCubit
                                              .currentActiveCatKg[index]
                                              .controllerReturns!
                                              .text = '0';

                                          inventoryCubit.emit(
                                              SuccessFEtchAllActiveCategory());
                                        }
                                      },
                                      onTapOutside: (event) {
                                        if (inventoryCubit
                                            .currentActiveCatKg[index]
                                            .controllerReturns!
                                            .text
                                            .isEmpty) {
                                          inventoryCubit
                                              .currentActiveCatKg[index]
                                              .controllerReturns!
                                              .text = '0';

                                          inventoryCubit.emit(
                                              SuccessFEtchAllActiveCategory());
                                        }
                                        FocusManager.instance.primaryFocus
                                            ?.unfocus();
                                      },
                                      keyboardType: TextInputType.number,
                                      inputFormatters: [
                                        FilteringTextInputFormatter.digitsOnly,
                                      ],
                                      controller: inventoryCubit
                                          .currentActiveCatKg[index]
                                          .controllerReturns,
                                      textAlign: TextAlign.center,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return S
                                              .of(context)
                                              .pleaseEnterAmount;
                                        }
                                      },
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),

                          // Card(
                          //   color: Colors.pink[50],
                          //   child: Column(
                          //     children: [
                          //       Text(
                          //         S.of(context).expenses,
                          //       ),
                          //       BlocBuilder<InventoryCatCubit,
                          //           InventoryCatState>(
                          //         builder: (context, state) {
                          //           return TextFormField(
                          //             onFieldSubmitted: (value) {
                          //               if (inventoryCubit
                          //                   .currentActiveCatKg[index]
                          //                   .controllerExpenses!
                          //                   .text
                          //                   .isEmpty) {
                          //                 inventoryCubit
                          //                     .currentActiveCatKg[index]
                          //                     .controllerExpenses!
                          //                     .text = '0';
                          //                 inventoryCubit.emit(
                          //                     SuccessFEtchAllActiveCategory());
                          //               }
                          //             },
                          //             onTapOutside: (event) {
                          //               if (inventoryCubit
                          //                   .currentActiveCatKg[index]
                          //                   .controllerExpenses!
                          //                   .text
                          //                   .isEmpty) {
                          //                 inventoryCubit
                          //                     .currentActiveCatKg[index]
                          //                     .controllerExpenses!
                          //                     .text = '0';
                          //                 inventoryCubit.emit(
                          //                     SuccessFEtchAllActiveCategory());
                          //               }
                          //               FocusManager.instance.primaryFocus
                          //                   ?.unfocus();
                          //             },
                          //             keyboardType: TextInputType.number,
                          //             inputFormatters: [
                          //               FilteringTextInputFormatter.digitsOnly,
                          //             ],
                          //             controller: inventoryCubit
                          //                 .currentActiveCatKg[index]
                          //                 .controllerExpenses,
                          //             textAlign: TextAlign.center,
                          //           );
                          //         },
                          //       ),
                          //     ],
                          //   ),
                          // ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: inventoryCubit.currentActiveCatKg.length,
              ),
            );
          },
        ),
      ],
    );
  }
}
