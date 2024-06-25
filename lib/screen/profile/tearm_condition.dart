import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

import '../../Adhelper/ad_helper.dart';
import '../../common/colors.dart';
import '../../routes/app_pages.dart';

class TearmAndConditions extends StatefulWidget {
  const TearmAndConditions({super.key});

  @override
  State<TearmAndConditions> createState() => _TearmAndConditionsState();
}

class _TearmAndConditionsState extends State<TearmAndConditions> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowOpacity,
      appBar: AppBar(
        toolbarHeight: 70,
        backgroundColor: yellowOpacity,
        automaticallyImplyLeading: false,
        leading: Get.arguments
            ? null
            : GestureDetector(
                onTap: () {
                  AdHelper.showInterstitialAd(onComplete: () {
                    Get.back();
                  });
                },
                child: const Icon(
                  Icons.arrow_back_ios,
                  color: black,
                ),
              ),
        title: CustomText(
          text: "Terms and Conditions".toUpperCase(),
          weight: FontWeight.w700,
        ),
      ),
      bottomNavigationBar: Get.arguments
          ? Container(
              height: 60,
              margin: const EdgeInsets.only(left: 20, right: 20, bottom: 15),
              child: GestureDetector(
                onTap: () {
                  AdHelper.showInterstitialAd(onComplete: () {
                    Get.toNamed(AppPages.login);
                  });
                },
                child: Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(10)),
                  child: CustomText(
                    text: "Accept".toUpperCase(),
                    fontSize: 16.sp,
                    color: white,
                    weight: FontWeight.w700,
                  ),
                ),
              ),
            )
          : null,
      body: Container(
        padding: const EdgeInsets.all(15),
        child: SingleChildScrollView(
          padding: const EdgeInsets.only(bottom: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomText(
                text:
                    "Welcome to Tingle: Live Video Call & Chat. By downloading or using our App, these terms will automatically apply to you – you should make sure therefore that you read them carefully before using the App. ",
                fontSize: 14.sp,
                align: TextAlign.justify,
                weight: FontWeight.w500,
              ),
              const SizedBox(height: 15),
              const CustomText(
                text: "2. User Accounts",
                weight: FontWeight.w700,
                color: black,
              ),
              const SizedBox(height: 8),
              CustomText(
                text:
                    "To use our App, you must create an account. You must provide accurate and complete information and keep your account information updated. You are responsible for maintaining the confidentiality of your account and password and for restricting access to your device. You agree to accept responsibility for all activities that occur under your account.",
                fontSize: 12.sp,
                align: TextAlign.justify,
                color: black.withOpacity(0.5),
                weight: FontWeight.w500,
              ),
              const SizedBox(height: 15),
              const CustomText(
                text: "3. Age Restriction",
                weight: FontWeight.w700,
                color: black,
              ),
              const SizedBox(height: 8),
              CustomText(
                text:
                    "You must be at least 18 years of age to use our App. By using the App, you represent and warrant that you are at least 18 years of age.",
                fontSize: 12.sp,
                align: TextAlign.justify,
                color: black.withOpacity(0.5),
                weight: FontWeight.w500,
              ),
              const SizedBox(height: 15),
              const CustomText(
                text: "4. Acceptable Use",
                weight: FontWeight.w700,
                color: black,
              ),
              const SizedBox(height: 8),
              CustomText(
                text:
                    "You agree to use the App only for lawful purposes and in a way that does not infringe the rights of, restrict, or inhibit anyone else’s use and enjoyment of the App. Prohibited behavior includes harassing or causing distress or inconvenience to any other user, transmitting obscene or offensive content, or disrupting the normal flow of dialogue within the App.",
                fontSize: 12.sp,
                align: TextAlign.justify,
                color: black.withOpacity(0.5),
                weight: FontWeight.w500,
              ),
              const SizedBox(height: 15),
              const CustomText(
                text: "5. Privacy",
                weight: FontWeight.w700,
                color: black,
              ),
              const SizedBox(height: 8),
              CustomText(
                text:
                    "We take your privacy seriously and are committed to protecting your personal information. Please refer to our Privacy Policy https://tingle-video-call-chat.blogspot.com/2024/06/tingle-video-call-chat-privacy-policy.html for information on how we collect, use, and disclose your information.",
                fontSize: 12.sp,
                align: TextAlign.justify,
                color: black.withOpacity(0.5),
                weight: FontWeight.w500,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
