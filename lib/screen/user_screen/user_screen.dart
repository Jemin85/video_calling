import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_call/common/colors.dart';
import 'package:video_call/routes/app_pages.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: yellowOpacity,
      appBar: AppBar(
        toolbarHeight: 80,
        leading: GestureDetector(
            onTap: () {
              Get.back();
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
              onPressed: () {
                Get.toNamed(AppPages.vipScreen);
              },
              backgroundColor: greenColor,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30)),
              child: const Icon(Icons.video_call, color: white),
            ),
            const SizedBox(width: 15),
            FloatingActionButton(
              onPressed: () {
                Get.toNamed(AppPages.showchat);
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
            margin: const EdgeInsets.only(bottom: 20),
            height: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: white,
                borderRadius:
                    BorderRadius.vertical(bottom: Radius.circular(40))),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomText(
                  text: "text",
                  color: black,
                  weight: FontWeight.w800,
                  fontSize: 20.sp,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

class InApp extends StatelessWidget {
  const InApp({super.key});
  //  final InAppPurchaseUtils inAppPurchaseUtils = InAppPurchaseUtils.instance;

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
