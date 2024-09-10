import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/utils/widgets/custom_error_widget.dart';
import '../../../../../core/utils/widgets/custom_loading_indicator.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/bill_page_cubit.dart';
import 'conferm_dialog.dart';

class AddCategoryToBillDialog extends StatelessWidget {
  const AddCategoryToBillDialog({
    super.key,
    required this.billId,
  });
  final int billId;
  @override
  Widget build(BuildContext context) {
    List<TextEditingController> controllers = [];
    List<Map<String, int>> selectedCAt = [];
    BillPageCubit billCubit = BillPageCubit.get(context);

    return AlertDialog(
      actions: [
        BlocBuilder<BillPageCubit, BillPageState>(
          builder: (context, state) {
            if (state is LoadingFEtchAllActiveCategory ||
                state is FailureFEtchAllActiveCategory) {
              return const SizedBox();
            } else if (state is LoadingAddCAtegoryOfBIll ||
                state is LoadingFetchBillState) {
              return const CustomLoadingIndicator();
            } else {
              return ElevatedButton(
                onPressed: () {
                  if (controllers.length != 0) {
                    var data;
                    for (var i = 0; i < controllers.length; i++) {
                      if (controllers[i].text.isNotEmpty) {
                        int amount = int.parse(controllers[i].text);
                        selectedCAt.add({
                          "category_id": billCubit.activeCAt[i].id!,
                          "amount": amount,
                        });
                        data = {"bills": selectedCAt};
                        print(data);
                      }
                    }

                    if (selectedCAt.length != 0) {
                      billCubit.addCategoriesToBill(data, billId);
                    } else {
                      showDialog(
                        context: context,
                        builder: (context) => ConfermDialog(
                          // title: 'you don\'t choose any category',
                          title: S.of(context).youDontChooseAnyCategory,
                          isAlert: true,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                        ),
                      );
                    }
                  }
                },
                child: Text(
                  // 'add',
                  S.of(context).add,
                ),
              );
            }
          },
        ),
        BlocBuilder<BillPageCubit, BillPageState>(
          builder: (context, state) {
            if (state is LoadingFEtchAllActiveCategory) {
              return const SizedBox();
            } else {
              return ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
                child: Text(
                  // 'cancel',
                  S.of(context).cancel,
                  style: TextStyle(color: Colors.white),
                ),
              );
            }
          },
        ),
      ],
      content: BlocBuilder<BillPageCubit, BillPageState>(
        builder: (context, state) {
          if (state is LoadingFEtchAllActiveCategory) {
            return const CustomLoadingIndicator(
              color: Colors.black,
            );
          } else if (state is FailureFEtchAllActiveCategory) {
            return CustomErrorWidget(errMessage: state.errMessage);
          } else if (state is SuccessAddCAtegoryOfBIll) {
            Navigator.of(context).pop();
            return const SizedBox();
          } else {
            if (billCubit.activeCAt.length == 0) {
              return Center(
                child: Text(
                  S.of(context).noDatatoDisplay,
                ),
              );
            } else {
              return ListView.builder(
                itemCount: billCubit.activeCAt.length,
                itemBuilder: (context, index) {
                  controllers.add(TextEditingController());
                  return Card(
                    child: Column(
                      children: [
                        Text(billCubit.activeCAt[index].nameAr!),
                        TextFormField(
                          onTapOutside: (event) =>
                              FocusManager.instance.primaryFocus?.unfocus(),
                          keyboardType: TextInputType.number,
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly,
                          ],
                          controller: controllers[index],
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              );
            } // return SingleChildScrollView(
            // child: ,
            //  MultiSelectDialogField(

            //   backgroundColor: Colors.white,
            //   title: Text('choose items'),
            //   items: billCubit.activeCAt
            //       .map((e) => MultiSelectItem(e, e.nameAr!))
            //       .toList(),
            //   listType: MultiSelectListType.LIST,
            //   onConfirm: (values) {
            //     selectedCAt = values;
            //   },
            // ),

            // );
          }
        },
      ),
    );
  }
}
