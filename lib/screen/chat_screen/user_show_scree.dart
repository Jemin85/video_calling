import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_call/routes/app_pages.dart';
import 'package:video_call/screen/chat_screen/chat_con.dart';

import '../../common/colors.dart';

class UserShowScreen extends StatefulWidget {
  const UserShowScreen({super.key});

  @override
  State<UserShowScreen> createState() => _UserShowScreenState();
}

class _UserShowScreenState extends State<UserShowScreen> {
  ChatController chatController = Get.put(ChatController());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 150,
          margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
          color: mendicolor,
        ),
        Expanded(child: Obx(
          () {
            return SingleChildScrollView(
              child: Column(
                children: List.generate(
                  chatController.getChatData.length,
                  (index) {
                    var object =
                        chatController.getChatData[index].data() as Map;
                    return ListTile(
                      onTap: () {
                        Get.toNamed(AppPages.showchat,
                            arguments: "${object["name"]}");
                      },
                      contentPadding: const EdgeInsets.all(15),
                      leading: const CircleAvatar(
                        radius: 30,
                        backgroundColor: greenColor,
                      ),
                      shape: RoundedRectangleBorder(
                        side: BorderSide(
                            color: black.withOpacity(0.2), width: 0.2),
                      ),
                      title: CustomText(
                        text: "${object["name"]}",
                        weight: FontWeight.w700,
                        fontSize: 15.sp,
                      ),
                      subtitle: CustomText(
                        text: "${object["massage"].last["msg"]}",
                        weight: FontWeight.w700,
                        color: black.withOpacity(0.3),
                        fontSize: 12.sp,
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ))
      ],
    );
  }
}
