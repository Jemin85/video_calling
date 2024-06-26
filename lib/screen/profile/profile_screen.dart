import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_call/Adhelper/ad_helper.dart';
import 'package:video_call/routes/app_pages.dart';
import 'package:video_call/screen/home_screen/home_con.dart';
import '../../Adhelper/ad_config.dart';
import '../../common/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with WidgetsBindingObserver {
  HomeController homeController = Get.find();

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
    return WillPopScope(
      onWillPop: () async {
        AdHelper.showInterstitialAd(onComplete: () {
          Get.back();
        });
        return true;
      },
      child: Scaffold(
        backgroundColor: yellowOpacity,
        extendBodyBehindAppBar: true,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
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
        ),
        body: Column(
          children: [
            SizedBox(
              height: 170,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Positioned.fill(
                    child: Container(
                      decoration: const BoxDecoration(
                          gradient: LinearGradient(
                        colors: [greenColor, Color.fromARGB(255, 29, 221, 163)],
                      )),
                    ),
                  ),
                  Positioned(
                    bottom: -45,
                    child: GestureDetector(
                      onTap: () {
                        AdHelper.showInterstitialAd(onComplete: () {
                          if (!homeController.userLogin()) {
                            Get.offAllNamed(AppPages.login);
                          }
                        });
                      },
                      child: Container(
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          width: MediaQuery.of(context).size.width / 1.1,
                          alignment: Alignment.center,
                          margin: const EdgeInsets.symmetric(horizontal: 15),
                          decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.5),
                                spreadRadius: 5,
                                blurRadius: 7,
                                offset: const Offset(0, 3),
                              ),
                            ],
                          ),
                          child: ListTile(
                            leading: const CircleAvatar(
                              radius: 30,
                              backgroundImage: NetworkImage(
                                  "https://cdn-icons-png.flaticon.com/512/219/219983.png"),
                            ),
                            title: CustomText(
                              text: homeController.userLogin()
                                  ? "-"
                                  : "Login with Google",
                              weight: FontWeight.w600,
                            ),
                            subtitle: CustomText(
                                text: homeController.userLogin()
                                    ? "${FirebaseAuth.instance.currentUser!.email}"
                                    : "-",
                                weight: FontWeight.w400,
                                fontSize: 14.sp),
                          )),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 50),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        AdHelper.showInterstitialAd(onComplete: () {
                          Get.toNamed(AppPages.vipScreen);
                        });
                      },
                      child: commanTile(
                          icon: Icons.wb_incandescent_rounded, title: "VIP"),
                    ),
                    GestureDetector(
                      onTap: () {
                        AdHelper.showInterstitialAd(onComplete: () {
                          //
                          Get.toNamed(AppPages.diamond);
                        });
                      },
                      child: commanTile(icon: Icons.diamond, title: "Diamond"),
                    ),
                    Container(
                      child: _adController.ad != null &&
                              _adController.adLoaded.isTrue
                          ? SafeArea(
                              child: SizedBox(
                                  height: 150,
                                  child: AdWidget(ad: _adController.ad!)))
                          : null,
                    ),
                    GestureDetector(
                      onTap: () {
                        AdHelper.showInterstitialAd(onComplete: () {
                          //
                          Get.toNamed(AppPages.myPresents);
                        });
                      },
                      child: commanTile(
                          icon: Icons.card_giftcard, title: "My Present"),
                    ),
                    GestureDetector(
                      onTap: () {
                        AdHelper.showInterstitialAd(onComplete: () {
                          //
                          Get.toNamed(AppPages.visitor);
                        });
                      },
                      child: commanTile(icon: Icons.person_4, title: "Visitor"),
                    ),
                    GestureDetector(
                      onTap: () {
                        AdHelper.showInterstitialAd(onComplete: () {
                          //
                          Get.toNamed(AppPages.tearmCondition,arguments: false);
                        });
                      },
                      child: commanTile(
                          icon: Icons.note, title: "Terms and Conditions"),
                    ),
                    if (homeController.userLogin())
                      GestureDetector(
                        onTap: () {
                          AdHelper.showInterstitialAd(onComplete: () {
                            FirebaseAuth.instance.signOut();
                            Get.offAllNamed(AppPages.login);
                          });
                        },
                        child: commanTile(icon: Icons.logout, title: "Logout"),
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

  commanTile({required IconData icon, required String title}) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 15),
      decoration: BoxDecoration(
          border: Border(
              bottom: BorderSide(
        color: black.withOpacity(0.2),
      ))),
      child: ListTile(
        contentPadding: const EdgeInsets.only(right: 10),
        leading: Container(
          padding: const EdgeInsets.all(15),
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: greenColor),
          child: Icon(icon, color: white),
        ),
        title: CustomText(text: title, weight: FontWeight.w700),
        trailing: GestureDetector(
            onTap: () {},
            child: Transform.rotate(
                angle: 3.2, child: const Icon(Icons.arrow_back_ios))),
      ),
    );
  }
}
