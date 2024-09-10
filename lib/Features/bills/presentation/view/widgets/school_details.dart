// import 'package:date_format/date_format.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:multi_select_flutter/dialog/multi_select_dialog_field.dart';
// import 'package:multi_select_flutter/util/multi_select_item.dart';
// import 'package:multi_select_flutter/util/multi_select_list_type.dart';
// import 'package:promoter/Features/bills/presentation/manager/cubit/bill_page_cubit.dart';
// import 'package:promoter/core/utils/styles.dart';
// import 'package:promoter/core/utils/widgets/custom_error_widget.dart';
// import 'package:promoter/core/utils/widgets/custom_loading_indicator.dart';
// import 'package:promoter/generated/l10n.dart';
// import 'add_bill_dialog.dart';
// import 'bill_details.dart';
// import 'category_order_page.dart';
// import 'conferm_dialog.dart';
// import 'delete_alert_dialog.dart';
// import '../../../../../generated/l10n.dart';

// class SpBills extends StatelessWidget {
//   const SpBills({super.key, required this.parentIndex});
//   final int parentIndex;
//   @override
//   Widget build(BuildContext context) {
//     BillPageCubit billCubit = BillPageCubit.get(context);
//     return DefaultTabController(
//       length: 2,
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(billCubit.currentPromoterSp[parentIndex].school!.nameAr!),
//           leading: IconButton(
//             icon: const Icon(Icons.chevron_left_rounded),
//             onPressed: () {
//               // billCubit.fetchAllBills();

//               Navigator.of(context).pop();
//             },
//           ),
//         ),

//         body: BlocConsumer<BillPageCubit, BillPageState>(
//           listener: (context, state) {
//             if (state is FailureDeleteBill) {
//               showDialog(
//                 context: context,
//                 builder: (context) => const DeleteAlertDialog(
//                   // title: 'delete bill filure',
//                   title: 'خطأ في الحذف',
//                   icon: Icon(Icons.error),
//                 ),
//               );
//             } else if (state is SuccessDeleteBill) {
//               showDialog(
//                 context: context,
//                 builder: (context) => const DeleteAlertDialog(
//                   // title: 'delete bill Success',
//                   title: 'تم حذف الفاتورة بنجاح',
//                   icon: Icon(Icons.done_all),
//                 ),
//               );
//             } else if (state is FailureFetchBillState) {
//               showDialog(
//                 context: context,
//                 builder: (context) => const DeleteAlertDialog(
//                   // title: 'failuer in add bill',
//                   title: ' خطأ في جلب المعلومات الجديدة',
//                   icon: Icon(Icons.error),
//                 ),
//               );
//             } else if (state is FailureAddBillState) {
//               showDialog(
//                 context: context,
//                 builder: (context) => const DeleteAlertDialog(
//                   // title: 'failuer in add bill',
//                   title: 'خطأ في إضافة الفاتورة',
//                   icon: Icon(Icons.error),
//                 ),
//               );
//             }
//           },
//           builder: (context, state) {
//             if (state is LoadingDeleteBill ||
//                 state is LoadingFetchBillState ||
//                 state is LoadingAddBillState) {
//               return const CustomLoadingIndicator(
//                 color: Colors.black,
//               );
//             } else {
//               if (billCubit.currentPromoterSp[parentIndex].bills!.length == 0) {
//                 return const Center(
//                   child: Text('لا يوجد بيانات للعرض'),
//                 );
//               } else {
//                 return ListView.builder(
//                   itemCount:
//                       billCubit.currentPromoterSp[parentIndex].bills!.length,
//                   itemBuilder: (context, index) {
//                     String date = formatDate(
//                         billCubit.currentPromoterSp[parentIndex].bills![index]
//                             .createdAt!,
//                         [yyyy, '-', mm, '-', dd]);
//                     return Card(
//                       child: ListTile(
//                         // title: Text(
//                         //   billCubit
//                         //       .currentBills[parentIndex].bills![index].createdAt
//                         //       .toString(),
//                         // ),
//                         title: Text(date),
//                         leading: const Icon(Icons.blinds_closed),
//                         trailing: IconButton(
//                           icon: const Icon(
//                             Icons.delete_rounded,
//                             color: Colors.red,
//                           ),
//                           // color: Colors.red,
//                           onPressed: () {
//                             showDialog(
//                               context: context,
//                               builder: (context) => ConfermDialog(
//                                 // title: 'do you want to delete this bill??',
//                                 title: 'هل تريد حذف هذه الفاتورة؟؟',
//                                 // title: S.of(context) ,
//                                 // title: S,
//                                 onPressed: () {
//                                   billCubit.deleteBill(
//                                     parentIndex: parentIndex,
//                                     index: index,
//                                     id: billCubit.currentPromoterSp[parentIndex]
//                                         .bills![index].id!,
//                                   );
//                                   Navigator.of(context).pop();
//                                 },
//                               ),
//                             );
//                           },
//                         ),
//                         // subtitle: Text(billCubit.currentBills[index].school!.nameEn!),
//                         onTap: () {
//                           // billCubit.fetchBillDetails(
//                           //   billId: billCubit
//                           //       .currentPromoterSp[parentIndex].bills![index].id!,
//                           // );
//                           // Navigator.of(context).push(
//                           //   MaterialPageRoute(
//                           //     builder: (context) => BillDetails(
//                           //       parentIndex: parentIndex,
//                           //       billIndex: index,
//                           //       billID: billCubit.currentPromoterSp[parentIndex]
//                           //           .bills![index].id!,
//                           //     ),
//                           //   ),
//                           // );
//                         },
//                       ),
//                     );
//                   },
//                 );
//               }
//             }
//           },
//         ),

//         body: Column(
//           children: [
//             TabBar(
//               tabs: [
//                 Tab(child: Text()),
//                 Tab(),
//               ],
//             ),
//           ],
//         ),
//         floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
//         floatingActionButton: FloatingActionButton(
//           child: const Icon(Icons.add),
//           onPressed: () {
//             print('object');
//             // print(DateTime.now().toIso8601String());
//             // if (billCubit.activeCAt.length == 0) {
//             // billCubit.fetchAllActiveCAtegory();
//             // }
//             showDialog(
//               context: context,
//               builder: (context) => AlertDialog(
//                 actionsOverflowDirection: VerticalDirection.down,
//                 actionsAlignment: MainAxisAlignment.spaceBetween,
//                 title: const Text(
//                   'إختر نوع الطلبية',
//                   style: Styles.textStyle18,
//                 ),
//                 actions: [
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       billCubit.fetchAllActiveCAtegory();

//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => CategoryOrderPage(
//                             sellPointId:
//                                 billCubit.currentPromoterSp[parentIndex].id!,
//                           ),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       'طلبية أطعمة',
//                       style: Styles.textStyle14,
//                     ),
//                   ),
//                   ElevatedButton(
//                     onPressed: () {
//                       Navigator.of(context).pop();
//                       billCubit.fetchAllActiveCAtegory();
//                       Navigator.of(context).push(
//                         MaterialPageRoute(
//                           builder: (context) => CategoryOrderPage(
//                             sellPointId:
//                                 billCubit.currentPromoterSp[parentIndex].id!,
//                             isStore: false,
//                           ),
//                         ),
//                       );
//                     },
//                     child: const Text(
//                       'طلبية مواد أولية',
//                       style: Styles.textStyle14,
//                     ),
//                   ),
//                 ],
//               ),
//             );

//             // Navigator.of(context).push(
//             //   MaterialPageRoute(
//             //     builder: (context) => CategoryOrderPage(
//             //       sellPointId: billCubit.currentBills[parentIndex].id!,
//             //     ),
//             //   ),
//             // );

//             // showDialog(
//             //   context: context,
//             //   builder: (context) => AddBillDialog(
//             //     sellPointId: billCubit.currentBills[parentIndex].id!,
//             //     parentIndex: parentIndex,
//             //   ),
//             // );
//           },
//         ),

//       ),
//     );
//   }
// }
