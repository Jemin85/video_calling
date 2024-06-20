import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_call/common/colors.dart';
import 'package:video_call/routes/app_pages.dart';
import 'package:video_call/screen/chat_screen/chat_con.dart';

import '../../Adhelper/ad_config.dart';
import '../../Adhelper/ad_helper.dart';

class ShowChatScreen extends StatefulWidget {
  const ShowChatScreen({super.key});

  @override
  State<ShowChatScreen> createState() => _ShowChatScreenState();
}

class _ShowChatScreenState extends State<ShowChatScreen>
    with WidgetsBindingObserver {
  ChatController chatController = Get.find();
  TextEditingController chat = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    chatController.findUserChatData(name: "${Get.arguments}");
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
    return WillPopScope(
      onWillPop: () async {
        AdHelper.showInterstitialAd(onComplete: () {
          Get.back();
        });
        return true;
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 80,
          centerTitle: true,
          surfaceTintColor: Colors.transparent,
          title: CustomText(
            text: "${Get.arguments["name"]}".toUpperCase(),
            weight: FontWeight.w700,
          ),
          leading: GestureDetector(
              onTap: () {
                AdHelper.showInterstitialAd(onComplete: () {
                  Get.back();
                });
              },
              child: const Icon(Icons.arrow_back_ios_new)),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: 1 == 1
            ? GestureDetector(
                onTap: () {
                  AdHelper.showInterstitialAd(onComplete: () {
                    Get.toNamed(AppPages.vipScreen);
                  });
                },
                child: Container(
                  height: 55,
                  width: double.infinity,
                  margin: const EdgeInsets.only(top: 15, left: 15, right: 15),
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                      color: greenColor,
                      borderRadius: BorderRadius.circular(30)),
                  child: const CustomText(
                    text: "Get VIP Only Rs.99",
                    weight: FontWeight.w700,
                    color: white,
                  ),
                ),
              )
            : Container(
                color: white,
                margin: const EdgeInsets.only(top: 15),
                padding: const EdgeInsets.only(left: 15, right: 15, top: 15),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: chat,
                        cursorColor: black,
                        style: const TextStyle(fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          hintText: "Typing....",
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 20, vertical: 17),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(30),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    GestureDetector(
                      onTap: () {
                        if (chat.text.isNotEmpty) {
                          chatController.addData(msg: chat.text);
                          chat.clear();
                          setState(() {});
                        }
                      },
                      child: const CircleAvatar(
                        radius: 27,
                        backgroundColor: greenColor,
                        child: Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Icon(Icons.send, color: white),
                        ),
                      ),
                    )
                  ],
                ),
              ),
        backgroundColor: white,
        body: Container(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            controller: scrollController,
            padding: const EdgeInsets.only(bottom: 90),
            physics: const AlwaysScrollableScrollPhysics(),
            child: StreamBuilder(
              stream: chatController.findUserChatData(name: "${Get.arguments["name"]}"),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.data!.docs.isEmpty) {
                  chatController.noChatFound(name: "${Get.arguments["name"]}",profile: "${Get.arguments["photo"]}");
                  return const Center(
                    child: CustomText(
                      text: "No chat found",
                      color: black,
                      weight: FontWeight.w600,
                    ),
                  );
                }
                Map data = snapshot.data!.docs[0].data() as Map;
                List chat = data["massage"];
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: List.generate(
                    chat.length,
                    (index) {
                      var object = chat[index];
                      if (object["email"] == FirebaseAuth.instance.currentUser!.email) {
                        return Padding(
                          padding: EdgeInsets.only(
                              bottom: 10,
                              left: MediaQuery.of(context).size.width * 0.3),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 15, vertical: 8),
                                decoration: BoxDecoration(
                                    color: greenColor,
                                    borderRadius: BorderRadius.circular(10),
                                    border: Border.all(color: greenColor)),
                                child: "${chat[index]["msg"]}".length < 30
                                    ? RichText(
                                        text: TextSpan(
                                          text: "${chat[index]["msg"]}",
                                          style: TextStyle(
                                              color: black,
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w500),
                                          children: [
                                            TextSpan(
                                              text: "11:20 PM",
                                              style: TextStyle(
                                                  color: black.withOpacity(0.5),
                                                  fontSize: 8.2.sp,
                                                  fontWeight: FontWeight.w500),
                                            )
                                          ],
                                        ),
                                      )
                                    : Stack(
                                        clipBehavior: Clip.none,
                                        children: [
                                          CustomText(
                                            text: "${chat[index]["msg"]}",
                                            weight: FontWeight.w600,
                                            fontSize: 14.sp,
                                          ),
                                          Positioned(
                                            bottom: -5,
                                            right: -8,
                                            child: CustomText(
                                              text: "11:20 PM",
                                              weight: FontWeight.w600,
                                              color: black.withOpacity(0.5),
                                              fontSize: 9.sp,
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Padding(
                        padding: EdgeInsets.only(
                            bottom: 10,
                            right: MediaQuery.of(context).size.width * 0.3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 8),
                              decoration: BoxDecoration(
                                  color: mendicolor,
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(color: mendicolor)),
                              child: "${chat[index]["msg"]}".length < 30
                                  ? RichText(
                                      text: TextSpan(
                                        text: "${chat[index]["msg"]}",
                                        style: TextStyle(
                                            color: black,
                                            fontSize: 14.sp,
                                            fontWeight: FontWeight.w500),
                                        children: [
                                          TextSpan(
                                            text: "11:20 PM",
                                            style: TextStyle(
                                                color: black.withOpacity(0.5),
                                                fontSize: 9.sp,
                                                fontWeight: FontWeight.w500),
                                          )
                                        ],
                                      ),
                                    )
                                  : Stack(
                                      clipBehavior: Clip.none,
                                      children: [
                                        CustomText(
                                          text: "${chat[index]["msg"]}",
                                          weight: FontWeight.w600,
                                          fontSize: 14.sp,
                                        ),
                                        Positioned(
                                          bottom: -5,
                                          right: -8,
                                          child: CustomText(
                                            text: "11:20 PM",
                                            weight: FontWeight.w600,
                                            color: black.withOpacity(0.5),
                                            fontSize: 10.sp,
                                          ),
                                        ),
                                      ],
                                    ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
