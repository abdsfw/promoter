// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:promoter/Features/inventory/presentation/manager/cubit/inventory_cubit.dart';

// import '../../../../../constant.dart';
// import '../../../../../core/utils/styles.dart';
// import '../../../../bills/presentation/manager/cubit/bill_page_cubit.dart';

// class StoreListViewKg extends StatelessWidget {
//   const StoreListViewKg({
//     super.key,
//   });

//   @override
//   Widget build(BuildContext context) {
//     InventoryCubit inventoryCubit = InventoryCubit.get(context);
//     // BillPageCubit billCubit = BillPageCubit.get(context);
//     // List<TextEditingController> controllers = [];
//     // List<Map<String, int>> selectedCAt = [];
//     return GridView.builder(
//       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 3,
//         // childAspectRatio: 2 / 3,
//       ),
//       itemBuilder: (context, index) {
//         // controllers.add(TextEditingController());
//         return Card(
//           child: Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Expanded(
//                   child: Text(
//                     inventoryCubit.activeCAtkg[index].nameAr!,
//                     style: Styles.textStyle12,
//                     maxLines: 2,
//                   ),
//                 ),
//                 // Row(
//                 //   children: [
//                 //     IconButton(
//                 //       onPressed: () {
//                 //         billCubit.addOneMethod(
//                 //           index: index,
//                 //           isSchool: false,
//                 //           isStore: true,
//                 //         );
//                 //       },
//                 //       icon: const Icon(
//                 //         Icons.add,
//                 //       ),
//                 //       color: Colors.white,
//                 //       style: IconButton.styleFrom(
//                 //         backgroundColor: AppColor.hBackgroundColor,
//                 //       ),
//                 //     ),
//                 //     IconButton(
//                 //       onPressed: () {
//                 //         billCubit.minusOneMethod(
//                 //           index: index,
//                 //           isSchool: false,
//                 //           isStore: true,
//                 //         );
//                 //       },
//                 //       icon: const Icon(
//                 //         Icons.remove,
//                 //       ),
//                 //       color: Colors.white,
//                 //       style: IconButton.styleFrom(
//                 //         backgroundColor: AppColor.kActiveIconColor,
//                 //       ),
//                 //     ),
//                 //   ],
//                 // ),

//                 BlocBuilder<BillPageCubit, BillPageState>(
//                   builder: (context, state) {
//                     return TextFormField(
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'please enter amount';
//                         }

//                         return null;
//                       },
//                       keyboardType: TextInputType.number,
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                       ],
//                       controller: inventoryCubit.controllerskg[index],
//                       textAlign: TextAlign.center,
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//       itemCount: inventoryCubit.activeCAtkg.length,
//     );
//   }
// }
