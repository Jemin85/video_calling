import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:video_call/Adhelper/ad_config.dart';
import 'package:video_call/common/colors.dart';
import 'package:video_call/routes/app_pages.dart';
import 'package:video_call/screen/profile/profile_con.dart';

import '../../Adhelper/ad_helper.dart';
import '../../common/msg.dart';

class VIPScreen extends StatefulWidget {
  const VIPScreen({super.key});

  @override
  State<VIPScreen> createState() => _VIPScreenState();
}

class _VIPScreenState extends State<VIPScreen> with WidgetsBindingObserver {
  ProfileController profileController = Get.put(ProfileController());
  final _adController = NativeAdController();
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  final List<String> _productIds = [
    'basic',
    'silver',
    'gold',
    'platinum',
    'test',
    // 'com.video.callApp:android.test.purchased',
  ];
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  List<ProductDetails> _products = [];
  bool _isAvailable = false;
  List member = [
    {
      "title": "Unlock chat restrictions",
      "value": "Unlimited chatting with anybody",
      "icon": Icons.message
    },
    {
      "title": "Access to calls",
      "value": "Purchase diamonds for calls",
      "icon": Icons.video_call
    },
    {
      "title": "Quality user recommendation",
      "value": "Recommanded you better and more enthusiastic girl",
      "icon": Icons.heart_broken
    },
    {
      "title": "VIP Exclusive Logo",
      "value": "Let more intersting people find you",
      "icon": Icons.window_rounded
    },
    {
      "title": "Unlock all personal information",
      "value": "can view secret albums and videos",
      "icon": Icons.person_3
    },
  ];

  @override
  void initState() {
    WidgetsBinding.instance.addObserver(this);
    final purchaseUpdated = _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(_onPurchaseUpdated);
    _initialize();
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
    _adController.ad = AdHelper.loadNativeAd(adController: _adController);
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
          backgroundColor: yellowOpacity,
          surfaceTintColor: Colors.transparent,
          // toolbarHeight: 70,
          leading: GestureDetector(
              onTap: () {
                AdHelper.showInterstitialAd(onComplete: () {
                  Get.back();
                  // profileController.purchaseProduct(subId: "test");
                });
              },
              child: const Icon(
                Icons.arrow_back_ios,
                color: black,
              )),
          title: const CustomText(
            text: "VIP",
            color: black,
            weight: FontWeight.w700,
          ),
        ),
        body: Container(
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child:
                      _adController.ad != null && _adController.adLoaded.isTrue
                          ? SafeArea(
                              child: SizedBox(
                                  height: 150,
                                  child: AdWidget(ad: _adController.ad!)))
                          : null,
                ),
                Column(
                  children: List.generate(
                    _products.length,
                    (index) {
                      return GestureDetector(
                        onTap: () {
                          AdHelper.showInterstitialAd(onComplete: () {
                            _buyProduct(_products[index]);
                          });
                        },
                        child: listTimeshow(
                            title: _products[index].title.split("(")[0],
                            subtitle: _products[index]
                                .title
                                .split("(")[1]
                                .replaceAll(")", ""),
                            trailing: _products[index].price),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () {
                    AdHelper.showInterstitialAd(onComplete: () {
                      Get.toNamed(AppPages.tearmCondition, arguments: false);
                    });
                  },
                  child: CustomText(
                    text: "Terms and Conditions",
                    align: TextAlign.center,
                    color: greenColor,
                    fontSize: 14.sp,
                    weight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 10),
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 15),
                  child:
                      _adController.ad != null && _adController.adLoaded.isTrue
                          ? SafeArea(
                              child: SizedBox(
                                  height: 150,
                                  child: AdWidget(ad: _adController.ad!)))
                          : null,
                ),
                CustomText(
                  text: "Member Privieges",
                  weight: FontWeight.w600,
                  fontSize: 18.sp,
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Column(
                    children: List.generate(
                      member.length,
                      (index) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: ListTile(
                            contentPadding: EdgeInsets.zero,
                            leading: CircleAvatar(
                              radius: 30,
                              backgroundColor: greenColor,
                              child: Icon(
                                member[index]["icon"],
                                color: white,
                              ),
                            ),
                            title: CustomText(
                              text: "${member[index]["title"]}",
                              weight: FontWeight.w600,
                            ),
                            subtitle: CustomText(
                              text: "${member[index]["value"]}",
                              fontSize: 12.sp,
                              color: black.withOpacity(0.5),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  listTimeshow(
      {required String title,
      required String subtitle,
      required String trailing}) {
    return Card(
      color: white,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
        child: ListTile(
          contentPadding: EdgeInsets.zero,
          leading: const CircleAvatar(
            radius: 25,
            backgroundColor: greenColor,
            child: Icon(Icons.price_change, color: white),
          ),
          title: CustomText(
            text: title,
            weight: FontWeight.w700,
            fontSize: 14.sp,
          ),
          subtitle: CustomText(
            text: subtitle,
            weight: FontWeight.w700,
            fontSize: 10.sp,
            color: greenColor,
            decoration: TextDecoration.lineThrough,
          ),
          trailing: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                  color: greenColor, borderRadius: BorderRadius.circular(16)),
              child: CustomText(
                text: trailing,
                color: white,
                weight: FontWeight.w700,
              )),
        ),
      ),
    );
  }

  Future<void> _verifyAndDeliverProduct(PurchaseDetails purchaseDetails) async {
    // Verify purchase with your server and deliver the product
    // Here we assume the purchase is valid and mark it as delivered
    print("-------dd------${purchaseDetails.productID}");
    if (purchaseDetails.productID == 'test') {
      profileController.purchaseProduct(subId: purchaseDetails.productID);
    } else if (purchaseDetails.productID == 'platinum') {
      // Deliver your product
      profileController.purchaseProduct(subId: purchaseDetails.productID);
    } else if (purchaseDetails.productID == 'gold') {
      // Deliver your product
      profileController.purchaseProduct(subId: purchaseDetails.productID);
    } else if (purchaseDetails.productID == 'silver') {
      // Deliver your product
      profileController.purchaseProduct(subId: purchaseDetails.productID);
    } else if (purchaseDetails.productID == 'basic') {
      // Deliver your product
      profileController.purchaseProduct(subId: purchaseDetails.productID);
    }
  }

  void _buyProduct(ProductDetails productDetails) {
    final purchaseParam = PurchaseParam(productDetails: productDetails);
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  void _onPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList) {
    for (var purchaseDetails in purchaseDetailsList) {
      if (purchaseDetails.status == PurchaseStatus.pending) {
        Get.back();
        MassageBox.showMag("Subscription is Pending");
        // Handle pending purchase
      } else if (purchaseDetails.status == PurchaseStatus.purchased) {
        _verifyAndDeliverProduct(purchaseDetails);
      } else if (purchaseDetails.status == PurchaseStatus.error) {
        Get.back();
        MassageBox.showMag("Subscription Error Please Try Again");
      }
      if (purchaseDetails.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  Future<void> _loadProducts() async {
    final response =
        await _inAppPurchase.queryProductDetails(_productIds.toSet());
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error
    }
    setState(() {
      _products = response.productDetails;
    });
  }

  Future<void> _initialize() async {
    _isAvailable = await _inAppPurchase.isAvailable();
    if (_isAvailable) {
      _loadProducts();
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }
}
