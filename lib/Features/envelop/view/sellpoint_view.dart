import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:promoter/Features/envelop/data/api_server.dart';
import 'package:promoter/Features/envelop/data/sp_model.dart';
import 'package:promoter/Features/envelop/view/sellpoint_card.dart';
import 'package:promoter/core/utils/cash/cache_helper.dart';
import 'package:promoter/core/utils/styles.dart';
import 'package:promoter/generated/l10n.dart';
import '../../../core/constant/constant.dart';

class SellPointView extends StatefulWidget {
  const SellPointView({super.key});

  @override
  State<SellPointView> createState() => _SellPointViewState();
}

class _SellPointViewState extends State<SellPointView> {
  List<SellPoint> sellPoints = [];
  final api = Apienvelop();
  String t = CasheHelper.getData(key: 'token');
  TextEditingController searchController = TextEditingController();
  bool isLoading = true; // Track loading state
  @override
  void initState() {
    super.initState();
    fetchSellPoints().then((value) => print(sellPoints.length));
  }

  Future<void> fetchSellPoints() async {
    try {
      final data = await api.fetchSellPoints(t);
      if (mounted) {
        setState(() {
          sellPoints = data;
          isLoading = false; // Data is available, set loading to false
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          isLoading = false; // Error occurred, set loading to false
        });
        print('Error: $e');
      }
    }
  }

  List<SellPoint> filteredSellPoints() {
    final query = searchController.text.toLowerCase();
    return sellPoints.where((sellPoint) {
      return sellPoint.name!.toLowerCase().contains(query);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final api = Apienvelop(); // Create an instance of your API class
    String t = CasheHelper.getData(key: 'token');
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              AppColor.kBlueLightColor,
              AppColor.kBlueColor,
            ], begin: FractionalOffset(0.0, 0.4), end: Alignment.topRight),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: EdgeInsets.only(
                  top: deafultpadding * 2,
                  left: deafultpadding,
                  right: deafultpadding,
                ),
                height: 200,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        GoRouter.of(context).pop();
                      },
                      child: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      children: [
                        Text(
                          S.of(context).allSellPointsForYou,
                          style:
                              Styles.textStyle20.copyWith(color: Colors.white),
                        ),
                        const Spacer(),
                      ],
                    ),
                    SizedBox(
                      height: deafultpadding,
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(deafultpadding),
                child: TextField(
                  controller: searchController,
                  onChanged: (_) => setState(() {}),
                  decoration: InputDecoration(
                    labelText: S.of(context).searchBySellPointName,
                    prefixIcon: const Icon(Icons.search),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                      borderSide: BorderSide(color: AppColor.kShadowColor),
                    ),
                  ),
                ),
              ),
              isLoading
                  ? const Center(
                      child: SpinKitFoldingCube(
                      color: Colors.white,
                      size: 35,
                    ))
                  : filteredSellPoints().isEmpty
                      ? Center(
                          child: Text(
                            'No sell points found.',
                            // S.of(context).noSellPointsFound,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      // Show loading indicator
                      : Expanded(
                          child: FadeInDown(
                            delay: const Duration(milliseconds: 100),
                            child: Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(70)),
                              ),
                              child: ListView.builder(
                                itemCount: filteredSellPoints().length,
                                itemBuilder: (context, index) {
                                  final sellPoint = filteredSellPoints()[index];
                                  return SpCard(
                                    namesp: sellPoint.name!,
                                    schoolName:
                                        sellPoint.school?.nameAr ?? 'No School',
                                    id: sellPoint.id,
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
            ],
          ),
        ),
      ),
    );
  }
}
