import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_call/Adhelper/ad_helper.dart';
import 'package:video_call/common/colors.dart';
import 'package:video_call/routes/app_pages.dart';
import 'package:video_call/screen/chat_screen/chat_con.dart';
import 'package:video_call/screen/home_screen/home_con.dart';
import 'package:video_call/screen/video_reel/video_con.dart';

import '../../Adhelper/ad_config.dart';

class MainHomeScreen extends StatefulWidget {
  const MainHomeScreen({super.key});

  @override
  State<MainHomeScreen> createState() => _MainHomeScreenState();
}

class _MainHomeScreenState extends State<MainHomeScreen>
    with WidgetsBindingObserver {
  HomeController homeController = Get.put(HomeController());
  ChatController chatController = Get.put(ChatController());
  VideoController videoController = Get.put(VideoController());

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

  final _adController = NativeAdController();

  @override
  Widget build(BuildContext context) {
    _adController.ad = AdHelper.loadNativeAd(adController: _adController);
    return Scaffold(
      backgroundColor: yellowOpacity,
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/back.jpg"), fit: BoxFit.cover)),
        child: Container(
          padding: const EdgeInsets.all(20),
          color: black.withOpacity(0.5),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                  child: Padding(
                      padding: const EdgeInsets.only(top: 70),
                      child: CustomText(
                        text: "Tingle".toUpperCase(),
                        color: white,
                        fontSize: 50.sp,
                        weight: FontWeight.w700,
                        align: TextAlign.center,
                      ))),
              if(!Config.hideAds)
              Container(
                child: _adController.ad != null && _adController.adLoaded.isTrue
                    ? SafeArea(
                        child: SizedBox(
                            height: 150,
                            child: AdWidget(ad: _adController.ad!)))
                    : null,
              ),
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
                      color: greenColor,
                      borderRadius: BorderRadius.circular(10)),
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
                      color: greenColor,
                      borderRadius: BorderRadius.circular(10)),
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
      ),
    );
  }
}
