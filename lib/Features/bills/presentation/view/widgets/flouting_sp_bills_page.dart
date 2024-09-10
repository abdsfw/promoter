import 'package:flutter/material.dart';
import 'package:promoter/Features/bills/presentation/view/widgets/category_order_page.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/bill_page_cubit.dart';

class FloutingSpBillsPage extends StatelessWidget {
  const FloutingSpBillsPage({
    super.key,
    required this.sellPointId,
    required this.isToSp,
  });

  final int sellPointId;
  final bool isToSp;

  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    return FloatingActionButton(
      child: const Icon(Icons.add),
      onPressed: () {
        print('object');

        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            actionsOverflowDirection: VerticalDirection.down,
            actionsAlignment: MainAxisAlignment.spaceBetween,
            title: Text(
              S.of(context).selectOrderType,
              style: Styles.textStyle18,
            ),
            actions: [
              // food order bills - default
              ElevatedButton(
                child: Text(
                  // ----- food order -----
                  S.of(context).foodOrder,
                  // -----------------------
                  style: Styles.textStyle14,
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  (isToSp) ? billCubit.fetchAllSellPoint() : null;
                  billCubit.fetchAllActiveCAtegory();

                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => CategoryOrderPage(
                        sellPointId: sellPointId,
                        isToSp: isToSp,
                        type: 'default',
                        isStore: true,
                      ),
                    ),
                  );
                },
              ),
              // raw material bills - raw
              if (!isToSp)
                ElevatedButton(
                  child: Text(
                    // --- raw Materials Order ---
                    S.of(context).rawMaterialsOrder,
                    // ----------------------------
                    style: Styles.textStyle14,
                  ),
                  onPressed: () async {
                    Navigator.of(context).pop();
                    (isToSp) ? billCubit.fetchAllSellPoint() : null;
                    (isToSp) ? null : billCubit.fetchAllActiveCAtegory();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategoryOrderPage(
                          sellPointId: sellPointId,
                          isToSp: isToSp,
                          type: 'raw',
                          isStore: false,
                        ),
                      ),
                    );
                  },
                ),
              // return bills - returns
              if (!isToSp)
                ElevatedButton(
                  child: Text(
                    // ----- returns -----
                    S.of(context).returns,
                    // -----------------------
                    style: Styles.textStyle14,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    billCubit.fetchAllActiveCAtegory();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategoryOrderPage(
                          sellPointId: sellPointId,
                          isToSp: isToSp,
                          isStore: true,
                          type: 'returns',
                        ),
                      ),
                    );
                  },
                ),
              // expenses bills - expenses
              if (!isToSp)
                ElevatedButton(
                  child: Text(
                    // ----- expenses -----
                    S.of(context).expenses,
                    // -----------------------
                    style: Styles.textStyle14,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    billCubit.fetchAllActiveCAtegory();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategoryOrderPage(
                          sellPointId: sellPointId,
                          isToSp: isToSp,
                          isStore: true,
                          type: 'expenses',
                        ),
                      ),
                    );
                  },
                ),
              // manager expenses - expens_manager
              if (!isToSp)
                ElevatedButton(
                  child: Text(
                    // ----- Manager expenses -----
                    S.of(context).expensesManager,
                    // -----------------------
                    style: Styles.textStyle14,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    billCubit.fetchAllActiveCAtegory();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategoryOrderPage(
                          sellPointId: sellPointId,
                          isToSp: isToSp,
                          isStore: true,
                          type: 'expens_manager',
                        ),
                      ),
                    );
                  },
                ),
              // doctor expenses - expens_doctor
              if (!isToSp)
                ElevatedButton(
                  child: Text(
                    // ----- Doctor expenses -----
                    S.of(context).expensesDoctor,
                    // -----------------------
                    style: Styles.textStyle14,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    billCubit.fetchAllActiveCAtegory();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategoryOrderPage(
                          sellPointId: sellPointId,
                          isToSp: isToSp,
                          isStore: true,
                          type: 'expens_doctor',
                        ),
                      ),
                    );
                  },
                ),
              // external bills - external
              if (!isToSp)
                ElevatedButton(
                  child: Text(
                    // ----- external -----
                    S.of(context).external,
                    // -----------------------
                    style: Styles.textStyle14,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    billCubit.fetchAllActiveCAtegory();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategoryOrderPage(
                          sellPointId: sellPointId,
                          isToSp: isToSp,
                          isStore: true,
                          type: 'external',
                        ),
                      ),
                    );
                  },
                ),
              if (!isToSp)
                ElevatedButton(
                  child: Text(
                    // ----- expens_eco -----
                    S.of(context).expens_eco,
                    // -----------------------
                    style: Styles.textStyle14,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                    billCubit.fetchAllActiveCAtegory();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategoryOrderPage(
                          sellPointId: sellPointId,
                          isToSp: isToSp,
                          isStore: true,
                          type: 'expens_eco',
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        );

        // Navigator.of(context).push(
        //   MaterialPageRoute(
        //     builder: (context) => CategoryOrderPage(
        //       sellPointId: billCubit.currentBills[parentIndex].id!,
        //     ),
        //   ),
        // );

        // showDialog(
        //   context: context,
        //   builder: (context) => AddBillDialog(
        //     sellPointId: billCubit.currentBills[parentIndex].id!,
        //     parentIndex: parentIndex,
        //   ),
        // );
      },
    );
  }
}
