import 'package:flutter/material.dart';
// import 'package:promoter/Features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:promoter/Features/bills/presentation/view/widgets/bill_home_page_body.dart';

import '../../../../core/utils/styles.dart';
import '../../../../generated/l10n.dart';

class BIllHomePage extends StatelessWidget {
  const BIllHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // BillPageCubit billCubit = BillPageCubit.get(context);
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.chevron_left_outlined),
            onPressed: () {
              // billCubit.activeCAt = [];

              Navigator.of(context).pop();
            },
          ),
          title: Text(
            // --- schools -----
            S.of(context).school,
            // -----------------
            style: Styles.textStyle18,
          ),
        ),
        body: const BillHomePageBody(),
      ),
    );
  }
}
