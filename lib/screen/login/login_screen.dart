import 'package:flutter/material.dart';
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
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Obx(() {
              return GestureDetector(
                onTap: () {
                  loginController.signInWithGoogle();
                },
                child: Container(
                    // width: double.infinity,
                    alignment: Alignment.center,
                    margin: const EdgeInsets.symmetric(vertical: 25),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        color: white, borderRadius: BorderRadius.circular(10)),
                    child: loginController.isload.value
                        ? const CircularProgressIndicator(color: black)
                        : const Text(
                            "Google Login") // SvgPicture.asset("images/google.svg"),
                    ),
              );
            }),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {},
              child: const CustomText(text: "Guest"),
            )
          ],
        ),
      ),
    );
  }
}
