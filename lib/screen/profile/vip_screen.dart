import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_call/Adhelper/ad_config.dart';
import 'package:video_call/common/colors.dart';

import '../../Adhelper/ad_helper.dart';

class VIPScreen extends StatefulWidget {
  const VIPScreen({super.key});

  @override
  State<VIPScreen> createState() => _VIPScreenState();
}

class _VIPScreenState extends State<VIPScreen> with WidgetsBindingObserver {
  final _adController = NativeAdController();
  List member = [
    {
      "title": "Unlock chat restrictions",
      "value": "Unlimited chatting with anybody",
      "icon": Icons.message
    },
    {
      "title": "Access to calls",
      "value": "Purchase diamonds for calls",
      "icon": Icons.video_call
    },
    {
      "title": "Quality user recommendation",
      "value": "Recommanded you better and more enthusiastic girl",
      "icon": Icons.heart_broken
    },
    {
      "title": "VIP Exclusive Logo",
      "value": "Let more intersting people find you",
      "icon": Icons.window_rounded
    },
    {
      "title": "Unlock all personal information",
      "value": "can view secret albums and videos",
      "icon": Icons.person_3
    },
  ];

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
          backgroundColor: yellowOpacity,
          surfaceTintColor: Colors.transparent,
          toolbarHeight: 70,
          leading: GestureDetector(
              onTap: () {
                AdHelper.showInterstitialAd(onComplete: () {
                  Get.back();
                });
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: black,
              )),
          title: const CustomText(
            text: "VIP",
            color: black,
            weight: FontWeight.w700,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(!Config.hideAds)
                Container(
                  child:
                      _adController.ad != null && _adController.adLoaded.isTrue
                          ? SafeArea(
                              child: SizedBox(
                                  height: 150,
                                  child: AdWidget(ad: _adController.ad!)))
                          : null,
                ),
                GestureDetector(
                  onTap: () {
                    AdHelper.showInterstitialAd(onComplete: () {});
                  },
                  child: listTimeshow(
                      title: "VIP 1 month",
                      subtitle: "Rs. 149 one month",
                      trailing: "RS.99 Only"),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    AdHelper.showInterstitialAd(onComplete: () {});
                  },
                  child: listTimeshow(
                      title: "VIP 6 Month",
                      subtitle: "Rs. 799 six month",
                      trailing: "RS.499 Only"),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    AdHelper.showInterstitialAd(onComplete: () {});
                  },
                  child: listTimeshow(
                      title: "VIP 1 Year",
                      subtitle: "Rs. 1299 one year",
                      trailing: "RS.999 Only"),
                ),
                const SizedBox(height: 20),
                CustomText(
                  text: "Member Privieges",
                  weight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: List.generate(
                      member.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: greenColor,
                              child: Icon(
                                member[index]["icon"],
                                color: white,
                              ),
                            ),
                            title: CustomText(
                              text: "${member[index]["title"]}",
                              weight: FontWeight.w600,
                            ),
                            subtitle: CustomText(
                              text: "${member[index]["value"]}",
                              fontSize: 12.sp,
                              color: black.withOpacity(0.5),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  listTimeshow(
      {required String title,
      required String subtitle,
      required String trailing}) {
    return Card(
      color: white,
      child: Padding(
        padding: const EdgeInsets.all(15),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(
            radius: 25,
            backgroundColor: greenColor,
            child: Icon(
              Icons.price_change,
              color: white,
            ),
          ),
          title: CustomText(
            text: title,
            weight: FontWeight.w700,
            fontSize: 16.sp,
          ),
          subtitle: CustomText(
            text: subtitle,
            weight: FontWeight.w700,
            fontSize: 12.sp,
            color: greenColor,
            decoration: TextDecoration.lineThrough,
          ),
          trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  color: greenColor, borderRadius: BorderRadius.circular(16)),
              child: CustomText(
                text: trailing,
                color: white,
                weight: FontWeight.w700,
              )),
        ),
      ),
    );
  }
}
