import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promoter/Features/inventoryUpdate/presentation/view/widget/subtitle_of_list_tile_details.dart';
import 'package:promoter/Features/inventoryUpdate/presentation/view/widget/title_of_list_tile_details.dart';
import 'package:promoter/Features/inventoryUpdate/presentation/view/widget/trailing_of_list_tile_details.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_loading_indicator.dart';
import '../../../../../core/utils/widgets/custom_text_form_field.dart';
import '../../../../../generated/l10n.dart';
import '../../../../bills/presentation/view/widgets/conferm_dialog.dart';
import '../../manager/cubit/inventory_cat_cubit.dart';

class InventoryDetailsBody extends StatelessWidget {
  const InventoryDetailsBody({
    super.key,
    required this.inventoryIndex,
  });
  final int inventoryIndex;

  @override
  Widget build(BuildContext context) {
    InventoryCatCubit inventoryCubit = InventoryCatCubit.get(context);
    var formKey = GlobalKey<FormState>();
    return Column(
      children: [
        Card(
          child: BlocBuilder<InventoryCatCubit, InventoryCatState>(
            builder: (context, state) {
              return ListTile(
                title: Text(
                  // -- Total price of rest ---
                  '${S.of(context).totalPriceE}: ${inventoryCubit.inventoryCatDetails.totalPrice.toString()}',
                  style: Styles.textStyle16,
                ),
                // subtitle: Text(
                //   // -- Total expenses price --
                //   '${S.of(context).totalExpenses}: ${inventoryCubit.inventoryCatDetails.totalExpenses.toString()}',
                //   style: Styles.textStyle16,
                // ),
              );
            },
          ),
        ),
        Expanded(
          child: Card(
            child: ListView.builder(
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Card(
                    color: Colors.pink[50],
                    child: ListTile(
                      onTap: () {
                        print(inventoryCubit
                            .inventoryCatDetails.inventoryCategory![index].id);
                        TextEditingController returnsController =
                            TextEditingController(
                          text: inventoryCubit.inventoryCatDetails
                              .inventoryCategory![index].amount
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
                                  .inventoryCategory![index].category!.nameAr
                                  .toString(),
                              style: Styles.textStyle16,
                            ),
                            scrollable: true,
                            content: Form(
                              key: formKey,
                              child: BlocConsumer<InventoryCatCubit,
                                  InventoryCatState>(
                                listener: (context, state) {
                                  if (state is SuccessPutAllActiveCategory) {
                                    Navigator.of(context).pop();
                                  } else if (state
                                      is FailurePutAllActiveCategory) {
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
                                          onChange: (x) {
                                            print(x);
                                          },
                                          inputFormatters: [
                                            FilteringTextInputFormatter
                                                .digitsOnly
                                          ],
                                          keyboardType: TextInputType.number,
                                          controller: returnsController,
                                          // -- enter Amount Of rest  ----
                                          hintText:
                                              S.of(context).enterAmountOfAmount,
                                          //---------------------------
                                          onTap: (x) {},
                                          validator: (x) {
                                            if (x!.isEmpty) {
                                              return S
                                                  .of(context)
                                                  .pleaseEnterAmountD;
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
                                    num amount =
                                        num.parse(returnsController.text);
                                    Map<String, dynamic> data = {
                                      "amount": amount,
                                      // "sp_expenses": spExpenses
                                    };
                                    inventoryCubit.editInventoryCategoryAmount(
                                      categoryID: inventoryCubit
                                          .inventoryCatDetails
                                          .inventoryCategory![index]
                                          .id!,
                                      data: data,
                                      inventoryID: inventoryCubit
                                          .inventoryCat[inventoryIndex].id!,
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

                        // TrailingOfListTileDetails(
                        //       categoryIndex: index,
                        //       inventoryID: inventoryCubit
                        //           .inventoryCat[inventoryIndex].id!,
                        //     )
                      },
                      title: TitleOfListTileDetails(
                        categoryIndex: index,
                      ),
                      subtitle: SubTitleOfListTileDetails(
                        categoryIndex: index,
                      ),
                      trailing: IconButton(
                        onPressed: () => {
                          showDialog(
                            context: context,
                            builder: (context) => ConfermDialog(
                              title: S.of(context).confirmDeleteCategory,
                              onPressed: () {
                                var id = inventoryCubit.inventoryCatDetails
                                    .inventoryCategory![index].id!;
                                inventoryCubit.deleteCategory(
                                    id: id,
                                    inventoryId: inventoryCubit
                                        .inventoryCat[inventoryIndex].id!);
                                Navigator.of(context).pop();
                              },
                            ),
                          ),
                        },
                        icon: const Icon(
                          Icons.delete,
                          color: Colors.red,
                        ),
                      ),
                    ),
                  ),
                );
              },
              itemCount:
                  inventoryCubit.inventoryCatDetails.inventoryCategory!.length,
            ),
          ),
        ),
      ],
    );
  }
}
