import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_call/common/colors.dart';
import 'package:video_call/routes/app_pages.dart';

import '../../Adhelper/ad_config.dart';
import '../../Adhelper/ad_helper.dart';

class VisitorScreem extends StatefulWidget {
  const VisitorScreem({super.key});

  @override
  State<VisitorScreem> createState() => _VisitorScreemState();
}

class _VisitorScreemState extends State<VisitorScreem> with WidgetsBindingObserver {

    @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
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
  @override
  Widget build(BuildContext context) {
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
        body: GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 0.85,
          ),
          children: List.generate(
            6,
            (index) {
              return GestureDetector(
                onTap: () async {
                  AdHelper.showInterstitialAd(onComplete: () {
                    if (index < 3) {
                      Get.toNamed(AppPages.userScreen);
                    } else {
                      Get.toNamed(AppPages.vipScreen);
                    }
                  });
                },
                child: Column(
                  children: [
                    CircleAvatar(
                      radius: 55,
                      backgroundImage: const NetworkImage(
                          "https://cdn-icons-png.flaticon.com/512/219/219983.png"),
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
                      text: "fdf",
                      fontSize: 14.sp,
                      weight: FontWeight.w700,
                    )
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
