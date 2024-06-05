import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_call/routes/app_pages.dart';

import '../../common/colors.dart';

class UserShowScreen extends StatefulWidget {
  const UserShowScreen({super.key});

  @override
  State<UserShowScreen> createState() => _UserShowScreenState();
}

class _UserShowScreenState extends State<UserShowScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          color: mendicolor,
        ),
        Expanded(
          child: SingleChildScrollView(
            child: Column(
              children: List.generate(
                15,
                (index) {
                  return ListTile(
                    onTap: () {
                      Get.toNamed(AppPages.showchat);
                    },
                    contentPadding: const EdgeInsets.all(15),
                    leading: const CircleAvatar(
                      radius: 30,
                      backgroundColor: greenColor,
                    ),
                    shape: RoundedRectangleBorder(
                      side:
                          BorderSide(color: black.withOpacity(0.2), width: 0.2),
                    ),
                    title: CustomText(
                      text: "ABC DFGHJ",
                      weight: FontWeight.w700,
                      fontSize: 15.sp,
                    ),
                    subtitle: CustomText(
                      text: "ABC DFGHJ",
                      weight: FontWeight.w700,
                      color: black.withOpacity(0.3),
                      fontSize: 12.sp,
                    ),
                  );
                },
              ),
            ),
          ),
        )
      ],
    );
  }
}
