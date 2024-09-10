import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:promoter/core/constant/constant.dart';
import 'package:promoter/core/utils/app_router.dart';
import 'package:promoter/core/utils/styles.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplachView extends StatefulWidget {
  const SplachView({super.key});

  @override
  State<SplachView> createState() => _SplachViewState();
}

class _SplachViewState extends State<SplachView> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    navigateToHome();
  }

  bool _checkedAuthentication = false;
  void _checkAuthentication() async {
    final hasToken = await _retrieveStoredToken();
    final router = GoRouter.of(context);

    if (!_checkedAuthentication) {
      _checkedAuthentication = true;

      if (hasToken) {
        router.pushReplacement(AppRouter.kHomeView);
      } else {
        router.pushReplacement(AppRouter.klogin);
      }
    }
  }

  Future<bool> _retrieveStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token');
    return token != null && token.isNotEmpty;
  }

  @override
  Widget build(BuildContext context) {
    var w = MediaQuery.of(context).size.width;
    var h = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
        body: SizedBox(
          width: w,
          height: h,
          child: Stack(
            children: [
              FadeInDown(
                delay: const Duration(milliseconds: 100),
                child: Container(
                  width: w,
                  height: h / 2,
                  decoration: BoxDecoration(
                      color: AppColor.kBackgroundColor,
                      borderRadius: const BorderRadius.only(
                          bottomRight: Radius.circular(1000),
                          bottomLeft: Radius.circular(1000))),
                ),
              ),
              Positioned(
                top: 90,
                left: 60,
                child: FadeInUp(
                  delay: const Duration(milliseconds: 500),
                  child: SizedBox(
                    width: w / 1.5,
                    height: h / 10,
                    child: Center(
                      child: Text(
                        "Hello Promoter",
                        style: Styles.textStyle20,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 130,
                left: 60,
                child: FadeInUp(
                  delay: const Duration(milliseconds: 700),
                  child: SizedBox(
                    width: w / 1.5,
                    height: h / 10,
                    child: Center(
                      child: Text(
                        "Welcome",
                        style: Styles.textStyle20,
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: 220,
                left: 75,
                child: FadeInUp(
                  delay: const Duration(milliseconds: 900),
                  child: Spin(
                    delay: const Duration(milliseconds: 1000),
                    child: SizedBox(
                      width: w / 1.6,
                      height: h / 3.3,
                      child: Center(
                          child: Image.asset("assets/images/shamssenP.png")),
                    ),
                  ),
                ),
              ),
              Positioned(
                bottom: 5,
                left: 155,
                child: FadeInUp(
                  delay: const Duration(milliseconds: 1500),
                  child: SizedBox(
                    width: w / 5,
                    height: h / 15,
                    child: Center(
                        child: SpinKitFoldingCube(
                      size: 35,
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: AppColor.kBackgroundColor,
                          ),
                        );
                      },
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void navigateToHome() {
    Future.delayed(const Duration(seconds: 5), () {
      // GoRouter.of(context).pushReplacement(AppRouter.klogin);
      _checkAuthentication();
    });
  }
}
