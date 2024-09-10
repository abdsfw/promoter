import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promoter/Features/inventoryUpdate/presentation/view/widget/custom_school_card_update.dart';
import 'package:promoter/core/utils/styles.dart';

import '../../../../core/utils/widgets/custom_error_widget.dart';
import '../../../../core/utils/widgets/custom_loading_indicator.dart';
import '../../../../generated/l10n.dart';
import '../../../bills/presentation/manager/cubit/bill_page_cubit.dart';
import '../../../inventory/presentation/view/widget/custom_school_card.dart';

class InventoryHomeUpdate extends StatelessWidget {
  const InventoryHomeUpdate({super.key});

  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          // --- school ------
          S.of(context).school,
          // -----------------
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
            // billCubit.selectedCAtAllCat.clear();
            // billCubit.activeCAt.clear();
            // billCubit.activeCAtkg.clear();
            // billCubit.controllerskg.clear();
          },
          icon: const Icon(
            Icons.chevron_left,
          ),
        ),
      ),
      body: BlocBuilder<BillPageCubit, BillPageState>(
        builder: (context, state) {
          if (state is LoadingFetchSchoolState) {
            return const CustomLoadingIndicator(
              color: Colors.white,
            );
          } else if (state is FailureFetchSchoolState) {
            return CustomErrorWidget(
              errMessage: state.errMessage,
            );
          } else if (billCubit.currentPromoterSp.length == 0) {
            return Center(
              child: Text(
                S.of(context).noDatatoDisplay,
                style: Styles.textStyle20,
              ),
            );
          } else {
            return Column(
              children: [
                // Padding(
                //   padding: const EdgeInsets.all(8.0),
                //   child: CustomSearchWidget(
                //     onchange: billCubit.filterDrivers,
                //     searchController: billCubit.searchController,
                //   ),
                // ),
                // const Divider(
                //   color: Colors.white,
                // ),
                Expanded(
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return CustomSchoolCardUpdate(schoolIndex: index);
                    },
                    itemCount: billCubit.currentPromoterSp.length,
                  ),
                ),
              ],
            );
          }
        },
      ),
      
    );
  }
}
