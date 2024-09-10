import 'package:flutter/material.dart';

import '../../../../../core/utils/styles.dart';
import '../../manager/cubit/inventory_cat_cubit.dart';

class TitleOfListTileDetails extends StatelessWidget {
  const TitleOfListTileDetails({
    super.key,
    // required this.inventoryIndex,
    required this.categoryIndex,
  });
  // final int inventoryIndex;
  final int categoryIndex;

  @override
  Widget build(BuildContext context) {
    InventoryCatCubit inventoryCubit = InventoryCatCubit.get(context);

    return Text(
      inventoryCubit.inventoryCatDetails.inventoryCategory![categoryIndex]
          .category!.nameAr
          .toString(),
      style: Styles.textStyle16,
    );
  }
}
