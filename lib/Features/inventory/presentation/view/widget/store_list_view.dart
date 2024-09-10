// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:promoter/Features/inventory/presentation/manager/cubit/inventory_cubit.dart';
// import '../../../../../constant.dart';
// import '../../../../../core/utils/styles.dart';
// import '../../../../bills/presentation/manager/cubit/bill_page_cubit.dart';

// class StoreListView extends StatelessWidget {
//   const StoreListView({
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
//                     inventoryCubit.activeCAt[index].nameAr!,
//                     style: Styles.textStyle12,
//                     maxLines: 2,
//                   ),
//                 ),
//                 // Row(
//                 //   children: [
//                 //     IconButton(
//                 //       onPressed: () {
//                 //         // inventoryCubit.addOneMethod(
//                 //         //   index: index,
//                 //         //   isSchool: true,
//                 //         //   isStore: true,
//                 //         // );
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
//                 //         // inventoryCubit.minusOneMethod(
//                 //         //   index: index,
//                 //         //   isSchool: true,
//                 //         //   isStore: true,
//                 //         // );
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
//                       keyboardType: TextInputType.number,
//                       inputFormatters: [
//                         FilteringTextInputFormatter.digitsOnly,
//                       ],
//                       controller: inventoryCubit.controllers[index],
//                       textAlign: TextAlign.center,
//                       validator: (value) {
//                         if (value!.isEmpty) {
//                           return 'please enter amount';
//                         }
//                       },
//                     );
//                   },
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//       itemCount: inventoryCubit.activeCAt.length,
//     );
//   }
// }
