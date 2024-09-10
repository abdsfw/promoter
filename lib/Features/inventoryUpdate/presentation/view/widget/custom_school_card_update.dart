import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:promoter/Features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:promoter/Features/inventoryUpdate/presentation/view/widget/enter_category_inventory_page.dart';
import 'package:promoter/core/utils/styles.dart';

import '../../manager/cubit/inventory_cat_cubit.dart';
import 'inventory_bill_page.dart';

class CustomSchoolCardUpdate extends StatelessWidget {
  const CustomSchoolCardUpdate({
    super.key,
    required this.schoolIndex,
  });
  final int schoolIndex;
  @override
  Widget build(BuildContext context) {
    // InventoryCubit inventoryCubit = InventoryCubit.get(context);
    InventoryCatCubit inventoryCubit = InventoryCatCubit.get(context);
    BillPageCubit billCubit = BillPageCubit.get(context);
    return Card(
      child: ListTile(
        title: Text(
          billCubit.currentPromoterSp[schoolIndex].name!,
          style: Styles.textStyle12.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(Icons.school_outlined),
        trailing: Text(
          billCubit.currentPromoterSp[schoolIndex].school!.region!,
          style: Styles.textStyle12,
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Text(billCubit.currentPromoterSp[schoolIndex].school!.nameAr!),
            const Divider(),
            Text(billCubit.currentPromoterSp[schoolIndex].school!.nameEn!),
          ],
        ),
        onTap: () {
          if (kDebugMode) {
            print(billCubit.currentPromoterSp[schoolIndex].id);
          }
          String date = DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
          inventoryCubit.fetchInventory(
              spID: billCubit.currentPromoterSp[schoolIndex].id!,
              body: {
                "date": date,
              });
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => InventoryBillPage(schoolIndex: schoolIndex),
            ),
          );
          // Navigator.of(context).push(
          //   MaterialPageRoute(
          //     builder: (context) => EnterCategoryInventoryPage(
          //       promoterID: billCubit.currentPromoterSp[schoolIndex].id!,
          //       promoterName: billCubit.currentPromoterSp[schoolIndex].name!,
          //     ),
          //   ),
          // );
        },
      ),
    );
  }
}
