import 'package:flutter/material.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/inventory_cat_cubit.dart';

class SubTitleOfListTileDetails extends StatelessWidget {
  const SubTitleOfListTileDetails({
    super.key,
    // required this.inventoryIndex,
    required this.categoryIndex,
  });
  // final int inventoryIndex;
  final int categoryIndex;

  @override
  Widget build(BuildContext context) {
    InventoryCatCubit inventoryCubit = InventoryCatCubit.get(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '${S.of(context).amountOfPrice}: ${inventoryCubit.inventoryCatDetails.inventoryCategory![categoryIndex].amount.toString()}',
          style: Styles.textStyle16,
        ),
        // Text(
        //   '${S.of(context).amountOfExpenses}: ${inventoryCubit.inventoryCatDetails.inventoryCategory![categoryIndex].spExpenses.toString()}',
        //   style: Styles.textStyle16,
        // ),
        Text(
          '${S.of(context).price}: ${inventoryCubit.inventoryCatDetails.inventoryCategory![categoryIndex].category!.price.toString()}',
          style: Styles.textStyle16,
        ),
      ],
    );
  }
}
