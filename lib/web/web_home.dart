import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_call/common/colors.dart';
import 'package:video_call/routes/app_pages.dart';
import 'package:video_call/web/web_con.dart';

class WebHomeScreen extends StatefulWidget {
  const WebHomeScreen({super.key});

  @override
  State<WebHomeScreen> createState() => _WebHomeScreenState();
}

class _WebHomeScreenState extends State<WebHomeScreen> {
  WebController webController = Get.put(WebController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container(
        alignment: Alignment.center,
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(AppPages.photoAdd);
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: greenColor, borderRadius: BorderRadius.circular(10)),
                child: CustomText(
                  text: "Photos",
                  fontSize: 5.sp,
                  color: white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Get.toNamed(AppPages.uploadReels);
              },
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                    color: greenColor, borderRadius: BorderRadius.circular(10)),
                child: CustomText(
                  text: "Reels",
                  fontSize: 5.sp,
                  color: white,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                  color: greenColor, borderRadius: BorderRadius.circular(10)),
              child: CustomText(
                text: "Chat",
                fontSize: 5.sp,
                color: white,
              ),
            )
          ],
        ),
      ),
    );
  }
}
