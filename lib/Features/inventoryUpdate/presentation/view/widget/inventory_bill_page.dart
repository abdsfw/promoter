import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:promoter/Features/inventoryUpdate/presentation/manager/cubit/inventory_cat_cubit.dart';
import 'package:promoter/Features/inventoryUpdate/presentation/view/widget/add_inventry.dart';
import 'package:promoter/Features/inventoryUpdate/presentation/view/widget/inventory_details.dart';
import 'package:promoter/core/utils/styles.dart';
import 'package:promoter/core/utils/widgets/custom_error_widget.dart';
import 'package:promoter/core/utils/widgets/custom_loading_indicator.dart';

import '../../../../../generated/l10n.dart';
import '../../../../bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'food_inventory_list_view.dart';

class InventoryBillPage extends StatelessWidget {
  const InventoryBillPage({super.key, required this.schoolIndex});
  final int schoolIndex;
  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    InventoryCatCubit inventoryCubit = InventoryCatCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          billCubit.currentPromoterSp[schoolIndex].name!,
          style: Styles.textStyle18,
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_outlined,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        actions: [
          ElevatedButton(
            child: Text(
              // ----- choose date ----
              S.of(context).chooseDate,
              // ----------------------
              style: Styles.textStyle14,
            ),
            onPressed: () {
              showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2020),
                lastDate: DateTime(2030),
              ).then(
                (value) {
                  if (value != null) {
                    String dateSelected =
                        DateFormat('yyyy-MM-dd', 'en').format(value);
                    // String date = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
                    inventoryCubit.fetchInventory(
                        spID: billCubit.currentPromoterSp[schoolIndex].id!,
                        body: {
                          "date": dateSelected,
                        });
                    // here call api methods
                  }
                },
              );
            },
          ),
        ],
      ),
      body: FoodInventoryListView(
        schoolIndex: schoolIndex,
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          inventoryCubit.fetchAllActiveCAtegory();
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => AddInventory(
                spID: billCubit.currentPromoterSp[schoolIndex].id!,
                isEdit: false,
              ),
            ),
          );
        },
      ),
    );
  }
}
