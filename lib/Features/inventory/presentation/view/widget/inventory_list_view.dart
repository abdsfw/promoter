// import 'package:flutter/material.dart';

// import '../../../../../core/utils/pdf_create.dart';
// import '../../../../../generated/l10n.dart';
// import '../../manager/cubit/inventory_cubit.dart';

// class InventoryListView extends StatelessWidget {
//   const InventoryListView({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     InventoryCubit inventoryCubit = InventoryCubit.get(context);

//     return Column(
//       children: [
//         ElevatedButton(
//           onPressed: () async {
//             if (inventoryCubit.inventory!.id != null) {
//               await PdfCreate.generatePDF(
//                 inventoryCubit.pickerDate,
//                 inventoryCubit.inventory!,
//               );
//             } else {
//               showDialog(
//                 context: context,
//                 builder: (context) {
//                   return AlertDialog(
//                     title: Text(S.of(context).noDatatoDisplay),
//                   );
//                 },
//               );
//             }
//           },
//           child: Text(
//             // ---- pdf -----
//             S.of(context).pdf,
//             // ---------------
//           ),
//         ),
//         const Divider(
//           color: Colors.white,
//         ),
//         (inventoryCubit.inventory!.inventories![0].inventoryCategory!.length ==
//                 0)
//             ? const SizedBox()
//             : Card(
//                 child: ListTile(
//                   title: Text(
//                     '${S.of(context).spName}: ${inventoryCubit.inventory!.name}',
//                   ),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                           '${S.of(context).driverName}: ${inventoryCubit.inventory!.driver!.nameAr}'),
//                       Divider(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                               '${S.of(context).envelopeNumber}: ${inventoryCubit.inventory!.envelops![0].number}'),
//                           Text(
//                               '${S.of(context).amountOfEnvelop}: ${inventoryCubit.inventory!.envelops![0].cash}')
//                         ],
//                       ),
//                       Divider(),
//                       Text(
//                         '${S.of(context).spExpenses}: ${inventoryCubit.inventory!.envelops![0].spExpenses}',
//                       ),
//                       Divider(),
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                               '${S.of(context).totalAmount}: ${inventoryCubit.inventory!.inventories![0].totalAmount}'),
//                           Text(
//                               '${S.of(context).totalPrice}: ${inventoryCubit.inventory!.inventories![0].totalPrice}'),
//                         ],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//         Expanded(
//           child: ListView.builder(
//             itemCount: inventoryCubit
//                 .inventory!.inventories![0].inventoryCategory!.length,
//             // itemCount: 1,
//             itemBuilder: (context, index) {
//               bool ch = (inventoryCubit.inventory!.inventories![0]
//                       .inventoryCategory![index].category !=
//                   null);
//               String nameAr = (ch)
//                   ? inventoryCubit.inventory!.inventories![0]
//                       .inventoryCategory![index].category!.nameAr!
//                   : 'null';
//               String amount = (ch)
//                   ? inventoryCubit.inventory!.inventories![0]
//                       .inventoryCategory![index].amount
//                       .toString()
//                   : 'null';

//               String price = (ch)
//                   ? inventoryCubit.inventory!.inventories![0]
//                       .inventoryCategory![index].category!.price
//                       .toString()
//                   : 'null';
//               return Card(
//                 child: ListTile(
//                   title: Text(nameAr),
//                   subtitle: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text('${S.of(context).amountAin}: $amount'),
//                       Text('${S.of(context).priceAin}: $price'),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
