import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_call/common/colors.dart';
import 'package:video_call/routes/app_pages.dart';
import 'package:video_call/screen/home_screen/home_con.dart';

import '../../Adhelper/ad_config.dart';
import '../../Adhelper/ad_helper.dart';

class VisitorScreem extends StatefulWidget {
  const VisitorScreem({super.key});

  @override
  State<VisitorScreem> createState() => _VisitorScreemState();
}

class _VisitorScreemState extends State<VisitorScreem>
    with WidgetsBindingObserver {
  HomeController homeController = Get.find();
  List visitor = [];
  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    visitor = getRandomItems(homeController.photos, 6);
    super.initState();
  }

  bool showAds = false;
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.hidden ||
        state == AppLifecycleState.paused) {
      setState(() {
        showAds = true;
      });
    } else if (state == AppLifecycleState.inactive && showAds) {
      if (!Config.hideAds) {
        AdHelper.loadAppOpenAd();
        setState(() {
          showAds = false;
        });
      }
    }
  }

  List getRandomItems(List list, int count) {
    Random random = Random();
    Set<int> selectedIndices = Set<int>();

    // Ensure unique indices
    while (selectedIndices.length < count) {
      selectedIndices.add(random.nextInt(list.length));
    }

    // Select items based on indices
    List randomItems = selectedIndices.map((index) => list[index]).toList();

    return randomItems;
  }

  final _adController = NativeAdController();

  @override
  Widget build(BuildContext context) {
    _adController.ad = AdHelper.loadNativeAd(adController: _adController);
    return WillPopScope(
      onWillPop: () async {
        AdHelper.showInterstitialAd(onComplete: () {
          Get.back();
        });
        return true;
      },
      child: Scaffold(
        backgroundColor: yellowOpacity,
        appBar: AppBar(
          toolbarHeight: 80,
          backgroundColor: yellowOpacity,
          surfaceTintColor: Colors.transparent,
          leading: GestureDetector(
              onTap: () {
                AdHelper.showInterstitialAd(onComplete: () {
                  Get.back();
                });
              },
              child: const Icon(Icons.arrow_back_ios_new)),
          title: CustomText(
            text: "Visitor".toUpperCase(),
            weight: FontWeight.w700,
          ),
        ),
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.symmetric(vertical: 15),
              child: _adController.ad != null && _adController.adLoaded.isTrue
                  ? SafeArea(
                      child: SizedBox(
                          height: 150, child: AdWidget(ad: _adController.ad!)))
                  : null,
            ),
            GridView(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                mainAxisSpacing: 0,
                crossAxisSpacing: 0,
                childAspectRatio: 0.85,
              ),
              children: List.generate(
                visitor.length,
                (index) {
                  var data = homeController.photos[index].data() as Map;
                  return GestureDetector(
                    onTap: () async {
                      AdHelper.showInterstitialAd(onComplete: () {
                        if (index < 3) {
                          Get.toNamed(AppPages.userScreen, arguments: data);
                        } else {
                          Get.toNamed(AppPages.vipScreen);
                        }
                      });
                    },
                    child: Column(
                      children: [
                        CircleAvatar(
                          radius: 55,
                          backgroundImage: Config.hideAds
                              ? const NetworkImage(
                                  "https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg")
                              : NetworkImage("${data["profile"]}"),
                          child: index < 3
                              ? null
                              : Center(
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(100),
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 10.0, sigmaY: 10.0),
                                      child: ClipRRect(
                                        child: Container(
                                          height: 110,
                                          width: 110,
                                          alignment: Alignment.center,
                                          child: CustomText(
                                            text: "VIP",
                                            color: white,
                                            weight: FontWeight.w700,
                                            fontSize: 18.sp,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                        const SizedBox(height: 10),
                        CustomText(
                          text: "${data["name"]}",
                          fontSize: 14.sp,
                          weight: FontWeight.w700,
                        )
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                AdHelper.showInterstitialAd(onComplete: () {
                  Get.toNamed(AppPages.vipScreen);
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                margin: const EdgeInsets.all(15),
                decoration: BoxDecoration(
                    color: greenColor, borderRadius: BorderRadius.circular(30)),
                child: const CustomText(
                  text: "Get VIP",
                  color: white,
                  weight: FontWeight.w700,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
