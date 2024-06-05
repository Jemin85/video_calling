import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_call/common/colors.dart';

class ShowChatScreen extends StatefulWidget {
  const ShowChatScreen({super.key});

  @override
  State<ShowChatScreen> createState() => _ShowChatScreenState();
}

class _ShowChatScreenState extends State<ShowChatScreen> {
  TextEditingController chat = TextEditingController();
  List chatData = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        toolbarHeight: 80,
        centerTitle: false,
        surfaceTintColor: Colors.transparent,
        title: CustomText(
          text: "Chat".toUpperCase(),
          weight: FontWeight.w700,
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
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
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 17),
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
                  chatData.add("${chat.text}    ");
                  chat.clear();
                  setState(() {});
                }
              },
              child: const CircleAvatar(
                radius: 27,
                backgroundColor: greenColor,
                child: Padding(
                  padding: EdgeInsets.only(left: 5),
                  child: Icon(
                    Icons.send,
                    color: white,
                  ),
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
          padding: const EdgeInsets.only(bottom: 90),
          physics: const AlwaysScrollableScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: List.generate(
              chatData.length,
              (index) {
                if (index % 2 == 0) {
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
                          child: "${chatData[index]}".length < 30
                              ? RichText(
                                  text: TextSpan(
                                    text: "${chatData[index]}",
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
                                      text: "${chatData[index]}",
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
                        child: "${chatData[index]}".length < 30
                            ? RichText(
                                text: TextSpan(
                                  text: "${chatData[index]}",
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
                                    text: "${chatData[index]}",
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
          ),
        ),
      ),
    );
  }
}
