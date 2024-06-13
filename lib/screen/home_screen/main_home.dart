import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_call/Adhelper/ad_helper.dart';
import 'package:video_call/common/colors.dart';
import 'package:video_call/routes/app_pages.dart';
import 'package:video_call/screen/home_screen/home_con.dart';

import '../../Adhelper/ad_config.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with WidgetsBindingObserver  {
  HomeController homeController = Get.put(HomeController());

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
    return Scaffold(
      backgroundColor: yellowOpacity,
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      AdHelper.showInterstitialAd(onComplete: () {
                        Get.toNamed(AppPages.homeScreen);
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomText(
                        text: "Photos",
                        fontSize: 30.sp,
                        color: white,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 15),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      AdHelper.showInterstitialAd(onComplete: () {
                        Get.toNamed(AppPages.videoReels);
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 40),
                      decoration: BoxDecoration(
                          color: greenColor,
                          borderRadius: BorderRadius.circular(10)),
                      child: CustomText(
                        text: "Reels",
                        fontSize: 30.sp,
                        color: white,
                        weight: FontWeight.w700,
                      ),
                    ),
                  ),
                )
              ],
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                AdHelper.showInterstitialAd(onComplete: () {
                  Get.toNamed(AppPages.userChat);
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: greenColor, borderRadius: BorderRadius.circular(10)),
                child: CustomText(
                  text: "Chat",
                  fontSize: 20.sp,
                  color: white,
                  weight: FontWeight.w700,
                ),
              ),
            ),
            const SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                AdHelper.showInterstitialAd(onComplete: () {
                  Get.toNamed(AppPages.profile);
                });
              },
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                    color: greenColor, borderRadius: BorderRadius.circular(10)),
                child: CustomText(
                  text: "Profile",
                  fontSize: 20.sp,
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
