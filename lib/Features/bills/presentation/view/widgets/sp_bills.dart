// import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:promoter/Features/bills/presentation/view/widgets/raw_bills_list_view.dart';
import '../../../../../core/utils/styles.dart';
import '../../../../../generated/l10n.dart';
// import '../../../data/models/bill_of_sp_model.dart';
// import '../../../data/models/category_bill_model/category_bill_model.dart';
import '../../manager/cubit/bill_page_cubit.dart';
import 'flouting_sp_bills_page.dart';
import 'food_and_raw_bills_list_view.dart';

class SpBillsPage extends StatelessWidget {
  const SpBillsPage({
    super.key,
    required this.sellPointId,
    required this.schoolIndex,
    required this.isToSp,
    required this.spName,
  });
  final int sellPointId;
  final int schoolIndex;
  final bool isToSp;
  final String spName;
  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);

    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            billCubit.currentPromoterSp[schoolIndex].name!,
            style: Styles.textStyle14.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left_outlined,
            ),
            onPressed: () {
              billCubit.selectedDAteforShowBill = DateTime.now();
              billCubit.billsOfSp = [];
              billCubit.billsOfSpRaw = [];
              billCubit.billsOfSpToSp = [];
              billCubit.billsOfSpToSpRaw = [];
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
                      billCubit.selectedDAteforShowBill = value;
                      String dateSelected =
                          DateFormat('yyyy-MM-dd', 'en').format(value);
                      var data = {
                        "date": dateSelected,
                      };
                      print(data);

                      (isToSp)
                          ? billCubit.getSpToSpBills(data, sellPointId)
                          : billCubit.getSpBills(data, sellPointId);
                    }
                  },
                );
              },
            ),
          ],
        ),
        body: Column(
          children: [
            TabBar(
              labelStyle: Styles.textStyle14,
              tabs: [
                Tab(
                  icon: const Icon(
                    Icons.food_bank,
                  ),
                  // child: Text(
                  text: S.of(context).foods,

                  // ),
                ),
                Tab(
                  icon: const Icon(
                    Icons.all_inbox_rounded,
                  ),
                  // child: Text(
                  text: S.of(context).otherBills,
                  // ),
                ),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  FoodAndRawBillsListView(
                    sellPointId: sellPointId,
                    isFood: true,
                    isToSp: isToSp,
                    spName: spName,
                  ),
                  RawBillsListView(
                    sellPointId: sellPointId,
                    isFood: false,
                    isToSp: isToSp,
                    spName: spName,
                  ),
                  // RawBillsListView(sellPointId: sellPointId),
                ],
              ),
            ),
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        floatingActionButton: FloutingSpBillsPage(
          sellPointId: sellPointId,
          isToSp: isToSp,
        ),
      ),
    );
  }
}
