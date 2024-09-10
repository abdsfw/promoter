// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:promoter/Features/inventory/presentation/view/widget/custom_school_card.dart';
// import '../../../../core/utils/widgets/custom_error_widget.dart';
// import '../../../../core/utils/widgets/custom_loading_indicator.dart';
// import '../../../../generated/l10n.dart';
// import '../../../bills/presentation/manager/cubit/bill_page_cubit.dart';
// import '../../../bills/presentation/view/widgets/custom_card_promoter_sp.dart';

// class InventoryHOmePage extends StatelessWidget {
//   const InventoryHOmePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     BillPageCubit billCubit = BillPageCubit.get(context);

//     return SafeArea(
//       child: Scaffold(
//         appBar: AppBar(
//           title: Text(
//             // --- school ------
//             S.of(context).school,
//             // -----------------
//           ),
//           leading: IconButton(
//             onPressed: () {
//               Navigator.of(context).pop();
//               // billCubit.selectedCAtAllCat.clear();
//               // billCubit.activeCAt.clear();
//               // billCubit.activeCAtkg.clear();
//               // billCubit.controllerskg.clear();
//             },
//             icon: const Icon(
//               Icons.chevron_left,
//             ),
//           ),
//         ),
//         body: BlocBuilder<BillPageCubit, BillPageState>(
//           builder: (context, state) {
//             if (state is LoadingFetchSchoolState) {
//               return const CustomLoadingIndicator(
//                 color: Colors.white,
//               );
//             } else if (state is FailureFetchSchoolState) {
//               return CustomErrorWidget(
//                 errMessage: state.errMessage,
//               );
//             } else {
//               return Column(
//                 children: [
//                   // Padding(
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   child: CustomSearchWidget(
//                   //     onchange: billCubit.filterDrivers,
//                   //     searchController: billCubit.searchController,
//                   //   ),
//                   // ),
//                   // const Divider(
//                   //   color: Colors.white,
//                   // ),
//                   Expanded(
//                     child: ListView.builder(
//                       itemBuilder: (context, index) {
//                         return CustomSchoolCard(index: index);
//                       },
//                       itemCount: billCubit.currentPromoterSp.length,
//                     ),
//                   ),
//                 ],
//               );
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
