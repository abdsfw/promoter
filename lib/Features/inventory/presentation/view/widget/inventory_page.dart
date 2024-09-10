// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:promoter/Features/inventory/data/models/inventory_model/driver.dart';
// import 'package:promoter/Features/inventory/presentation/manager/cubit/inventory_cubit.dart';
// import 'package:promoter/core/utils/widgets/custom_error_widget.dart';
// import 'package:promoter/core/utils/widgets/custom_loading_indicator.dart';

// import '../../../../../generated/l10n.dart';
// import 'inventory_list_view.dart';

// class InventoryPage extends StatelessWidget {
//   const InventoryPage({super.key, required this.spID});
//   final int spID;
//   @override
//   Widget build(BuildContext context) {
//     InventoryCubit inventoryCubit = InventoryCubit.get(context);
//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: BlocBuilder<InventoryCubit, InventoryState>(
//             builder: (context, state) {
//               return Text(
//                 DateFormat('yyyy-MM-dd', 'en').format(
//                   inventoryCubit.pickerDate,
//                 ),
//               );
//             },
//           ),
//           actions: [
//             ElevatedButton(
//               onPressed: () async {
//                 await showDatePicker(
//                   context: context,
//                   initialDate: DateTime.now(),
//                   firstDate: DateTime(2023),
//                   lastDate: DateTime.now(),
//                 ).then(
//                   (value) {
//                     if (value != null) {
//                       inventoryCubit.pickerDate = value;
//                       print(value.toIso8601String());
//                       var date = DateFormat('yyyy-MM-dd', 'en').format(value);
//                       print(date.toString());
//                       inventoryCubit.fetchInventory(
//                         schoolID: spID,
//                         body: {
//                           "date": date,
//                         },
//                       );
//                     } else {
//                       print('nulll');
//                     }
//                   },
//                 );
//               },
//               child: const Text('pick date'),
//             )
//           ],
//         ),
//         body: BlocBuilder<InventoryCubit, InventoryState>(
//           builder: (context, state) {
//             if (state is LoadingFetchInventory) {
//               return const CustomLoadingIndicator(
//                 color: Colors.white,
//               );
//             } else if (state is FailuerFetchInventory) {
//               return CustomErrorWidget(errMessage: state.errMessage);
//             } else {
//               return const InventoryListView();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
