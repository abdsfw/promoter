// import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:promoter/Features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:promoter/Features/bills/presentation/view/widgets/conferm_dialog.dart';
import 'package:promoter/core/utils/pdf_create.dart';
import 'package:promoter/core/utils/styles.dart';
import 'package:promoter/core/utils/widgets/custom_error_widget.dart';
import 'package:promoter/core/utils/widgets/custom_loading_indicator.dart';

import '../../../../../generated/l10n.dart';
import 'category_order_page.dart';
import 'custom_card_category_of_bill.dart';

// 80.30
// 79.08
// 70
class BillDetails extends StatelessWidget {
  const BillDetails({
    super.key,
    required this.billID,
    // required this.parentIndex,
    required this.billIndex,
    required this.sellpointId,
    required this.isStore,
    required this.isToSp,
    required this.spName,
    this.toSpName = 'none',
    required this.type,
  });
  final int billID;
  final int sellpointId;
  final bool isStore;
  final String type;
  // final int parentIndex;
  final bool isToSp;
  final int billIndex;
  final String spName;
  final String toSpName;
  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    // String date = formatDate(
    //     billCubit.currentPromoterSp[parentIndex].bills![billIndex].date!,
    //     [yyyy, '-', mm, '-', dd]);
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.chevron_left_outlined,
          ),
          onPressed: () {
            if (billCubit.changeDate) {
              String dateSelected = DateFormat('yyyy-MM-dd', 'en')
                  .format(billCubit.selectedDAteforShowBill!);
              var data = {
                "date": dateSelected,
              };
              // !here if we add change date to transport bills
              // !we notify billCubit.changeDate variable
              // (isToSp)
              //     ? billCubit.getSpToSpBills(
              //         data,
              //         sellpointId,
              //       )
              //     :
              billCubit.getSpBills(
                data,
                sellpointId,
              );
            }
            Navigator.of(context).pop();
            billCubit.categoryBIll = [];
            billCubit.changeDate = false;
          },
        ),
        // title: Text(date),
        actions: [
          ElevatedButton(
            onPressed: () async {
              String arabicType;
//               if (isToSp) {
//                 if (isStore) {
//                   if (billCubit.billsOfSpToSp[billIndex].type == 'default') {
//                     type = 'فاتورة اطعمة';
//                   } else if (billCubit.billsOfSpToSp[billIndex].type ==
//                       'returns') {
//                     type = 'فاتورة مرتجعات';
//                   } else if (billCubit.billsOfSpToSp[billIndex].type ==
//                       'expenses') {
//                     type = 'فاتورة عينات مشرف';
//                   } else if (billCubit.billsOfSpToSp[billIndex].type ==
//                       'expens_manager') {
//                     type = 'فاتورة عينات إدارة';
//                   } else if (billCubit.billsOfSpToSp[billIndex].type ==
//                       'expens_doctor') {
//                     type = 'فاتورة عينات طبيب';
//                   } else if (billCubit.billsOfSpToSp[billIndex].type ==
//                       'external') {
//                     type = 'فاتورة خارجية ';
//                   } else {
//                     type = 'فاتورة مواد أولية';
//                   }
//                 } else {
// if (billCubit.billsOfSpToSpRaw[billIndex].type == 'default') {
//                     type = 'فاتورة اطعمة';
//                   } else if (billCubit.billsOfSpToSpRaw[billIndex].type ==
//                       'returns') {
//                     type = 'فاتورة مرتجعات';
//                   } else if (billCubit.billsOfSpToSpRaw[billIndex].type ==
//                       'expenses') {
//                     type = 'فاتورة عينات مشرف';
//                   } else if (billCubit.billsOfSpToSpRaw[billIndex].type ==
//                       'expens_manager') {
//                     type = 'فاتورة عينات إدارة';
//                   } else if (billCubit.billsOfSpToSpRaw[billIndex].type ==
//                       'expens_doctor') {
//                     type = 'فاتورة عينات طبيب';
//                   } else if (billCubit.billsOfSpToSpRaw[billIndex].type ==
//                       'external') {
//                     type = 'فاتورة خارجية ';
//                   } else {
//                     type = 'فاتورة مواد أولية';
//                   }
//                 }
//               } else {
//                 if (isStore) {
//                   if (billCubit.billsOfSp[billIndex].type == 'default') {
//                     type = 'فاتورة اطعمة';
//                   } else if (billCubit.billsOfSp[billIndex].type ==
//                       'returns') {
//                     type = 'فاتورة مرتجعات';
//                   } else if (billCubit.billsOfSp[billIndex].type ==
//                       'expenses') {
//                     type = 'فاتورة عينات مشرف';
//                   } else if (billCubit.billsOfSp[billIndex].type ==
//                       'expens_manager') {
//                     type = 'فاتورة عينات إدارة';
//                   } else if (billCubit.billsOfSp[billIndex].type ==
//                       'expens_doctor') {
//                     type = 'فاتورة عينات طبيب';
//                   } else if (billCubit.billsOfSp[billIndex].type ==
//                       'external') {
//                     type = 'فاتورة خارجية ';
//                   } else {
//                     type = 'فاتورة مواد أولية';
//                   }
//                 } else {
//                    if (billCubit.billsOfSpRaw[billIndex].type == 'default') {
//                     type = 'فاتورة اطعمة';
//                   } else if (billCubit.billsOfSpRaw[billIndex].type ==
//                       'returns') {
//                     type = 'فاتورة مرتجعات';
//                   } else if (billCubit.billsOfSpRaw[billIndex].type ==
//                       'expenses') {
//                     type = 'فاتورة عينات مشرف';
//                   } else if (billCubit.billsOfSpRaw[billIndex].type ==
//                       'expens_manager') {
//                     type = 'فاتورة عينات إدارة';
//                   } else if (billCubit.billsOfSpRaw[billIndex].type ==
//                       'expens_doctor') {
//                     type = 'فاتورة عينات طبيب';
//                   } else if (billCubit.billsOfSpRaw[billIndex].type ==
//                       'external') {
//                     type = 'فاتورة خارجية ';
//                   } else {
//                     type = 'فاتورة مواد أولية';
//                   }
//                 }
//               }
              switch (type) {
                case 'default':
                  arabicType = 'فاتورة اطعمة';
                  break;
                case 'expens_doctor':
                  arabicType = 'فاتورة عينات طبيب';
                  break;
                case 'expens_manager':
                  arabicType = 'فاتورة عينات إدارة';
                  break;
                case 'expenses':
                  arabicType = 'فاتورة عينات مشرف';
                  break;
                case 'external':
                  arabicType = 'فاتورة خارجية ';
                  break;
                case 'returns':
                  arabicType = 'فاتورة مرتجعات';
                  break;
                default:
                  arabicType = 'فاتورة مواد أولية';
              }
              PdfCreate.generateBillPDF(
                type: arabicType,
                selectedDate: (isToSp)
                    ? (isStore)
                        ? billCubit.billsOfSpToSp[billIndex].date!
                        : billCubit.billsOfSpToSpRaw[billIndex].date!
                    : (isStore)
                        ? billCubit.billsOfSp[billIndex].date!
                        : billCubit.billsOfSpRaw[billIndex].date!,
                categoryBIll: billCubit.categoryBIll,
                spName: spName,
                toSpName: toSpName,
              );
            },
            child: Text(
              S.of(context).pdf,
            ),
          ),
          (isToSp)
              ? const SizedBox()
              : ElevatedButton(
                  onPressed: () {
                    showDatePicker(
                      context: context,
                      initialDate: billCubit.selectedDAteforShowBill!,
                      firstDate: DateTime(2020),
                      lastDate: DateTime(2030),
                    ).then(
                      (value) {
                        if (value != null) {
                          String dateSelected =
                              DateFormat('yyyy-MM-dd', 'en').format(value);
                          var data = {
                            "date": dateSelected,
                          };
                          showDialog(
                            context: context,
                            builder: (context) =>
                                BlocConsumer<BillPageCubit, BillPageState>(
                              listener: (context, state) {
                                if (state is SuccessEditBIllDate) {
                                  Navigator.of(context).pop();
                                  showDialog(
                                    context: context,
                                    builder: (context) => ConfermDialog(
                                      title: S.of(context).successEditDate,
                                      isAlert: true,
                                    ),
                                  );
                                }
                              },
                              builder: (context, state) {
                                if (state is LoadingEditBIllDate) {
                                  return const CustomLoadingIndicator(
                                    color: Colors.white,
                                  );
                                } else if (state is FailureEditBIllDate) {
                                  return CustomErrorWidget(
                                      errMessage: state.errMessage);
                                } else {
                                  return ConfermDialog(
                                    title: S.of(context).editDateTitle,
                                    onPressed: () {
                                      billCubit.updateDateBIll(
                                        data,
                                        billID,
                                      );
                                      billCubit.changeDate = true;
                                    },
                                  );
                                }
                              },
                            ),
                          );

                          print(data);
                        }
                      },
                    );
                  },
                  child: Text(
                    S.of(context).editDate,
                  ),
                ),
        ],
      ),
      body: BlocConsumer<BillPageCubit, BillPageState>(
        listener: (context, state) {
          if (state is SuccessUpdateCAtegoryOfBIll) {
            showDialog(
              context: context,
              builder: (context) => const ConfermDialog(
                title: 'تم تحديث العنصر بنجاح',
                isAlert: true,
              ),
            );
          } else if (state is SuccessDeleteCAtegoryOfBIll) {
            showDialog(
              context: context,
              builder: (context) => const ConfermDialog(
                title: 'تم حذف العنصر بنجاح',
                isAlert: true,
              ),
            );
          } else if (state is SuccessAddCAtegoryOfBIll) {
            showDialog(
              context: context,
              builder: (context) => const ConfermDialog(
                title: 'تم إضافة العنصر بنجاح',
                isAlert: true,
              ),
            );
          } else if (state is FailureDeleteCAtegoryOfBIll) {
            showDialog(
              context: context,
              builder: (context) => ConfermDialog(
                title: state.errMessage,
                isAlert: true,
              ),
            );
          } else if (state is FailureAddCAtegoryOfBIll) {
            showDialog(
              context: context,
              builder: (context) => ConfermDialog(
                title: state.errMessage,
                isAlert: true,
              ),
            );
          } else if (state is FailureUpdateCAtegoryOfBIll) {
            showDialog(
              context: context,
              builder: (context) => ConfermDialog(
                title: state.errMessage,
                isAlert: true,
              ),
            );
          }
        },
        builder: (context, state) {
          return BlocBuilder<BillPageCubit, BillPageState>(
            builder: (context, state) {
              if (state is LoadingFetchCAtegoryOfBIll ||
                  state is LoadingDeleteCAtegoryOfBIll ||
                  state is LoadingAddCAtegoryOfBIll ||
                  state is LoadingUpdateCAtegoryOfBIll) {
                return const CustomLoadingIndicator(
                  color: Colors.white,
                );
              } else if (state is FailureFetchCAtegoryOfBIll) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CustomErrorWidget(
                      errMessage: state.errMessage,
                    ),
                    IconButton(
                      onPressed: () {
                        (isToSp)
                            ? billCubit.fetchBillDetailsTOSp(
                                billId: billID,
                              )
                            : billCubit.fetchBillDetails(
                                billId: billID,
                              );
                      },
                      icon: const Icon(
                        Icons.replay_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                );
              } else {
                if (billCubit.categoryBIll.length == 0) {
                  return Center(
                    child: Text(
                      // ---- no Data to Display ------
                      S.of(context).noDatatoDisplay,
                      // ---------------------------
                      style: Styles.textStyle18,
                    ),
                  );
                } else {
                  return Column(
                    children: [
                      BlocBuilder<BillPageCubit, BillPageState>(
                        builder: (context, state) {
                          double totalPrice = 0;
                          int totalAmount = 0;
                          for (var i = 0;
                              i < billCubit.categoryBIll.length;
                              i++) {
                            double totalApi = double.parse(billCubit
                                .categoryBIll[i].totalPrice
                                .toString());
                            totalPrice += totalApi;
                            int amountApi = int.parse(
                                billCubit.categoryBIll[i].amount.toString());
                            totalAmount += amountApi;
                          }
                          return Card(
                            child: ListTile(
                              title: Text(
                                '${S.of(context).totalAMount}: $totalAmount',
                                style: Styles.textStyle16,
                              ),
                              subtitle: Text(
                                '${S.of(context).totalPRice}: ${totalPrice.toStringAsFixed(2)}',
                                style: Styles.textStyle16,
                              ),
                            ),
                          );
                        },
                      ),
                      Expanded(
                        child: ListView.builder(
                          itemCount: billCubit.categoryBIll.length,
                          itemBuilder: (context, index) =>
                              CustomCardCategoryOfBill(
                            isToSp: isToSp,
                            categoryIndex: index,
                            billId: billID,
                          ),
                        ),
                      ),
                    ],
                  );
                }
              }
            },
          );
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
      floatingActionButton: (isToSp)
          ? null
          : FloatingActionButton(
              child: const Icon(Icons.add),
              onPressed: () {
                // billCubit.fetchAllActiveCAtegory();

                // Navigator.of(context).push(
                //   MaterialPageRoute(
                //     builder: (context) => CategoryOrderPage(
                //       sellPointId: billCubit.currentBills[parentIndex].id!,
                //       isEdit: true,
                //     ),
                //   ),
                // );
                print(isStore);
                billCubit.fetchAllActiveCAtegory();
                // bool typeOfOrder;

                // if (type == 'default') {
                //   typeOfOrder = true;
                // } else if (type == 'returns') {
                //   typeOfOrder = true;
                // } else if (type == 'expenses') {
                //   typeOfOrder = true;
                // } else if (type == 'external') {
                //   typeOfOrder = true;
                // } else {
                //   typeOfOrder = false;
                // }
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => CategoryOrderPage(
                      sellPointId: sellpointId,
                      isEdit: true,
                      // type: type,
                      isStore: (type == 'raw') ? false : true,
                      billID: billID,
                      isToSp: isToSp,
                      type: type,
                    ),
                  ),
                );
                /*
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              actionsOverflowDirection: VerticalDirection.down,
              actionsAlignment: MainAxisAlignment.spaceBetween,
              title: Text(
                // --- selectItemType ------
                S.of(context).selectItemType,
                // -------------------------
                style: Styles.textStyle18,
              ),
              actions: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    billCubit.fetchAllActiveCAtegory();

                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategoryOrderPage(
                          sellPointId: sellpointId,
                          isEdit: true,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    // ---- foods -----
                    S.of(context).foods,
                    // -----------------
                    style: Styles.textStyle14,
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    billCubit.fetchAllActiveCAtegory();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => CategoryOrderPage(
                          sellPointId: sellpointId,
                          isEdit: true,
                          isStore: false,
                        ),
                      ),
                    );
                  },
                  child: Text(
                    // ----- raw materials ----
                    S.of(context).rawMaterials,
                    // ------------------------
                    style: Styles.textStyle14,
                  ),
                ),
              ],
            ),
          );
          */
              },
            ),
    );
  }
}
