import 'dart:ui';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_call/Adhelper/ad_helper.dart';
import 'package:video_call/routes/app_pages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(milliseconds: 1500),
      () {
        bool userlogin = FirebaseAuth.instance.currentUser != null;
        AdHelper.precacheInterstitialAd();
        AdHelper.precacheNativeAd();
        if (userlogin) {
          Get.toNamed(AppPages.mainHome);
        } else {
          Get.toNamed(AppPages.tearmCondition,arguments: true);
        }
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("images/splash.jpg"), fit: BoxFit.cover),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 3.0),
          child: ClipRRect(
            child: Container(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              alignment: Alignment.center,
            ),
          ),
        ),
      ),
    );
  }
}
