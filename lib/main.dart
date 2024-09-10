import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:promoter/Features/Home/manger/cubit/lan_cubit.dart';
import 'package:promoter/Features/Home/manger/cubit/state_lan.dart';
import 'package:promoter/Features/bills/data/repos/bill_repo_impl.dart';
import 'package:promoter/Features/bills/presentation/manager/cubit/bill_page_cubit.dart';
import 'package:promoter/Features/inventory/data/repo/inventory_repo_impl.dart';
import 'package:promoter/Features/inventory/presentation/manager/cubit/inventory_cubit.dart';
import 'package:promoter/core/constant/constant.dart';
import 'package:promoter/core/utils/api_service.dart';
import 'package:promoter/core/utils/app_router.dart';
import 'package:promoter/core/utils/cash/cache_helper.dart';

import 'Features/inventoryUpdate/data/repo/inventoryCat_repo_Impl.dart';
import 'Features/inventoryUpdate/presentation/manager/cubit/inventory_cat_cubit.dart';
import 'core/utils/bloc_observer.dart';
import 'generated/l10n.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();

  await CasheHelper.casheInit();
  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LocaleCubit()..getSavedLanguage(),
        ),
        BlocProvider(
          create: (context) => BillPageCubit(BillRepoImpl(ApiService(Dio()))),
        ),
        BlocProvider(
          create: (context) =>
              InventoryCubit(InventoryRepoImpl(ApiService(Dio()))),
        ),
        BlocProvider(
          create: (context) =>
              InventoryCatCubit(InventoryCatRepoImpl(ApiService(Dio()))),
        ),

// Provide DriversCubit
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LocaleCubit, ChangeLocaleState>(
      builder: (context, state) {
        return MaterialApp.router(
          locale: BlocProvider.of<LocaleCubit>(context).locale,
          localizationsDelegates: const [
            S.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: S.delegate.supportedLocales,
          routerConfig: AppRouter.routre,
          theme: ThemeData(
            fontFamily: "Cairo",
            scaffoldBackgroundColor: AppColor.hBackgroundColor,
            textTheme: Theme.of(context)
                .textTheme
                .apply(displayColor: AppColor.kTextColor),
            useMaterial3: true,
          ),
          debugShowCheckedModeBanner: false,
          localeResolutionCallback: (deviceLocale, supportedLocales) {
            for (var locale in supportedLocales) {
              if (deviceLocale != null &&
                  deviceLocale.languageCode == locale.languageCode) {
                return deviceLocale;
              }
            }
          },
        );
      },
    );
  }
}
