import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_call/Adhelper/ad_config.dart';
import 'package:video_call/routes/app_pages.dart';
import 'package:video_call/screen/chat_screen/chat_con.dart';

import '../../Adhelper/ad_helper.dart';
import '../../common/colors.dart';

class UserShowScreen extends StatefulWidget {
  const UserShowScreen({super.key});

  @override
  State<UserShowScreen> createState() => _UserShowScreenState();
}

class _UserShowScreenState extends State<UserShowScreen>
    with WidgetsBindingObserver {
  ChatController chatController = Get.put(ChatController());

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    chatController.findUserData();
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
          toolbarHeight: 80,
          title: CustomText(
            text: "Chat".toUpperCase(),
            color: black,
          ),
          leading: GestureDetector(
              onTap: () {
                AdHelper.showInterstitialAd(onComplete: () {
                  Get.back();
                });
              },
              child: const Icon(Icons.arrow_back_ios_new)),
        ),
        body: Column(
          children: [
            Container(
              child: _adController.ad != null && _adController.adLoaded.isTrue
                  ? SafeArea(
                      child: SizedBox(
                          height: 150, child: AdWidget(ad: _adController.ad!)))
                  : null,
            ),
            Expanded(child: Obx(
              () {
                return SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      chatController.getChatData.length,
                      (index) {
                        var object =
                            chatController.getChatData[index].data() as Map;
                        return ListTile(
                          onTap: () {
                            AdHelper.showInterstitialAd(onComplete: () {
                              Get.toNamed(AppPages.showchat, arguments: object);
                            });
                          },
                          contentPadding: const EdgeInsets.all(15),
                          leading: CircleAvatar(
                            radius: 30,
                            backgroundImage: Config.hideAds
                                ? const NetworkImage(
                                    "https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg")
                                : NetworkImage("${object["profile"]}"),
                            //     NetworkImage("${object["profile"]}"),
                            backgroundColor: greenColor,
                          ),
                          shape: RoundedRectangleBorder(
                            side: BorderSide(
                                color: black.withOpacity(0.2), width: 0.2),
                          ),
                          title: CustomText(
                            text: "${object["name"]}",
                            weight: FontWeight.w700,
                            fontSize: 15.sp,
                          ),
                          subtitle: CustomText(
                            text: "${object["massage"].last["msg"]}",
                            weight: FontWeight.w700,
                            color: black.withOpacity(0.3),
                            fontSize: 12.sp,
                          ),
                          trailing: GestureDetector(
                              onTap: () {
                                chatController.deleteUserChat(
                                    chatController.getChatData[index].id);
                              },
                              child: const Icon(
                                Icons.delete,
                                color: greenColor,
                              )),
                        );
                      },
                    ),
                  ),
                );
              },
            ))
          ],
        ),
      ),
    );
  }
}
