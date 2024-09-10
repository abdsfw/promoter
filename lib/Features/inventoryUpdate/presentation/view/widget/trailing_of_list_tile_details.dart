import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promoter/Features/bills/presentation/view/widgets/conferm_dialog.dart';
import 'package:promoter/core/utils/widgets/custom_loading_indicator.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_text_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/inventory_cat_cubit.dart';

class TrailingOfListTileDetails extends StatelessWidget {
  const TrailingOfListTileDetails({
    super.key,
    // required this.inventoryIndex,
    required this.categoryIndex,
    required this.inventoryID,
  });
  // final int inventoryIndex;
  final int categoryIndex;
  final int inventoryID;

  @override
  Widget build(BuildContext context) {
    InventoryCatCubit inventoryCubit = InventoryCatCubit.get(context);
    var formKey = GlobalKey<FormState>();
    return IconButton(
      onPressed: () {
        print(inventoryCubit
            .inventoryCatDetails.inventoryCategory![categoryIndex].id);
        TextEditingController returnsController = TextEditingController(
          text: inventoryCubit
              .inventoryCatDetails.inventoryCategory![categoryIndex].amount
              .toString(),
        );
        // TextEditingController expensesController = TextEditingController(
        //   text: inventoryCubit
        //       .inventoryCatDetails.inventoryCategory![categoryIndex].spExpenses
        //       .toString(),
        // );
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(
              inventoryCubit.inventoryCatDetails
                  .inventoryCategory![categoryIndex].category!.nameAr
                  .toString(),
              style: Styles.textStyle16,
            ),
            scrollable: true,
            content: Form(
              key: formKey,
              child: BlocConsumer<InventoryCatCubit, InventoryCatState>(
                listener: (context, state) {
                  if (state is SuccessPutAllActiveCategory) {
                    Navigator.of(context).pop();
                  } else if (state is FailurePutAllActiveCategory) {
                    Navigator.of(context).pop();

                    showDialog(
                      context: context,
                      builder: (context) => ConfermDialog(
                        title: S.of(context).errorInEdit,
                        isAlert: true,
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is LoadingPutAllActiveCategory) {
                    return const CustomLoadingIndicator(
                      color: Colors.white,
                    );
                  } else {
                    return Column(
                      children: [
                        Row(
                          children: [
                            Text(
                              S.of(context).rest,
                              style: Styles.textStyle16,
                            ),
                          ],
                        ),
                        CustomTextFormField(
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          keyboardType: TextInputType.number,
                          controller: returnsController,
                          // -- enter Amount Of rest  ----
                          hintText: S.of(context).enterAmountOfAmount,
                          //---------------------------
                          onTap: (x) {},
                          validator: (x) {
                            if (x!.isEmpty) {
                              return S.of(context).pleaseEnterAmountD;
                            }
                            return null;
                          },
                        ),
                        // const Divider(),
                        // Row(
                        //   children: [
                        //     Text(
                        //       S.of(context).expenses,
                        //       style: Styles.textStyle16,
                        //     ),
                        //   ],
                        // ),
                        // CustomTextFormField(
                        //   controller: expensesController,
                        //   inputFormatters: [
                        //     FilteringTextInputFormatter.digitsOnly
                        //   ],
                        //   keyboardType: TextInputType.number,
                        //   hintText:
                        //       // --- enter Amount Of Expenses ---
                        //       S.of(context).enterAmountOfExpenses,
                        //   // ------------------------------------
                        //   onTap: (x) {},
                        //   validator: (x) {
                        //     if (x!.isEmpty) {
                        //       return S.of(context).pleaseEnterAmountD;
                        //     }
                        //     return null;
                        //   },
                        // ),
                      ],
                    );
                  }
                },
              ),
            ),
            actionsAlignment: MainAxisAlignment.start,
            actions: [
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    // num spExpenses = num.parse(expensesController.text);
                    num amount = num.parse(returnsController.text);
                    Map<String, dynamic> data = {
                      "amount": amount,
                      // "sp_expenses": spExpenses
                    };
                    inventoryCubit.editInventoryCategoryAmount(
                      categoryID: inventoryCubit.inventoryCatDetails
                          .inventoryCategory![categoryIndex].id!,
                      data: data,
                      inventoryID: inventoryID,
                    );
                  }
                },
                child: Text(
                  S.of(context).save,
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
      },
      icon: const Icon(
        Icons.edit,
      ),
    );
  }
}
