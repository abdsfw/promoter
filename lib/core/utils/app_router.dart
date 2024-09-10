import 'package:go_router/go_router.dart';
import 'package:promoter/Features/Home/presentaion/view/home_view.dart';
import 'package:promoter/Features/bills/presentation/view/bill_home_page.dart';
import 'package:promoter/Features/login/login_view.dart';
import 'package:promoter/Features/splach/spach_view.dart';

import '../../Features/envelop/view/sellpoint_view.dart';

abstract class AppRouter {
  static const kHomeView = '/lib/Features/Home/presentaion/view/home_view.dart';
  static const klogin = '/lib/Features/login/login_view.dart';
  static const kbillHOmePAge =
      '/lib/Features/bills/presentation/view/bill_home_page.dart';
  static const kSchoolDEtails =
      '/lib/Features/bills/presentation/view/widgets/school_details.dart';
  static const kEnvelopes = '/lib/Features/envelop/view/sellpoint_view.dart';

  static final routre = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplachView(),
      ),
      GoRoute(
        path: kHomeView,
        builder: (context, state) => HomeView(),
      ),
      GoRoute(
        path: klogin,
        builder: (context, state) => LoginHomePage(),
      ),
      GoRoute(
        path: kbillHOmePAge,
        builder: (context, state) => const BIllHomePage(),
      ),
      GoRoute(
        path: kEnvelopes,
        builder: (context, state) => const SellPointView(),
      ),
      // GoRoute(
      //   path: kSchoolDEtails,
      //   builder: (context, state) => SchoolDetails(index: index),
      // ),
    ],
  );
}
