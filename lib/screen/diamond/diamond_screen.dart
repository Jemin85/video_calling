import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_call/Adhelper/ad_config.dart';
import 'package:video_call/common/colors.dart';

import '../../Adhelper/ad_helper.dart';

class DiamondScreen extends StatefulWidget {
  const DiamondScreen({super.key});

  @override
  State<DiamondScreen> createState() => _DiamondScreenState();
}

class _DiamondScreenState extends State<DiamondScreen>
    with WidgetsBindingObserver {
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

  List diamond = [
    {"diamond": 25, "amount": 49},
    {"diamond": 50, "amount": 99},
    {"diamond": 100, "amount": 199},
    {"diamond": 250, "amount": 299},
    {"diamond": 500, "amount": 499}
  ];

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
          surfaceTintColor: yellowOpacity,
          leading: GestureDetector(
            onTap: () {
              AdHelper.showInterstitialAd(onComplete: () {
                Get.back();
              });
            },
            child: const Icon(Icons.arrow_back_ios_new),
          ),
          title: CustomText(
            text: "Diamond".toUpperCase(),
            weight: FontWeight.w600,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              if (!Config.hideAds)
                Container(
                  child:
                      _adController.ad != null && _adController.adLoaded.isTrue
                          ? SafeArea(
                              child: SizedBox(
                                  height: 150,
                                  child: AdWidget(ad: _adController.ad!)))
                          : null,
                ),
              SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    diamond.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {},
                        child: listTimeshow(
                            title: "Get ${diamond[index]["diamond"]} Diamond",
                            trailing: "Rs.${diamond[index]["amount"]}",
                            subtitle: ""),
                      );
                    },
                  ),
                ),
              )
            ],
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
              Icons.diamond_sharp,
              color: white,
            ),
          ),
          title: CustomText(
            text: title,
            weight: FontWeight.w700,
            fontSize: 16.sp,
          ),
          // subtitle: CustomText(
          //   text: subtitle,
          //   weight: FontWeight.w700,
          //   fontSize: 12.sp,
          //   color: greenColor,
          //   decoration: TextDecoration.lineThrough,
          // ),
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
