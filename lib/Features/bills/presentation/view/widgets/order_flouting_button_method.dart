import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../../../core/utils/styles.dart';
import '../../../../../generated/l10n.dart';
import '../../manager/cubit/bill_page_cubit.dart';
import 'conferm_dialog.dart';

class OrderFloutingButtonMethod extends StatelessWidget {
  const OrderFloutingButtonMethod({
    super.key,
    required this.sellPointId,
    required this.isEdit,
    required this.isStore,
    required this.billId,
    required this.isToSp,
    // required this.isNew,
    // required this.isReturn,
    // required this.isExternal,
    required this.type,
  });
  final int sellPointId;
  final bool isEdit;
  final bool isStore;
  final int billId;
  final bool isToSp;
  // final bool isNew;
  // final bool isReturn;
  // final bool isExternal;
  final String type;

  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);

    return FloatingActionButton(
      child: Text(
        // ---- order -----
        S.of(context).order,
        // ----------------
        style: Styles.textStyle16,
      ),
      onPressed: () async {
        billCubit.selectedCAtAllCat.clear();
        // if (isStore) {
        //   for (var i = 0; i < billCubit.controllers.length; i++) {
        //     if (billCubit.controllers[i].text.isNotEmpty) {
        //       int amount = int.parse(billCubit.controllers[i].text);
        //       billCubit.selectedCAtAllCat.add(
        //         {
        //           "category_id": billCubit.activeCAt[i].id!,
        //           "amount": amount,
        //         },
        //       );
        //     }
        //   }
        //   for (var i = 0; i < billCubit.controllerskg.length; i++) {
        //     if (billCubit.controllerskg[i].text.isNotEmpty) {
        //       int amount = int.parse(billCubit.controllerskg[i].text);
        //       billCubit.selectedCAtAllCat.add(
        //         {
        //           "category_id": billCubit.activeCAtkg[i].id!,
        //           "amount": amount,
        //         },
        //       );
        //     }
        //   }
        // } else {
        //   for (var i = 0; i < billCubit.controllersDamage.length; i++) {
        //     if (billCubit.controllersDamage[i].text.isNotEmpty) {
        //       int amount = int.parse(billCubit.controllersDamage[i].text);
        //       billCubit.selectedCAtAllCat.add(
        //         {
        //           "category_id": billCubit.activeCatDamage[i].id!,
        //           "amount": amount,
        //         },
        //       );
        //     }
        //   }
        //   for (var i = 0; i < billCubit.controllersDamagekg.length; i++) {
        //     if (billCubit.controllersDamagekg[i].text.isNotEmpty) {
        //       int amount = int.parse(billCubit.controllersDamagekg[i].text);
        //       billCubit.selectedCAtAllCat.add(
        //         {
        //           "category_id": billCubit.activeCatDamagekg[i].id!,
        //           "amount": amount,
        //         },
        //       );
        //     }
        //   }
        // }

        if (isStore) {
          for (var i = 0; i < billCubit.currentActiveCAt.length; i++) {
            if (billCubit.currentActiveCAt[i].controller!.text.isNotEmpty) {
              int amount =
                  int.parse(billCubit.currentActiveCAt[i].controller!.text);
              billCubit.selectedCAtAllCat.add(
                {
                  "category_id": billCubit.currentActiveCAt[i].id!,
                  "amount": amount,
                },
              );
            }
          }
          for (var i = 0; i < billCubit.currentActiveCAtkg.length; i++) {
            if (billCubit.currentActiveCAtkg[i].controller!.text.isNotEmpty) {
              int amount =
                  int.parse(billCubit.currentActiveCAtkg[i].controller!.text);
              billCubit.selectedCAtAllCat.add(
                {
                  "category_id": billCubit.currentActiveCAtkg[i].id!,
                  "amount": amount,
                },
              );
            }
          }
        } else {
          for (var i = 0; i < billCubit.currentActiveCatDamage.length; i++) {
            if (billCubit
                .currentActiveCatDamage[i].controller!.text.isNotEmpty) {
              int amount = int.parse(
                  billCubit.currentActiveCatDamage[i].controller!.text);
              billCubit.selectedCAtAllCat.add(
                {
                  "category_id": billCubit.currentActiveCatDamage[i].id!,
                  "amount": amount,
                },
              );
            }
          }
          for (var i = 0; i < billCubit.currentActiveCatDamagekg.length; i++) {
            if (billCubit
                .currentActiveCatDamagekg[i].controller!.text.isNotEmpty) {
              int amount = int.parse(
                  billCubit.currentActiveCatDamagekg[i].controller!.text);
              billCubit.selectedCAtAllCat.add(
                {
                  "category_id": billCubit.currentActiveCatDamagekg[i].id!,
                  "amount": amount,
                },
              );
            }
          }
        }

        if (billCubit.selectedCAtAllCat.isEmpty) {
          // print('errrrooooooooooooooooooooooooooooooooooooooooooooooooor');
          showDialog(
            context: context,
            builder: (context) => ConfermDialog(
              isAlert: true,
              // title: 'you don\'t choose any category',
              title: S.of(context).youDontChooseAnyCategory,
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        } else if (billCubit.selectedDAteForAddBill == null &&
            !isEdit &&
            !isToSp) {
          showDialog(
            context: context,
            builder: (context) => ConfermDialog(
              isAlert: true,
              // ------ you didnt choose a date ----------
              title: S.of(context).dialogForUnselectedDate,
              // -----------------------------------------
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        } else if (billCubit.selectedSellPoint.id == null && isToSp) {
          showDialog(
            context: context,
            builder: (context) => ConfermDialog(
              isAlert: true,
              // ------ you didnt choose a sell point ----------
              title: S.of(context).errorSellPOint,
              // -----------------------------------------
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          );
        } else {
          // Navigator.of(context).pop();

          if (isEdit) {
            var data = {
              "bills": billCubit.selectedCAtAllCat,
            };
            print(data);
            billCubit.addCategoriesToBill(
              data,
              billId,
            );
            Navigator.of(context).pop();
            print(data);
          } else {
            String selectedDate = (isToSp)
                ? ''
                : DateFormat('yyyy-MM-dd', 'en')
                    .format(billCubit.selectedDAteForAddBill!);
            if (isStore) {
              // String type = '';
              // if (isNew) {
              //   if (isReturn) {
              //     type = "returns";
              //   } else if (isExternal) {
              //     type = "external";
              //   } else {
              //     type = "expenses";
              //   }
              // } else {
              //   type = "default";
              // }
              var data = {
                "type": type,
                "date": selectedDate,
                "bills": billCubit.selectedCAtAllCat,
              };
              var dataToSp = {
                "sell_point_id": billCubit.selectedSellPoint.id,
                "bills": billCubit.selectedCAtAllCat,
              };
              (isToSp)
                  ? billCubit.addBillToSellpointToSp(
                      sellPointId,
                      dataToSp,
                    )
                  : billCubit.addBillToSellpoint(
                      sellPointId,
                      data,
                    );
              Navigator.of(context).pop();
              print(data);
            } else {
              var data = {
                "type": "raw",
                "date": selectedDate,
                "bills": billCubit.selectedCAtAllCat,
              };
              var dataToSp = {
                "sell_point_id": billCubit.selectedSellPoint.id,
                "bills": billCubit.selectedCAtAllCat,
              };
              (isToSp)
                  ? billCubit.addBillToSellpointToSp(
                      sellPointId,
                      dataToSp,
                    )
                  : billCubit.addBillToSellpoint(
                      sellPointId,
                      data,
                    );
              Navigator.of(context).pop();
              print(data);
            }
          }

          // print(data);
        }
      },
    );
  }
}
