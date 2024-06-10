import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_call/routes/app_pages.dart';

import '../../common/colors.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
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
                    // Get.toNamed(AppPages.EditProfile);
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
                        title: const CustomText(
                          text: "${"-"}",
                          weight: FontWeight.w600,
                        ),
                        subtitle: CustomText(
                            text: "${"-"}",
                            weight: FontWeight.w400,
                            fontSize: 14.sp),
                      )),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 80),
        Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              GestureDetector(
                onTap: () {},
                child: commanTile(
                    icon: Icons.wb_incandescent_rounded, title: "VIP"),
              ),
              GestureDetector(
                onTap: () {},
                child: commanTile(
                    icon: Icons.diamond, title: "Diamond"),
              ),
              GestureDetector(
                onTap: () {},
                child: commanTile(
                    icon: Icons.card_giftcard, title: "My Present"),
              ),
              GestureDetector(
                onTap: () {},
                child: commanTile(
                    icon: Icons.settings, title: "Settings"),
              ),
                GestureDetector(
                onTap: () {},
                child: commanTile(
                    icon: Icons.logout, title: "Logout"),
              ),
            ],
          ),
        )
      ],
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
