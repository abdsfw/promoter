import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:promoter/Features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:promoter/Features/inventoryUpdate/presentation/manager/cubit/inventory_cat_cubit.dart';
import 'package:promoter/Features/inventoryUpdate/presentation/view/widget/add_inventry.dart';
import 'package:promoter/core/utils/styles.dart';
import 'package:promoter/core/utils/widgets/custom_error_widget.dart';
import 'package:promoter/core/utils/widgets/custom_loading_indicator.dart';

import '../../../../../core/utils/widgets/custom_text_form_field.dart';
import '../../../../../generated/l10n.dart';
import 'inventory_details_body.dart';

class InventoryDetails extends StatelessWidget {
  const InventoryDetails(
      {super.key, required this.inventoryIndex, required this.schoolIndex});
  final int inventoryIndex;

  final int schoolIndex;
  void onPlusButtonPressed(BuildContext context, BillPageCubit inventoryCubit,
      InventoryCatCubit inventoryCatCubit) {
    try {
      inventoryCubit.fetchAllActiveCAtegory();

      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => AddInventory(
            spID: inventoryCubit.currentPromoterSp[schoolIndex].id!,
            isEdit: true,
            inventoryID: inventoryCatCubit.inventoryCat[inventoryIndex].id!,
          ),
        ),
      );
    } catch (e) {
      print('Navigation error: $e');
      // Handle the error appropriately
    }
  }

  @override
  Widget build(BuildContext context) {
    InventoryCatCubit inventoryCubit = InventoryCatCubit.get(context);
    BillPageCubit billCubit = BillPageCubit.get(context);

    String date = DateFormat('yyyy-MM-dd', 'en')
        .format(inventoryCubit.inventoryCat[inventoryIndex].date!);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          date,
          style: Styles.textStyle18,
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add), // You can customize the icon as needed
            onPressed: () {
              try {
                inventoryCubit.fetchAllActiveCAtegory();

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => AddInventory(
                      spID: billCubit.currentPromoterSp[schoolIndex].id!,
                      isEdit: true,
                      inventoryID:
                          inventoryCubit.inventoryCat[inventoryIndex].id!,
                    ),
                  ),
                );
              } catch (e) {
                print('Navigation error: $e');
                // Handle the error appropriately
              }
            },
          ),
        ],
      ),
      body: BlocConsumer<InventoryCatCubit, InventoryCatState>(
        listener: (context, state) {
          // TODO: implement listener
        },
        builder: (context, state) {
          if (state is LoadingFetchInventoryDetailsState) {
            return const CustomLoadingIndicator(
              color: Colors.white,
            );
          } else if (state is FailureFetchInventoryDetailsState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomErrorWidget(errMessage: state.errMessage),
                IconButton(
                  onPressed: () {
                    inventoryCubit.fetchInventoryDetails(
                      inventoryID:
                          inventoryCubit.inventoryCat[inventoryIndex].id!,
                    );
                  },
                  icon: const Icon(
                    Icons.refresh,
                    size: 40,
                  ),
                ),
              ],
            );
          } else {
            return InventoryDetailsBody(
              inventoryIndex: inventoryIndex,
            );
          }
        },
      ),
    );
  }
}
