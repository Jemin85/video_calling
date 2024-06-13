import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_call/common/colors.dart';
import 'package:video_call/screen/login/login_con.dart';

import '../../Adhelper/ad_config.dart';
import '../../Adhelper/ad_helper.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with WidgetsBindingObserver {
  LoginController loginController = Get.put(LoginController());

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
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/splash.jpg"), fit: BoxFit.cover)),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 3.0),
          child: ClipRRect(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CustomText(
                          text: "Welcome To Tingle",
                          color: white,
                          fontSize: 35.sp,
                          weight: FontWeight.w900,
                        ),
                        CustomText(text: "text")
                      ],
                    ),
                  ),
                  Obx(() {
                    return GestureDetector(
                      onTap: () {
                        loginController.signInWithGoogle();
                      },
                      child: Container(
                        // width: double.infinity,
                        alignment: Alignment.center,
                        margin: const EdgeInsets.symmetric(vertical: 25),
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                            color: white,
                            borderRadius: BorderRadius.circular(10)),
                        child: loginController.isload.value
                            ? const CircularProgressIndicator(color: black)
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "images/google.png",
                                    height: 20,
                                  ),
                                  const SizedBox(width: 10),
                                  const CustomText(
                                    text: "Google Login",
                                    weight: FontWeight.w700,
                                  )
                                ],
                              ),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
