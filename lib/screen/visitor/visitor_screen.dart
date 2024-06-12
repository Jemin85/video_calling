import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:video_call/common/colors.dart';

class VisitorScreem extends StatefulWidget {
  const VisitorScreem({super.key});

  @override
  State<VisitorScreem> createState() => _VisitorScreemState();
}

class _VisitorScreemState extends State<VisitorScreem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowOpacity,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: yellowOpacity,
        surfaceTintColor: Colors.transparent,
        title: CustomText(
          text: "Visitor".toUpperCase(),
          weight: FontWeight.w700,
        ),
      ),
      body: Container(
        child: GridView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 0,
            crossAxisSpacing: 0,
            childAspectRatio: 0.85,
          ),
          children: List.generate(
            6,
            (index) {
              return GestureDetector(
                onTap: () async {},
                child: Column(
                  children: [
                     CircleAvatar(
                      radius: 55,
                      child:  Center(
                        child:  ClipRect(
                        
                          child:  BackdropFilter(
                            filter:  ImageFilter.blur(
                                sigmaX: 10.0, sigmaY: 10.0),
                            child: CircleAvatar(
                                radius: 55,
                              backgroundColor: Colors.grey.shade200.withOpacity(0.5),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 10),
                    CustomText(text: "fdf",fontSize: 14.sp,weight: FontWeight.w700,)
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
