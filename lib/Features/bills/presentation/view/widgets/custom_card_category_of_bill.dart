import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promoter/Features/bills/presentation/view/widgets/conferm_dialog.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_error_widget.dart';
import '../../../../../core/utils/widgets/custom_loading_indicator.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/bill_page_cubit.dart';

class CustomCardCategoryOfBill extends StatelessWidget {
  const CustomCardCategoryOfBill({
    super.key,
    required this.categoryIndex,
    required this.billId,
    required this.isToSp,
  });
  final int categoryIndex;
  final int billId;
  final bool isToSp;
  // final BillPageCubit billCubit;

  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    BillPageCubit billCubit = BillPageCubit.get(context);
    return Card(
      child: ListTile(
        onLongPress: () {
          TextEditingController controller = TextEditingController();
          (isToSp)
              ? showDialog(
                  context: context,
                  builder: (context) => Form(
                    key: formKey,
                    child: AlertDialog(
                      title: Text(
                        // ---- edit amount bill-----
                        S.of(context).editAmountBill,
                        // --------------------------
                        style: Styles.textStyle18,
                      ),
                      content: BlocConsumer<BillPageCubit, BillPageState>(
                        listener: (context, state) {
                          // if (state is SuccessUpdateCAtegoryOfBIll) {
                          //   Navigator.of(context).pop();
                          // }
                        },
                        builder: (context, state) {
                          if (state is LoadingUpdateCAtegoryOfBIll) {
                            return const CustomLoadingIndicator(
                              color: Colors.black,
                            );
                          } else if (state is FailureUpdateCAtegoryOfBIll) {
                            return CustomErrorWidget(
                                errMessage: state.errMessage);
                          } else {
                            return TextFormField(
                              onTapOutside: (event) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              controller: controller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  // ----- please enter amount -------------
                                  return S.of(context).pleaseEnterAmount;
                                  // ----------------------------------------
                                }
                                return null;
                              },
                            );
                          }
                        },
                      ),
                      actionsAlignment: MainAxisAlignment.spaceAround,
                      actions: [
                        BlocBuilder<BillPageCubit, BillPageState>(
                          builder: (context, state) {
                            if (state is LoadingUpdateCAtegoryOfBIll ||
                                state is FailureUpdateCAtegoryOfBIll) {
                              return const SizedBox();
                            }
                            return ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  int amount = int.parse(controller.text);
                                  var data = {"amount": amount};
                                  int categoryId =
                                      billCubit.categoryBIll[categoryIndex].id!;
                                  billCubit.updateCategorySpTpSp(
                                      data, billId, categoryId);
                                  Navigator.of(context).pop();
                                  // print(data);
                                  // print(billCubit.categoryBIll[categoryIndex].id);
                                }
                                // Navigator.of(context).pop();
                              },
                              child: Text(
                                // ---- save -----
                                S.of(context).save,
                                // -----------------
                                style: Styles.textStyle16,
                              ),
                            );
                          },
                        ),
                        BlocBuilder<BillPageCubit, BillPageState>(
                          builder: (context, state) {
                            if (state is LoadingUpdateCAtegoryOfBIll ||
                                state is FailureUpdateCAtegoryOfBIll) {
                              return const SizedBox();
                            } else {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  // ---- cancel ----
                                  S.of(context).cancel,
                                  // ------------------
                                  style: Styles.styleCanselButton,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                )
              : showDialog(
                  context: context,
                  builder: (context) => Form(
                    key: formKey,
                    child: AlertDialog(
                      title: Text(
                        // ---- edit amount bill-----
                        S.of(context).editAmountBill,
                        // --------------------------
                        style: Styles.textStyle18,
                      ),
                      content: BlocConsumer<BillPageCubit, BillPageState>(
                        listener: (context, state) {
                          // if (state is SuccessUpdateCAtegoryOfBIll) {
                          //   Navigator.of(context).pop();
                          // }
                        },
                        builder: (context, state) {
                          if (state is LoadingUpdateCAtegoryOfBIll) {
                            return const CustomLoadingIndicator(
                              color: Colors.black,
                            );
                          } else if (state is FailureUpdateCAtegoryOfBIll) {
                            return CustomErrorWidget(
                                errMessage: state.errMessage);
                          } else {
                            return TextFormField(
                              onTapOutside: (event) =>
                                  FocusManager.instance.primaryFocus?.unfocus(),
                              inputFormatters: [
                                FilteringTextInputFormatter.digitsOnly
                              ],
                              keyboardType: TextInputType.number,
                              controller: controller,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  // ----- please enter amount -------------
                                  return S.of(context).pleaseEnterAmount;
                                  // ----------------------------------------
                                }
                                return null;
                              },
                            );
                          }
                        },
                      ),
                      actionsAlignment: MainAxisAlignment.spaceAround,
                      actions: [
                        BlocBuilder<BillPageCubit, BillPageState>(
                          builder: (context, state) {
                            if (state is LoadingUpdateCAtegoryOfBIll ||
                                state is FailureUpdateCAtegoryOfBIll) {
                              return const SizedBox();
                            }
                            return ElevatedButton(
                              onPressed: () {
                                if (formKey.currentState!.validate()) {
                                  int amount = int.parse(controller.text);
                                  var data = {"amount": amount};
                                  int categoryId =
                                      billCubit.categoryBIll[categoryIndex].id!;
                                  billCubit.updateCategory(
                                      data, billId, categoryId);
                                  Navigator.of(context).pop();
                                  // print(data);
                                  // print(billCubit.categoryBIll[categoryIndex].id);
                                }
                                // Navigator.of(context).pop();
                              },
                              child: Text(
                                // ---- save -----
                                S.of(context).save,
                                // -----------------
                                style: Styles.textStyle16,
                              ),
                            );
                          },
                        ),
                        BlocBuilder<BillPageCubit, BillPageState>(
                          builder: (context, state) {
                            if (state is LoadingUpdateCAtegoryOfBIll ||
                                state is FailureUpdateCAtegoryOfBIll) {
                              return const SizedBox();
                            } else {
                              return ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.red),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                                child: Text(
                                  // ---- cancel ----
                                  S.of(context).cancel,
                                  // ------------------
                                  style: Styles.styleCanselButton,
                                ),
                              );
                            }
                          },
                        ),
                      ],
                    ),
                  ),
                );
        },
        // trailing: Icon(Icons.food_bank),
        leading: const Icon(Icons.food_bank),
        title: Text(billCubit.categoryBIll[categoryIndex].category!.nameAr!),
        subtitle: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Text(billCubit.categoryBIll[categoryIndex].category!.nameEn!),
            const Divider(),
            Text(
                "${S.of(context).price} : ${billCubit.categoryBIll[categoryIndex].totalPrice.toString()}"),
            const Divider(),
            Text(
                '${S.of(context).amount} : ${billCubit.categoryBIll[categoryIndex].amount.toString()}')
          ],
        ),
        trailing: (isToSp)
            ? IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  if (kDebugMode) {
                    print('here to delete SpToSp ${billCubit.categoryBIll[categoryIndex].id!}');
                  }
                  // ------------- To experiment -------------------
                  // List<int> ids = [billCubit.categoryBIll[categoryIndex].id!];
                  // var data = {"bill_category_ids": ids};
                  // print(billCubit.categoryBIll[categoryIndex].categoryId!);
                  // -----------------------------------------------
                  showDialog(
                    context: context,
                    builder: (context) => ConfermDialog(
                      // --- Do you want to delete this item? ----
                      title: S.of(context).confirmDeleteCategory,
                      // -----------------------------------------
                      onPressed: () {
                        // we should look at this api after edit from basel
                        billCubit.deleteCategorySpToSp(billId: billId , categoryId: billCubit.categoryBIll[categoryIndex].id!);
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              )
            : IconButton(
                icon: const Icon(
                  Icons.delete,
                  color: Colors.red,
                ),
                onPressed: () {
                  // ------------- To experiment -------------------
                  List<int> ids = [billCubit.categoryBIll[categoryIndex].id!];
                  var data = {"bill_category_ids": ids};
                  // print(billCubit.categoryBIll[categoryIndex].categoryId!);
                  // -----------------------------------------------
                  showDialog(
                    context: context,
                    builder: (context) => ConfermDialog(
                      // --- Do you want to delete this item? ----
                      title: S.of(context).confirmDeleteCategory,
                      // -----------------------------------------
                      onPressed: () {
                        billCubit.deleteCategory(data: data, billId: billId);
                        Navigator.of(context).pop();
                      },
                    ),
                  );
                },
              ),
      ),
    );
  }
}
