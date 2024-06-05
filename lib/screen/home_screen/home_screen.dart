import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:video_call/screen/home_screen/home_con.dart';
import 'package:video_call/screen/profile/profile_screen.dart';
import 'package:video_call/screen/video_reel/video_screen.dart';

import '../../common/colors.dart';
import '../chat_screen/user_show_scree.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeController homeController = Get.put(HomeController());
  List bottom = [Icons.home, Icons.video_call, Icons.chat, Icons.person];
  int indexs = 15;

  List pages = [
    Container(),
    const VideoReelsScreen(),
    const UserShowScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return Scaffold(
          extendBodyBehindAppBar:
              homeController.currantIndex.value == 3 ? false : true,
          backgroundColor: white,
          appBar: homeController.currantIndex.value == 1 ||
                  homeController.currantIndex.value == 3
              ? null
              : AppBar(
                  surfaceTintColor: Colors.transparent,
                  toolbarHeight: 80,
                  backgroundColor: white,
                  bottom: PreferredSize(
                    preferredSize: const Size.fromHeight(1),
                    child: Container(
                      height: 1,
                      color: black,
                    ),
                  ),
                ),
          bottomNavigationBar: SizedBox(
            height: 80,
            child: Row(
              children: List.generate(
                bottom.length,
                (index) {
                  return Expanded(
                    child: GestureDetector(
                      onTap: () {
                        homeController.changeIndex(index);
                      },
                      child: Container(
                        color: white,
                        child: Icon(
                          bottom[index],
                          size: 30,
                          color: homeController.currantIndex.value == index
                              ? greenColor
                              : black,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          body: homeController.currantIndex.value != 0
              ? pages[homeController.currantIndex.value]
              : ListView.builder(
                  padding: const EdgeInsets.all(15),
                  itemCount:
                      (indexs ~/ 2) * 3, // Total items, accounting for ads
                  itemBuilder: (context, index) {
                    if ((index + 1) % 3 == 0) {
                      // Insert an ad every 3rd item
                      // return NativeAdWidget();
                      return Container(
                        height: 150,
                        margin: const EdgeInsets.symmetric(vertical: 10),
                        color: mendicolor,
                      );
                      // return !Config.hideAds
                      //     ? const Padding(
                      //         padding: EdgeInsets.symmetric(vertical: 10),
                      //         child: NativeAdWidget(),
                      //       )
                      //     : Container(
                      //         height: 0,
                      //         color: Colors.white,
                      //       );
                    } else {
                      // Calculate the actual product index
                      int productIndex = index - (index ~/ 3);
                      // Create rows with two products
                      if (productIndex % 2 == 0) {
                        return Row(
                          children: [
                            const Expanded(child: ViewData()),
                            // Expanded(
                            //     child: ProductWigets(
                            //         index: index,
                            //         object: homeController
                            //             .allProductList[productIndex]
                            //             .data() as Map)),
                            // Expanded(child: ProductWidget(products[productIndex])),
                            if (productIndex + 1 < indexs)
                              const Expanded(child: ViewData())
                            // Expanded(
                            //     child: ProductWigets(
                            //         index: index,
                            //         object: homeController
                            //             .allProductList[productIndex + 1]
                            //             .data() as Map)),
                          ],
                        );
                      }
                      // Skip creating a separate row for the second product in a pair
                      return const SizedBox.shrink();
                    }
                  },
                ),
        );
      },
    );
  }
}

class ViewData extends StatefulWidget {
  const ViewData({super.key});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 180,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              // image: DecorationImage(
              //     image: NetworkImage("${object["photo"]}"), fit: BoxFit.cover),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15, top: 10),
            child: CustomText(
              text: "Sunny",
              maxline: 1,
              fontSize: 13.sp,
              weight: FontWeight.w700,
              color: Colors.black,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomText(
                  text: "₹ 152",
                  fontSize: 12.sp,
                  weight: FontWeight.w700,
                  align: TextAlign.center,
                  color: Colors.black,
                ),
                Row(
                  children: List.generate(
                    5,
                    (index) => Icon(
                      index > 3 ? Icons.star_border : Icons.star,
                      size: 12,
                      color: Colors.amber,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
