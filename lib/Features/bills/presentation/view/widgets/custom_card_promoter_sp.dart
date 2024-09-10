import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:promoter/Features/bills/presentation/manager/cubit/bill_page_cubit.dart';
// import 'package:promoter/Features/bills/presentation/view/widgets/school_details.dart';
import 'package:promoter/Features/bills/presentation/view/widgets/sp_bills.dart';
import 'package:promoter/core/utils/widgets/custom_error_widget.dart';
import 'package:promoter/core/utils/widgets/custom_loading_indicator.dart';
// import 'package:promoter/core/utils/app_router.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../generated/l10n.dart';

class CustomCardPromoterSp extends StatelessWidget {
  const CustomCardPromoterSp({
    super.key,
    required this.indexCard,
  });
  final int indexCard;
  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    return Card(
      child: ListTile(
        title: Text(
          billCubit.currentPromoterSp[indexCard].name ?? 'S-error',
          style: Styles.textStyle14.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        leading: const Icon(Icons.school_outlined),
        trailing: ElevatedButton(
          onPressed: () {
            billCubit.emit(SuccessFetchSchoolState());

            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                scrollable: true,
                content: BlocConsumer<BillPageCubit, BillPageState>(
                  listener: (context, state) {
                    // TODO: implement listener
                  },
                  builder: (context, state) {
                    if (state is LoadingHolidayGet) {
                      return const CustomLoadingIndicator(
                        color: Colors.black,
                      );
                    } else if (state is FailureHolidayGet) {
                      return CustomErrorWidget(errMessage: state.errMessage);
                    } else if (state is SuccessHolidayGet) {
                      return const Icon(
                        Icons.done_all_sharp,
                        color: Colors.green,
                      );
                    }
                    return Text(
                      S.of(context).holidayConfirm,
                      style: Styles.textStyle14,
                    );
                  },
                ),
                actions: [
                  BlocBuilder<BillPageCubit, BillPageState>(
                    builder: (context, state) {
                      if (state is! LoadingHolidayGet &&
                          state is! SuccessHolidayGet) {
                        return ElevatedButton.icon(
                          onPressed: () {
                            billCubit.callHolidayApiGet(
                                sellPointId:
                                    billCubit.currentPromoterSp[indexCard].id!);
                          },
                          icon: const Icon(
                            Icons.done_outline_rounded,
                            color: Colors.green,
                          ),
                          label: Text(
                            S.of(context).ok,
                            style: Styles.textStyle14,
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                  BlocBuilder<BillPageCubit, BillPageState>(
                    builder: (context, state) {
                      if (state is! LoadingHolidayGet) {
                        return ElevatedButton.icon(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          icon: const Icon(
                            Icons.cancel,
                            color: Colors.red,
                          ),
                          label: Text(
                            S.of(context).cancel,
                            style: Styles.textStyle14,
                          ),
                        );
                      } else {
                        return const SizedBox();
                      }
                    },
                  ),
                ],
              ),
            );
          },
          child: Text(
            S.of(context).holiday,
            style: Styles.textStyle14,
          ),
        ),
        // Text(
        //   billCubit.currentPromoterSp[indexCard].school?.region?? 'region-S-error',
        //   style: Styles.textStyle12.copyWith(fontSize: 10),
        // ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            Text(
              billCubit.currentPromoterSp[indexCard].school?.nameAr ?? "error",
              style: Styles.textStyle12,
            ),
            const Divider(),
            Text(
              billCubit.currentPromoterSp[indexCard].school?.nameEn ?? 'error',
              style: Styles.textStyle14,
            ),
          ],
        ),
        onTap: () {
          if (kDebugMode) {
            print("promoter id:${billCubit.currentPromoterSp[indexCard].id}");
          }
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text(
                // ---- Select invoice type --------
                S.of(context).firstDialogInBIllTitle,
                // ---------------------------------
                style: Styles.textStyle18,
              ),
              // actionsAlignment: MainAxisAlignment.start,
              // actionsAlignment: MainAxisAlignment.end,
              actions: [
                // General invoice
                ElevatedButton(
                  onPressed: () {
                    String dateSelected =
                        DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
                    var data = {
                      "date": dateSelected,
                    };
                    print(data);
                    billCubit.getSpBills(
                      data,
                      billCubit.currentPromoterSp[indexCard].id!,
                    );
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SpBillsPage(
                          sellPointId:
                              billCubit.currentPromoterSp[indexCard].id!,
                          schoolIndex: indexCard,
                          isToSp: false,
                          spName: billCubit.currentPromoterSp[indexCard].name!,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    // --- General Invoices  ---
                    S.of(context).firstDialogInBIllOne,
                    // ---------------------------------
                    style: Styles.textStyle16,
                  ),
                ),
                // invoice to another sp
                ElevatedButton(
                  onPressed: () {
                    // here we should call methods for this page
                    String dateSelected =
                        DateFormat('yyyy-MM-dd', 'en').format(DateTime.now());
                    var data = {
                      "date": dateSelected,
                    };
                    print(data);
                    billCubit.getSpToSpBills(
                        data, billCubit.currentPromoterSp[indexCard].id!);
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => SpBillsPage(
                          sellPointId:
                              billCubit.currentPromoterSp[indexCard].id!,
                          schoolIndex: indexCard,
                          isToSp: true,
                          spName: billCubit.currentPromoterSp[indexCard].name!,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    // -- Invoices for other Sell Point --
                    S.of(context).firstDialogInBIllTwo,
                    // -----------------------------------
                    style: Styles.textStyle16,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
