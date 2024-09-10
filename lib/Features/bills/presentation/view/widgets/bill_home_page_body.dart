import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:promoter/Features/bills/presentation/manager/cubit/bill_page_cubit.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../core/utils/widgets/custom_error_widget.dart';
import '../../../../../core/utils/widgets/custom_loading_indicator.dart';
// import '../../../../../core/utils/widgets/custom_search_widget.dart';
import '../../../../../generated/l10n.dart';
import 'custom_card_promoter_sp.dart';

class BillHomePageBody extends StatelessWidget {
  const BillHomePageBody({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    return BlocBuilder<BillPageCubit, BillPageState>(
      builder: (context, state) {
        if (state is LoadingFetchSchoolState) {
          return const CustomLoadingIndicator(
            color: Colors.white,
          );
        } else if (state is FailureFetchSchoolState) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomErrorWidget(
                errMessage: state.errMessage,
              ),
              IconButton(
                onPressed: () {
                  billCubit.fetchAllPromoterSp();
                },
                icon: const Icon(
                  Icons.replay_outlined,
                  color: Colors.white,
                ),
              ),
            ],
          );
        } else {
          if (billCubit.currentPromoterSp.length == 0) {
            return Center(
              child: Text(
                S.of(context).noDatatoDisplay,
                style: Styles.textStyle18,
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
                      return CustomCardPromoterSp(indexCard: index);
                    },
                    itemCount: billCubit.currentPromoterSp.length,
                  ),
                ),
              ],
            );
          }
        }
      },
    );
  }
}
