// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:promoter/Features/bills/presentation/view/widgets/conferm_dialog.dart';
// // import 'package:promoter/Features/bills/presentation/manager/cubit/bill_page_cubit.dart';
// import 'package:promoter/Features/inventory/presentation/manager/cubit/inventory_cubit.dart';
// import 'package:promoter/Features/inventory/presentation/view/widget/store_list_view.dart';
// import 'package:promoter/Features/inventory/presentation/view/widget/store_list_view_kg.dart';

// import '../../../../../core/utils/styles.dart';
// import '../../../../../core/utils/widgets/custom_error_widget.dart';
// import '../../../../../core/utils/widgets/custom_loading_indicator.dart';
// import '../../../../../generated/l10n.dart';

// class InventoryCategoryItems extends StatelessWidget {
//   const InventoryCategoryItems(
//       {super.key, required this.spNAme, required this.spId});
//   final String spNAme;
//   final int spId;
//   @override
//   Widget build(BuildContext context) {
//     InventoryCubit inventoryCubit = InventoryCubit.get(context);
//     return DefaultTabController(
//       length: 2,
//       child: Form(
//         key: inventoryCubit.keyForm,
//         child: Scaffold(
//           appBar: AppBar(
//             title: Text(
//               spNAme,
//               style: Styles.textStyle12.copyWith(
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             actions: [
//               ElevatedButton(
//                 onPressed: () {
//                   inventoryCubit.selectedCAtAllCat.clear();
//                   for (var i = 0; i < inventoryCubit.controllers.length; i++) {
//                     if (inventoryCubit.controllers[i].text.isNotEmpty) {
//                       int amount =
//                           int.parse(inventoryCubit.controllers[i].text);
//                       inventoryCubit.selectedCAtAllCat.add(
//                         {
//                           "category_id": inventoryCubit.activeCAt[i].id!,
//                           "amount": amount,
//                         },
//                       );
//                     }
//                   }
//                   for (var i = 0;
//                       i < inventoryCubit.controllerskg.length;
//                       i++) {
//                     if (inventoryCubit.controllerskg[i].text.isNotEmpty) {
//                       int amount =
//                           int.parse(inventoryCubit.controllerskg[i].text);
//                       inventoryCubit.selectedCAtAllCat.add(
//                         {
//                           "category_id": inventoryCubit.activeCAtkg[i].id!,
//                           "amount": amount,
//                         },
//                       );
//                     }
//                   }

//                   if (inventoryCubit.keyForm.currentState!.validate()) {
//                     var body = {'bills': inventoryCubit.selectedCAtAllCat};
//                     showDialog(
//                       context: context,
//                       builder: (context) => ConfermDialog(
//                         title: S.of(context).inventoryMessage,
//                         onPressed: () {
//                           inventoryCubit.postInventory(spID: spId, body: body);
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     );
//                   }
//                 },
//                 child: Text(
//                   S.of(context).inventory,
//                   style: Styles.textStyle14,
//                 ),
//               ),
//             ],
//           ),
//           body: Column(
//             children: [
//               TabBar(
//                 tabs: [
//                   Tab(
//                     // icon: const Icon(
//                     //   Icons.,
//                     // ),
//                     child: Text(
//                       // ---- school ----------
//                       S.of(context).school2,
//                       // ----------------------
//                       style: Styles.textStyle16,
//                     ),
//                   ),
//                   Tab(
//                     // icon: const Icon(
//                     //   Icons.school,
//                     // ),
//                     child: Text(
//                       // ----- kindergarten ----
//                       S.of(context).kindergarten,
//                       // ----------------
//                       style: Styles.textStyle16,
//                     ),
//                   ),
//                 ],
//               ),
//               BlocConsumer<InventoryCubit, InventoryState>(
//                 listener: (context, state) {
//                   if (state is FailuerPostInventory) {
//                     showDialog(
//                       context: context,
//                       builder: (context) => ConfermDialog(
//                         title: state.errMessage,
//                         isAlert: true,
//                       ),
//                     );
//                   } else if (state is SuccessPostInventory) {
//                     Navigator.of(context).pop();
//                     showDialog(
//                       context: context,
//                       builder: (context) => ConfermDialog(
//                         title: S.of(context).successInInventory,
//                         isAlert: true,
//                       ),
//                     );
//                   }
//                 },
//                 builder: (context, state) {
//                   if (state is LoadingFEtchAllActiveCategory ||
//                       state is LoadingPostInventory) {
//                     return const Expanded(
//                       child: CustomLoadingIndicator(
//                         color: Colors.white,
//                       ),
//                     );
//                   } else if (state is FailureFEtchAllActiveCategory) {
//                     return CustomErrorWidget(errMessage: state.errMessage);
//                   } else {
//                     return const Expanded(
//                       child: TabBarView(
//                         children: [
//                           StoreListView(),
//                           StoreListViewKg(),
//                         ],
//                       ),
//                     );
//                   }
//                 },
//               )
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
