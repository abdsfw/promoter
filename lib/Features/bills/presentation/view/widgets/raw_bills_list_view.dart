import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_loading_indicator.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/bill_page_cubit.dart';
import 'bill_details.dart';
import 'conferm_dialog.dart';

class RawBillsListView extends StatelessWidget {
  const RawBillsListView({
    super.key,
    required this.sellPointId,
    required this.isFood,
    this.isToSp = false,
    required this.spName,
  });
  final int sellPointId;
  final bool isFood;
  final bool isToSp;
  final String spName;

  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    return BlocConsumer<BillPageCubit, BillPageState>(
      listener: (context, state) {
        // print('oooooooooooooo ${billCubit.billsOfSpRaw.length}');

        if (state is FailureFetchBillState) {
          showDialog(
            context: context,
            builder: (context) => ConfermDialog(
              // ----- error in fetch data --------
              title: S.of(context).errorInFetchData,
              // ----------------------------------
              isAlert: true,
            ),
          );
        } else if (state is FailureDeleteBill) {
          showDialog(
            context: context,
            builder: (context) => ConfermDialog(
              // ----- delete bill filure ---------
              title: S.of(context).deleteBillFilure,
              // ----------------------------------
              isAlert: true,
            ),
          );
        } else if (state is SuccessDeleteBill) {
          showDialog(
            context: context,
            builder: (context) => ConfermDialog(
              // ---- delete data successfully -------
              title: S.of(context).successInDeleteData,
              // -------------------------------------
              isAlert: true,
            ),
          );
        } else if (state is FailureAddBillState) {
          showDialog(
            context: context,
            builder: (context) => ConfermDialog(
              // ---- Invoice addition operation failed -------
              title: S.of(context).errorInAddingInvoice,
              // -------------------------------------------
              isAlert: true,
            ),
          );
        } else if (state is SuccessAddBillState) {
          showDialog(
            context: context,
            builder: (context) => ConfermDialog(
              // - Invoice addition has been completed successfully ----
              title: S.of(context).successInAddingInvoice,
              isAlert: true,
              // -------------------------------------------
            ),
          );
        }
      },
      builder: (context, state) {
        if (state is LoadingFetchBillState ||
            state is LoadingDeleteBill ||
            state is LoadingAddBillState) {
          return const CustomLoadingIndicator(
            color: Colors.white,
          );
        } else if (billCubit.billsOfSpRaw.isEmpty && !isToSp) {
          return Center(
            child: Text(
              S.of(context).noDatatoDisplay,
              style: Styles.textStyle20,
            ),
          );
        } else if (billCubit.billsOfSpToSpRaw.isEmpty && isToSp) {
          return Center(
            child: Text(
              S.of(context).noDatatoDisplay,
              style: Styles.textStyle20,
            ),
          );
        } else {
          return ListView.builder(
            itemBuilder: (context, index) {
              // String date = formatDate(
              // billCubit.billsOfSp[index].date!, [yyyy, '-', mm, '-', dd]);
              String date = (isToSp)
                  ? DateFormat('yyyy-MM-dd', 'en')
                      .format(billCubit.billsOfSpToSpRaw[index].date!)
                  : DateFormat('yyyy-MM-dd', 'en')
                      .format(billCubit.billsOfSpRaw[index].date!);
              String type;
              if (billCubit.billsOfSpRaw[index].type == 'default') {
                type = 'فاتورة اطعمة';
              } else if (billCubit.billsOfSpRaw[index].type ==
                  'expens_doctor') {
                type = 'فاتورة عينات طبيب';
              } else if (billCubit.billsOfSpRaw[index].type ==
                  'expens_manager') {
                type = 'فاتورة عينات إدارة';
              } else if (billCubit.billsOfSpRaw[index].type == 'expenses') {
                type = 'فاتورة عينات مشرف';
              } else if (billCubit.billsOfSpRaw[index].type == 'external') {
                type = 'فاتورة خارجية';
              } else if (billCubit.billsOfSpRaw[index].type == 'returns') {
                type = 'فاتورة مرتجع';
              } else if (billCubit.billsOfSpRaw[index].type == 'expens_eco') {
                type = 'فاتورة حالات اقصادية';
              } else {
                type = 'فاتورة مواد أولية';
              }
              return Card(
                child: ListTile(
                  title: Text(date),
                  leading: const Icon(Icons.blinds_closed),
                  subtitle: (isToSp)
                      ? Text(
                          billCubit.billsOfSpToSpRaw[index].toSellPointName
                              .toString(),
                          style: Styles.textStyle16,
                        )
                      : Text(
                          // billCubit.billsOfSpRaw[index].type.toString(),
                          type,
                          style: Styles.textStyle16,
                        ),
                  trailing: (isToSp)
                      ? null
                      : IconButton(
                          icon: const Icon(
                            Icons.delete_rounded,
                            color: Colors.red,
                          ),
                          // color: Colors.red,
                          onPressed: () {
                            showDialog(
                              context: context,
                              builder: (context) => ConfermDialog(
                                // -- do you want to delete this bill?? --
                                title: S.of(context).confirmDeleteBill,
                                // ----------------------------------------
                                onPressed: () {
                                  String dateSelected =
                                      DateFormat('yyyy-MM-dd', 'en').format(
                                          billCubit.selectedDAteforShowBill!);
                                  print(dateSelected);
                                  // String type = (isFood) ? "default" : "raw";
                                  String type =
                                      billCubit.billsOfSpRaw[index].type!;

                                  int billId =
                                      // (isToSp)
                                      // ? billCubit.billsOfSpToSpRaw[index].id!
                                      // :
                                      billCubit.billsOfSpRaw[index].id!;
                                  billCubit.deleteBill(
                                    id: billId,
                                    body: {
                                      "type": type,
                                      "date": dateSelected,
                                    },
                                    spId: sellPointId,
                                  );
                                  Navigator.of(context).pop();
                                },
                              ),
                            );
                          },
                        ),
                  // subtitle: Text(billCubit.currentBills[index].school!.nameEn!),
                  onTap: () {
                    (isToSp)
                        ? billCubit.fetchBillDetailsTOSp(
                            billId: billCubit.billsOfSpToSpRaw[index].id!,
                          )
                        : billCubit.fetchBillDetails(
                            billId: billCubit.billsOfSpRaw[index].id!,
                          );
                    String toSpName = (isToSp)
                        ? billCubit.billsOfSpToSpRaw[index].toSellPointName
                            .toString()
                        : 'none';
                    int billId = (isToSp)
                        ? billCubit.billsOfSpToSpRaw[index].id!
                        : billCubit.billsOfSpRaw[index].id!;
                    String type = (isToSp)
                        ? billCubit.billsOfSpToSpRaw[index].type!
                        : billCubit.billsOfSpRaw[index].type!;

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => BillDetails(
                          type: type,
                          isStore: isFood,
                          // parentIndex: parentIndex,
                          sellpointId: sellPointId,
                          billIndex: index,
                          billID: billId,
                          isToSp: isToSp,
                          spName: spName,
                          toSpName: toSpName,
                        ),
                      ),
                    );
                  },
                ),
              );
            },
            itemCount: (isToSp)
                ? billCubit.billsOfSpToSpRaw.length
                : billCubit.billsOfSpRaw.length,
          );
        }
      },
    );
  }
}
