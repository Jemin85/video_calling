import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:video_call/Adhelper/ad_helper.dart';

import '../../common/colors.dart';

class MyPresentsScreen extends StatefulWidget {
  const MyPresentsScreen({super.key});

  @override
  State<MyPresentsScreen> createState() => _MyPresentsScreenState();
}

class _MyPresentsScreenState extends State<MyPresentsScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
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
        backgroundColor: yellowOpacity,
        appBar: AppBar(
          toolbarHeight: 70,
          backgroundColor: yellowOpacity,
          leading: GestureDetector(
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
            text: "My Presents".toUpperCase(),
            weight: FontWeight.w700,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Text("Notifications", style: AppTextStyle.black24w700),
              Container(
                height: 32.h,
                decoration: BoxDecoration(
                    color: white.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(8)),
                child: TabBar(
                  controller: _tabController,
                  unselectedLabelStyle: GoogleFonts.urbanist(
                      color: black,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp),
                  dividerColor: Colors.transparent,
                  labelStyle: GoogleFonts.urbanist(
                      color: white,
                      fontWeight: FontWeight.w600,
                      fontSize: 14.sp),
                  indicatorSize: TabBarIndicatorSize.tab,
                  indicatorPadding: const EdgeInsets.all(2),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(6),
                    color: greenColor,
                  ),
                  onTap: (val) {
                    // selectSeatController.selectindex(val);
                  },
                  tabs: const [
                    Tab(text: 'Transactions'),
                    Tab(text: 'Messages'),
                  ],
                ),
              ),
              Expanded(
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    transaction(),
                    msg(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  transaction() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.info, size: 30,color: greenColor,),
        SizedBox(height: 10),
        CustomText(
          text: "No Data Found",
          weight: FontWeight.w700,
        )
      ],
    );
  }

  msg() {
    return const Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.info, size: 30,color: greenColor,),
        SizedBox(height: 10),
        CustomText(
          text: "No Data Found",
          weight: FontWeight.w700,
        )
      ],
    );
  }
}