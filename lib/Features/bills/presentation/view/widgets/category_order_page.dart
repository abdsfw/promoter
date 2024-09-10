import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:intl/intl.dart';
import 'package:promoter/Features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:promoter/core/constant/constant.dart';
import 'package:promoter/core/utils/styles.dart';
import 'package:promoter/core/utils/widgets/custom_search_widget.dart';

import '../../../../../core/utils/widgets/custom_error_widget.dart';
import '../../../../../core/utils/widgets/custom_loading_indicator.dart';
import '../../../../../generated/l10n.dart';
import 'order_flouting_button_method.dart';

class CategoryOrderPage extends StatelessWidget {
  const CategoryOrderPage({
    super.key,
    required this.sellPointId,
    this.isEdit = false,
    required this.isStore,
    this.billID = -1,
    required this.isToSp,
    // this.isNew = false,
    // this.isReturn = true,
    // this.isExternal = false,
    required this.type,
    // this.type,
  });
  final int sellPointId;
  final bool isEdit;
  final bool isStore;
  final int billID;
  // final String? type;
  final bool isToSp;
  // final bool isNew;
  // final bool isReturn;
  // final bool isExternal;
  final String type;

  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
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

              billCubit.selectedDAteForAddBill = DateTime.now();
              billCubit.selectedCAtAllCat.clear();
              billCubit.activeCAt.clear();
              billCubit.activeCAtkg.clear();
              billCubit.activeCatDamagekg.clear();
              // billCubit.controllerskg.clear();
              // billCubit.controllersDamagekg.clear();
              billCubit.sellPointController.clear();
            },
          ),
          actions: [
            (isEdit || isToSp)
                ? const SizedBox()
                : ElevatedButton(
                    onPressed: () {
                      showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime(2020),
                        lastDate: DateTime(2030),
                      ).then(
                        (value) {
                          if (value != null) {
                            billCubit.selectedDAteForAddBill = value;
                            billCubit.emit(SuccessFEtchAllActiveCategory());
                          }
                        },
                      );
                    },
                    child: Text(
                      // ---- chooseDate ------
                      S.of(context).chooseDate,
                      // ----------------------
                      style: Styles.textStyle14,
                    ),
                  ),
            if (isToSp)
              // ElevatedButton(
              //   onPressed: () {
              //   },
              //   child: Text(
              //     'اختر نقطة البيع',
              //     style: Styles.textStyle14,
              //   ),
              // )
              BlocBuilder<BillPageCubit, BillPageState>(
                builder: (context, state) {
                  return SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: TypeAheadField(
                      textFieldConfiguration: TextFieldConfiguration(
                        // autofocus: true,
                        controller: billCubit.sellPointController,
                        // style: DefaultTextStyle.of(context)
                        //     .style
                        //     .copyWith(fontStyle: FontStyle.italic),
                        decoration: InputDecoration(
                          hintText: S.of(context).selectSellPoint,
                          hintStyle: Styles.textStyle12,
                          border: OutlineInputBorder(),
                        ),
                      ),
                      suggestionsCallback: (pattern) {
                        return billCubit.sellPoints.where(
                          (element) {
                            return element.name!.toLowerCase().contains(
                                  pattern.toLowerCase(),
                                );
                          },
                        );
                      }, //api,,
                      itemBuilder: (context, itemData) => Card(
                        child: Text(
                          itemData.name!,
                          style: Styles.textStyle16,
                        ),
                      ),
                      onSuggestionSelected: (suggestion) {
                        billCubit.selectedSellPoint = suggestion;
                        billCubit.sellPointController.text = suggestion.name!;
                        billCubit.emit(SuccessFEtchAllActiveCategory());
                      },
                    ),
                  );
                },
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
                  // icon: const Icon(
                  //   Icons.,
                  // ),
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
            BlocConsumer<BillPageCubit, BillPageState>(
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
                        (isStore)
                            ? const StoreFoodSection()
                            : const RawMaterialsSection(),
                        // tab bar 2
                        (isStore)
                            ? const StoreFoodSectionKg()
                            : const RawMaterialsSectionKg(),
                      ],
                    ),
                  );
                }
              },
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: BlocBuilder<BillPageCubit, BillPageState>(
          builder: (context, state) {
            if (isStore) {
              if (billCubit.activeCAt.length ==
                      billCubit.currentActiveCAt.length &&
                  billCubit.activeCAtkg.length ==
                      billCubit.currentActiveCAtkg.length) {
                return OrderFloutingButtonMethod(
                  sellPointId: sellPointId,
                  billId: billID,
                  isEdit: isEdit,
                  isStore: isStore,
                  isToSp: isToSp,
                  type: type,
                );
              } else {
                return SizedBox();
              }
            } else {
              if (billCubit.activeCatDamage.length ==
                      billCubit.currentActiveCatDamage.length &&
                  billCubit.activeCatDamagekg.length ==
                      billCubit.currentActiveCatDamagekg.length) {
                return OrderFloutingButtonMethod(
                  sellPointId: sellPointId,
                  billId: billID,
                  isEdit: isEdit,
                  isStore: isStore,
                  isToSp: isToSp,
                  type: type,
                );
              } else {
                return const SizedBox();
              }
            }
          },
        ),
      ),
    );
  }
}

class RawMaterialsSection extends StatelessWidget {
  const RawMaterialsSection({
    super.key,
    // required this.isKg,
  });
  // final bool isKg;
  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    // List<TextEditingController> controllersDamage = [];
    // List<Map<String, int>> selectedCAtDamage = [];
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomSearchWidget(
                  searchController: TextEditingController(),
                  onchange: (p0) {
                    billCubit.searchData(
                      allData: billCubit.activeCatDamage,
                      isSchool: true,
                      isStore: false,
                      value: p0,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<BillPageCubit, BillPageState>(
                builder: (context, state) {
                  return Text(
                    DateFormat('yyyy-MM-dd', 'en').format(
                      billCubit.selectedDAteForAddBill!,
                    ),
                    textAlign: TextAlign.center,
                    style: Styles.textStyle16,
                  );
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<BillPageCubit, BillPageState>(
            builder: (context, state) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, index) {
                  // billCubit.controllersDamage.add(TextEditingController());
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              billCubit.currentActiveCatDamage[index].nameAr!,
                              style: Styles.textStyle12,
                              maxLines: 2,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  billCubit.addOneMethod(
                                    index: index,
                                    isSchool: true,
                                    isStore: false,
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColor.hBackgroundColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  billCubit.minusOneMethod(
                                    index: index,
                                    isSchool: true,
                                    isStore: false,
                                  );
                                },
                                icon: const Icon(
                                  Icons.remove,
                                ),
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColor.kActiveIconColor,
                                ),
                              ),
                            ],
                          ),
                          BlocBuilder<BillPageCubit, BillPageState>(
                            builder: (context, state) {
                              return TextFormField(
                                onTapOutside: (event) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                // controller: billCubit.controllersDamage[index],
                                controller: billCubit
                                    .currentActiveCatDamage[index].controller,
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: billCubit.currentActiveCatDamage.length,
              );
            },
          ),
        ),
      ],
    );
  }
}

class RawMaterialsSectionKg extends StatelessWidget {
  const RawMaterialsSectionKg({
    super.key,
    // required this.isKg,
  });
  // final bool isKg;
  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    // List<TextEditingController> controllersDamage = [];
    // List<Map<String, int>> selectedCAtDamage = [];
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomSearchWidget(
                  searchController: TextEditingController(),
                  onchange: (p0) {
                    billCubit.searchData(
                      allData: billCubit.activeCatDamagekg,
                      isSchool: false,
                      isStore: false,
                      value: p0,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<BillPageCubit, BillPageState>(
                builder: (context, state) {
                  return Text(
                    DateFormat('yyyy-MM-dd', 'en').format(
                      billCubit.selectedDAteForAddBill!,
                    ),
                    textAlign: TextAlign.center,
                    style: Styles.textStyle16,
                  );
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<BillPageCubit, BillPageState>(
            builder: (context, state) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
                ),
                itemBuilder: (context, index) {
                  // billCubit.controllersDamage.add(TextEditingController());
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            child: Text(
                              billCubit.currentActiveCatDamagekg[index].nameAr!,
                              style: Styles.textStyle12,
                              maxLines: 2,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  billCubit.addOneMethod(
                                    index: index,
                                    isSchool: false,
                                    isStore: false,
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColor.hBackgroundColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  billCubit.minusOneMethod(
                                    index: index,
                                    isSchool: false,
                                    isStore: false,
                                  );
                                },
                                icon: const Icon(
                                  Icons.remove,
                                ),
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColor.kActiveIconColor,
                                ),
                              ),
                            ],
                          ),
                          BlocBuilder<BillPageCubit, BillPageState>(
                            builder: (context, state) {
                              return TextFormField(
                                onTapOutside: (event) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                // controller: billCubit.controllersDamagekg[index],
                                controller: billCubit
                                    .currentActiveCatDamagekg[index].controller,
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: billCubit.currentActiveCatDamagekg.length,
              );
            },
          ),
        ),
      ],
    );
  }
}

class StoreFoodSection extends StatelessWidget {
  const StoreFoodSection({
    super.key,
    // required this.isKg,
  });
  // final bool isKg;
  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    // List<TextEditingController> controllers = [];
    // List<Map<String, int>> selectedCAt = [];
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomSearchWidget(
                  searchController: TextEditingController(),
                  onchange: (p0) {
                    billCubit.searchData(
                      allData: billCubit.activeCAt,
                      isSchool: true,
                      isStore: true,
                      value: p0,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<BillPageCubit, BillPageState>(
                builder: (context, state) {
                  return Text(
                    DateFormat('yyyy-MM-dd', 'en').format(
                      billCubit.selectedDAteForAddBill!,
                    ),
                    textAlign: TextAlign.center,
                    style: Styles.textStyle16,
                  );
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<BillPageCubit, BillPageState>(
            builder: (context, state) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
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
                              billCubit.currentActiveCAt[index].nameAr!,
                              style: Styles.textStyle12,
                              maxLines: 2,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  billCubit.addOneMethod(
                                    index: index,
                                    isSchool: true,
                                    isStore: true,
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColor.hBackgroundColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  billCubit.minusOneMethod(
                                    index: index,
                                    isSchool: true,
                                    isStore: true,
                                  );
                                },
                                icon: const Icon(
                                  Icons.remove,
                                ),
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColor.kActiveIconColor,
                                ),
                              ),
                            ],
                          ),
                          BlocBuilder<BillPageCubit, BillPageState>(
                            builder: (context, state) {
                              return TextFormField(
                                onTapOutside: (event) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                // controller: billCubit.controllers[index],
                                controller: billCubit
                                    .currentActiveCAt[index].controller,
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: billCubit.currentActiveCAt.length,
              );
            },
          ),
        ),
      ],
    );
  }
}

class StoreFoodSectionKg extends StatelessWidget {
  const StoreFoodSectionKg({
    super.key,
    // required this.isKg,
  });
  // final bool isKg;
  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    // List<TextEditingController> controllers = [];
    // List<Map<String, int>> selectedCAt = [];
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 5),
                child: CustomSearchWidget(
                  searchController: TextEditingController(),
                  onchange: (p0) {
                    billCubit.searchData(
                      allData: billCubit.activeCAtkg,
                      isSchool: false,
                      isStore: true,
                      value: p0,
                    );
                  },
                ),
              ),
            ),
            Expanded(
              child: BlocBuilder<BillPageCubit, BillPageState>(
                builder: (context, state) {
                  return Text(
                    DateFormat('yyyy-MM-dd', 'en').format(
                      billCubit.selectedDAteForAddBill!,
                    ),
                    textAlign: TextAlign.center,
                    style: Styles.textStyle16,
                  );
                },
              ),
            ),
          ],
        ),
        Expanded(
          child: BlocBuilder<BillPageCubit, BillPageState>(
            builder: (context, state) {
              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: 2 / 3,
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
                              billCubit.currentActiveCAtkg[index].nameAr!,
                              style: Styles.textStyle12,
                              maxLines: 2,
                            ),
                          ),
                          Row(
                            children: [
                              IconButton(
                                onPressed: () {
                                  billCubit.addOneMethod(
                                    index: index,
                                    isSchool: false,
                                    isStore: true,
                                  );
                                },
                                icon: const Icon(
                                  Icons.add,
                                ),
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColor.hBackgroundColor,
                                ),
                              ),
                              IconButton(
                                onPressed: () {
                                  billCubit.minusOneMethod(
                                    index: index,
                                    isSchool: false,
                                    isStore: true,
                                  );
                                },
                                icon: const Icon(
                                  Icons.remove,
                                ),
                                color: Colors.white,
                                style: IconButton.styleFrom(
                                  backgroundColor: AppColor.kActiveIconColor,
                                ),
                              ),
                            ],
                          ),
                          BlocBuilder<BillPageCubit, BillPageState>(
                            builder: (context, state) {
                              return TextFormField(
                                onTapOutside: (event) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                keyboardType: TextInputType.number,
                                inputFormatters: [
                                  FilteringTextInputFormatter.digitsOnly,
                                ],
                                // controller: billCubit.controllerskg[index],
                                controller: billCubit
                                    .currentActiveCAtkg[index].controller,
                                textAlign: TextAlign.center,
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
                itemCount: billCubit.currentActiveCAtkg.length,
              );
            },
          ),
        ),
      ],
    );
  }
}
