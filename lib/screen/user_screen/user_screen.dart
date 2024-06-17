import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_call/common/colors.dart';
import 'package:video_call/routes/app_pages.dart';

import '../../Adhelper/ad_config.dart';
import '../../Adhelper/ad_helper.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> with WidgetsBindingObserver {
  Map userData = {};

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    userData = Get.arguments;
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
        extendBodyBehindAppBar: true,
        backgroundColor: yellowOpacity,
        appBar: AppBar(
          toolbarHeight: 80,
          leading: GestureDetector(
              onTap: () {
                AdHelper.showInterstitialAd(onComplete: () {
                  Get.back();
                });
              },
              child: const Icon(Icons.arrow_back_ios_new)),
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: Padding(
          padding: const EdgeInsets.all(15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              FloatingActionButton(
                heroTag: "1",
                onPressed: () {
                  AdHelper.showInterstitialAd(onComplete: () {
                    Get.toNamed(AppPages.vipScreen);
                  });
                },
                backgroundColor: greenColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: const Icon(Icons.video_call, color: white),
              ),
              const SizedBox(width: 15),
              FloatingActionButton(
                heroTag: "2",
                onPressed: () {
                  AdHelper.showInterstitialAd(onComplete: () {
                    Get.toNamed(AppPages.showchat, arguments: userData);
                  });
                },
                backgroundColor: greenColor,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30)),
                child: const Icon(Icons.chat, color: white),
              ),
            ],
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: const EdgeInsets.only(bottom: 30),
              height: MediaQuery.of(context).size.height * 0.55,
              decoration: BoxDecoration(
                color: white,
                borderRadius:
                    const BorderRadius.vertical(bottom: Radius.circular(20)),
                image: DecorationImage(
                    image: NetworkImage("${userData["photo"]}"),
                    fit: BoxFit.cover),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      text: "${userData["name"]}",
                      color: black,
                      weight: FontWeight.w800,
                      fontSize: 20.sp,
                    ),
                    const SizedBox(height: 10),
                    CustomText(
                      text: "${userData["description"]}",
                      color: black.withOpacity(0.5),
                      weight: FontWeight.w400,
                      fontSize: 14.sp,
                    ),
                    if (Config.hideAds)
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        child: NativeAdWidget(),
                      ),
                    ListTile(
                      leading: const Icon(Icons.work, color: greenColor),
                      contentPadding: EdgeInsets.zero,
                      title: CustomText(
                        text: "Profesion",
                        color: black.withOpacity(0.5),
                        weight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                      subtitle: CustomText(
                        text: "${userData["profesion"]}",
                        color: black,
                        weight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.date_range, color: greenColor),
                      contentPadding: EdgeInsets.zero,
                      title: CustomText(
                        text: "DOB",
                        color: black.withOpacity(0.5),
                        weight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                      subtitle: CustomText(
                        text: "${userData["dob"]}",
                        color: black,
                        weight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    ListTile(
                      leading: const Icon(Icons.height, color: greenColor),
                      contentPadding: EdgeInsets.zero,
                      title: CustomText(
                        text: "Height",
                        color: black.withOpacity(0.5),
                        weight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                      subtitle: CustomText(
                        text: "${userData["height"]}",
                        color: black,
                        weight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                    ListTile(
                      leading:
                          const Icon(Icons.line_weight_sharp, color: greenColor),
                      contentPadding: EdgeInsets.zero,
                      title: CustomText(
                        text: "Weight",
                        color: black.withOpacity(0.5),
                        weight: FontWeight.w400,
                        fontSize: 14.sp,
                      ),
                      subtitle: CustomText(
                        text: "${userData["weight"]}",
                        color: black,
                        weight: FontWeight.w600,
                        fontSize: 14.sp,
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
