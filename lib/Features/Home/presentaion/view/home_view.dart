import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:promoter/Features/Home/manger/cubit/lan_cubit.dart';
import 'package:promoter/Features/Home/presentaion/view/widget/category_card.dart';
import 'package:promoter/Features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:promoter/Features/inventory/presentation/view/widget/inventory_page.dart';
import 'package:promoter/core/constant/constant.dart';
import 'package:promoter/core/utils/app_router.dart';
import 'package:promoter/core/utils/cash/cache_helper.dart';
import 'package:promoter/core/utils/pdf_create.dart';
import 'package:promoter/core/utils/styles.dart';
import 'package:promoter/generated/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../inventory/presentation/view/inventory_home_page.dart';
import '../../../inventoryUpdate/presentation/view/inventory_home_update.dart';

class HomeView extends StatelessWidget {
  String pName = CasheHelper.getData(key: 'pname');

  @override
  Widget build(BuildContext context) {
    BillPageCubit billCubit = BillPageCubit.get(context);
    var size = MediaQuery.of(context).size;

    return Scaffold(
      body: FadeInDown(
        delay: const Duration(milliseconds: 100),
        child: Stack(
          children: <Widget>[
            Container(
              height: size.height * 0.45,
              decoration: const BoxDecoration(
                color: AppColor.hBackgroundColor,
              ),
            ),
            SafeArea(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: deafultpadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    SizedBox(
                      height: deafultpadding * 0.5,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: Row(
                            children: [
                              Container(
                                height: 52,
                                width: 52,
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF2BEA1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.person,
                                  color: AppColor.hBackgroundColor,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                // "hello promoter",
                                S.of(context).helloPromoter,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w900),
                              ),
                              Text(
                                S.of(context).goodDay,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w900),
                              ),
                            ],
                          ),
                        ),
                        // Text(pName),
                        PopupMenuButton<String>(
                          shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10))),
                          onSelected: (selectedLanguageCode) {
                            final languageCubit = context
                                .read<LocaleCubit>()
                                .changeLanguage(selectedLanguageCode);
                          },
                          itemBuilder: (BuildContext context) => [
                            PopupMenuItem<String>(
                                value: 'en',
                                textStyle: Styles.textStyle12
                                    .copyWith(color: Colors.black),
                                child: const Text('English')),
                            PopupMenuItem<String>(
                                value: 'ar',
                                textStyle: Styles.textStyle12
                                    .copyWith(color: Colors.black),
                                child: const Text('العربية')),
                          ],
                          child: Container(
                            alignment: Alignment.center,
                            height: 52,
                            width: 52,
                            decoration: const BoxDecoration(
                              color: Color(0xFFF2BEA1),
                              shape: BoxShape.circle,
                            ),
                            child: Image.asset("assets/images/menu.png"),
                          ),
                        ),
                      ],
                    ),
                    Text(
                      "$pName",
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Styles.textStyle20.copyWith(color: Colors.white),
                    ),
                    SizedBox(
                      height: deafultpadding,
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 52,
                      width: 52,
                      decoration: const BoxDecoration(
                        color: Color(0xFFF2BEA1),
                        shape: BoxShape.circle,
                      ),
                      child: InkWell(
                          onTap: () {
                            _logout(context);
                          },
                          child: Image.asset(
                            "assets/images/logout.png",
                            height: 30,
                            width: 30,
                          )),
                    ),
                    SizedBox(
                      height: deafultpadding * 2,
                    ),
                    // const SizedBox(
                    //   height: 50,
                    // ),
                    Expanded(
                      child: Container(
                        // margin: EdgeInsets.all(50),
                        padding: EdgeInsets.symmetric(vertical: 5),
                        alignment: Alignment.center,

                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height * 0.9,
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: .56,
                          crossAxisSpacing: 20,
                          mainAxisSpacing: 20,
                          children: <Widget>[
                            CategoryCard(
                              title: S.of(context).envelope,
                              pic: "assets/images/e.png",
                              press: () {
                                // GoRouter.of(context)
                                //     .push(AppRouter.kDriverView);
                                GoRouter.of(context).push(AppRouter.kEnvelopes);
                              },
                            ),

                            CategoryCard(
                              title: S.of(context).bills,
                              pic: "assets/images/bill.png",
                              press: () async {
                                // await PdfCreate.generateCodeTAblePdf([]);

                                billCubit.fetchAllPromoterSp();
                                GoRouter.of(context).push(
                                  AppRouter.kbillHOmePAge,
                                );
                              },
                            ),

                            // ---- Inventory By date
                            // CategoryCard(
                            //   // title: S.of(context).bills,
                            //   title: S.of(context).inventoryByDate,
                            //   pic: "assets/images/inventory.png",
                            //   press: () {
                            //     billCubit.fetchAllPromoterSp();
                            //     Navigator.of(context).push(
                            //       MaterialPageRoute(
                            //         builder: (context) =>
                            //             const InventoryHOmePage(),
                            //       ),
                            //     );
                            //   },
                            // ),

                            CategoryCard(
                              // title: S.of(context).bills,
                              title: S.of(context).inventoryByDate,
                              pic: "assets/images/inventory.png",
                              press: () {
                                billCubit.fetchAllPromoterSp();
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const InventoryHomeUpdate(),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _logout(BuildContext context) async {
    // Clear the stored token or user data
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('token'); // Replace with the actual key you're using

    // Navigate to the login view
    GoRouter.of(context).pushReplacement(AppRouter.klogin);
  }
}
