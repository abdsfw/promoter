import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:promoter/Features/bills/presentation/view/widgets/conferm_dialog.dart';
import 'package:promoter/Features/inventoryUpdate/presentation/view/widget/inventory_details.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_error_widget.dart';
import '../../../../../core/utils/widgets/custom_loading_indicator.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/inventory_cat_cubit.dart';

class FoodInventoryListView extends StatelessWidget {
  const FoodInventoryListView({
    super.key,
    required this.schoolIndex,
  });

  final int schoolIndex;
  @override
  Widget build(BuildContext context) {
    InventoryCatCubit inventoryCubit = InventoryCatCubit.get(context);

    return BlocConsumer<InventoryCatCubit, InventoryCatState>(
      listener: (context, state) {
        // TODO: implement listener
      },
      builder: (context, state) {
        if (state is LoadingFetchInventoryState) {
          return const CustomLoadingIndicator(
            color: Colors.white,
          );
        } else if (state is FailureFetchInventoryState) {
          return CustomErrorWidget(errMessage: state.errMessage);
        } else if (inventoryCubit.inventoryCat.length == 0) {
          return Center(
            child: Text(
              S.of(context).noDatatoDisplay,
              style: Styles.textStyle20,
            ),
          );
        } else {
          return ListView.builder(
            itemCount: inventoryCubit.inventoryCat.length,
            itemBuilder: (context, index) {
              String date = DateFormat('yyyy-MM-dd', 'en')
                  .format(inventoryCubit.inventoryCat[index].date!);
              return Card(
                child: ListTile(
                  title: Text(
                    date,
                    style: Styles.textStyle18,
                  ),
                  // subtitle: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   children: [
                  //     Text(
                  //       // -- Total price of returns ---
                  //       '${S.of(context).totalPriceE}: ${inventoryCubit.inventoryCat[index].totalPrice.toString()}',
                  //       style: Styles.textStyle16,
                  //     ),
                  //     Text(
                  //       // -- Total expenses price --
                  //       '${S.of(context).totalExpenses}: ${inventoryCubit.inventoryCat[index].totalExpenses.toString()}',
                  //       style: Styles.textStyle16,
                  //     ),
                  //   ],
                  // ),

                  trailing: IconButton(
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.red,
                    ),
                    onPressed: () {
                      // ------------- To experiment -------------------

                      var id = inventoryCubit.inventoryCat[index].id!;

                      // print(billCubit.categoryBIll[categoryIndex].categoryId!);
                      // -----------------------------------------------
                      showDialog(
                        context: context,
                        builder: (context) => ConfermDialog(
                          // --- Do you want to delete this item? ----
                          title: S.of(context).confirmDeleteInventory,
                          // -----------------------------------------
                          onPressed: () {
                            inventoryCubit.deleteInventory(
                                id: id,
                                spID: schoolIndex,
                                body: {"date": date});
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    },
                  ),
                  onTap: () {
                    print(
                        'inventory ID : ${inventoryCubit.inventoryCat[index].id.toString()}');
                    inventoryCubit.fetchInventoryDetails(
                      inventoryID: inventoryCubit.inventoryCat[index].id!,
                    );
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => InventoryDetails(
                          inventoryIndex: index,
                          schoolIndex:  schoolIndex,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
          );
        }
      },
    );
  }
}
