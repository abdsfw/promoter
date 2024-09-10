// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import 'package:promoter/Features/bills/presentation/manager/cubit/bill_page_cubit.dart';
// import 'package:promoter/Features/bills/presentation/view/widgets/school_details.dart';
// import 'package:promoter/core/utils/app_router.dart';
// import 'package:promoter/core/utils/styles.dart';

// import '../../../data/models/inventory_model/inventory_category.dart';
// import '../../manager/cubit/inventory_cubit.dart';
// import 'inventory_category.dart';
// import 'inventory_page.dart';

// class CustomSchoolCard extends StatelessWidget {
//   const CustomSchoolCard({
//     super.key,
//     required this.index,
//   });
//   final int index;
//   @override
//   Widget build(BuildContext context) {
//     InventoryCubit inventoryCubit = InventoryCubit.get(context);
//     BillPageCubit billCubit = BillPageCubit.get(context);
//     return Card(
//       child: ListTile(
//         title: Text(
//           billCubit.currentPromoterSp[index].name!,
//           style: Styles.textStyle12.copyWith(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         leading: const Icon(Icons.school_outlined),
//         trailing: Text(
//           billCubit.currentPromoterSp[index].school!.region!,
//           style: Styles.textStyle12,
//         ),
//         subtitle: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const Divider(),
//             Text(billCubit.currentPromoterSp[index].school!.nameAr!),
//             const Divider(),
//             Text(billCubit.currentPromoterSp[index].school!.nameEn!),
//           ],
//         ),
//         onTap: () {
//           // print(billCubit.currentPromoterSp[index].id);
//           // DateTime date = DateTime.now();
//           // inventoryCubit.pickerDate = date;
//           // var body = {"date": date.toIso8601String()};
//           // inventoryCubit.fetchInventory(
//           //     schoolID: billCubit.currentPromoterSp[index].id!, body: body);
//           // Navigator.of(context).push(
//           //   MaterialPageRoute(
//           //     builder: (context) => InventoryPage(
//           //       spID: billCubit.currentPromoterSp[index].id!,
//           //     ),
//           //   ),
//           // );
//           inventoryCubit.fetchAllActiveCAtegory();
//           Navigator.of(context).push(
//             MaterialPageRoute(
//               builder: (context) {
//                 return InventoryCategoryItems(
//                   spNAme: billCubit.currentPromoterSp[index].name!,
//                   spId: billCubit.currentPromoterSp[index].id!,
//                 );
//               },
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
