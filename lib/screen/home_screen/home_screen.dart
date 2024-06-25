import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:video_call/Adhelper/ad_helper.dart';
import 'package:video_call/routes/app_pages.dart';
import 'package:video_call/screen/home_screen/home_con.dart';
import 'package:video_call/screen/profile/profile_screen.dart';
import 'package:video_call/screen/video_reel/video_screen.dart';
import '../../Adhelper/ad_config.dart';
import '../../common/colors.dart';
import '../chat_screen/user_show_scree.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  HomeController homeController = Get.find();
  // List bottom = [Icons.home, Icons.video_call, Icons.chat, Icons.person];

  List pages = [
    Container(),
    const VideoReelsScreen(),
    const UserShowScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
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

  final _adController = NativeAdController();

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        AdHelper.showInterstitialAd(onComplete: () {
          Get.back();
        });
        return true;
      },
      child: Obx(
        () {
          _adController.ad = AdHelper.loadNativeAd(adController: _adController);
          return Scaffold(
            backgroundColor: yellowOpacity,
            appBar: homeController.currantIndex.value == 1 ||
                    homeController.currantIndex.value == 3
                ? null
                : AppBar(
                    surfaceTintColor: Colors.transparent,
                    toolbarHeight: 80,
                    backgroundColor: yellowOpacity,
                    bottom: PreferredSize(
                      preferredSize: const Size.fromHeight(1),
                      child: Container(
                        height: 1,
                        color: black,
                      ),
                    ),
                    leading: GestureDetector(
                        onTap: () {
                          AdHelper.showInterstitialAd(onComplete: () {
                            Get.back();
                          });
                        },
                        child: const Icon(Icons.arrow_back_ios_new)),
                  ),
            body: homeController.currantIndex.value != 0
                ? pages[homeController.currantIndex.value]
                : SingleChildScrollView(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      children: [
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children: List.generate(
                              homeController.photos.length - 10,
                              (index) {
                                var data = homeController.photos.reversed
                                    .toList()[index];
                                return GestureDetector(
                                  onTap: (){
                                    AdHelper.showInterstitialAd(onComplete: (){
                                      Get.toNamed(AppPages.videoReels);
                                    });
                                  },
                                  child: Container(
                                    height: 80,
                                    width: 80,
                                    padding: const EdgeInsets.all(3),
                                    margin: EdgeInsets.only(
                                        left: index == 0 ? 0 : 10, bottom: 20),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      gradient: const LinearGradient(
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft,
                                        stops: [0.1, 0.5],
                                        colors: [greenColor, mendicolor],
                                      ),
                                    ),
                                    child: Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(100),
                                          image: DecorationImage(
                                              image: Config.hideAds
                                                  ? const NetworkImage(
                                                      "https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg")
                                                  : NetworkImage(
                                                      "${data["photo"]}"),
                                              fit: BoxFit.cover,
                                              alignment: Alignment.topCenter)),
                                    ),
                                  ),
                                );
                              },
                            ),
                          ),
                        ),
                        Column(
                          children: List.generate(
                            (homeController.photos.length ~/ 2) * 3,
                            (index) {
                              if ((index + 1) % 3 == 0) {
                                // Insert an ad every 3rd item
                                // return NativeAdWidget();

                                return Container(
                                  child: _adController.ad != null &&
                                          _adController.adLoaded.isTrue
                                      ? SafeArea(
                                          child: SizedBox(
                                              height: 150,
                                              child: AdWidget(
                                                  ad: _adController.ad!)))
                                      : null,
                                );
                              } else {
                                // Calculate the actual product index
                                int productIndex = index - (index ~/ 3);
                                // Create rows with two products
                                if (productIndex % 2 == 0) {
                                  return Row(
                                    children: [
                                      Expanded(
                                          child: ViewData(
                                        data: homeController
                                            .photos[productIndex]
                                            .data() as Map,
                                      )),
                                      if (productIndex + 1 <
                                          homeController.photos.length)
                                        Expanded(
                                            child: ViewData(
                                          data: homeController
                                              .photos[productIndex + 1]
                                              .data() as Map,
                                        ))
                                    ],
                                  );
                                }
                                // Skip creating a separate row for the second product in a pair
                                return const SizedBox.shrink();
                              }
                            },
                          ),
                        )
                      ],
                    ),
                  ),
          );
        },
      ),
    );
  }
}

class ViewData extends StatefulWidget {
  final Map data;
  const ViewData({super.key, required this.data});

  @override
  State<ViewData> createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        AdHelper.showInterstitialAd(onComplete: () {
          Get.toNamed(AppPages.userScreen, arguments: widget.data);
        });
      },
      child: Card(
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
                image: DecorationImage(
                    image: Config.hideAds
                        ? const NetworkImage(
                            "https://t3.ftcdn.net/jpg/03/34/83/22/360_F_334832255_IMxvzYRygjd20VlSaIAFZrQWjozQH6BQ.jpg")
                        : NetworkImage("${widget.data["photo"]}"),
                    fit: Config.hideAds ? BoxFit.contain : BoxFit.cover),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 15, top: 10),
              child: CustomText(
                text: "${widget.data["name"]}",
                maxline: 1,
                fontSize: 13.sp,
                weight: FontWeight.w700,
                color: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, left: 15, right: 15),
              child: CustomText(
                text: "${widget.data["dob"]}",
                fontSize: 12.sp,
                weight: FontWeight.w700,
                align: TextAlign.start,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
