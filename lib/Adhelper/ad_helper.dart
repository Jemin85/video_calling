import 'dart:developer';
import 'package:facebook_audience_network/facebook_audience_network.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:get/get.dart';
import 'package:video_call/Adhelper/ad_config.dart';

import '../common/colors.dart';

class NativeAdController extends GetxController {
  NativeAd? ad;
  final adLoaded = false.obs;
}

class AdHelper {
  // for initializing ads sdk
  static Future<void> initAds() async {
    await MobileAds.instance.initialize();
    await FacebookAudienceNetwork.init();
  }

  static InterstitialAd? _interstitialAd;
  static AppOpenAd? myAppOpenAd;
  static BannerAd? bannerAd;
  static bool _interstitialAdLoaded = false;
  static NativeAd? nativeAd;
  static bool _nativeAdLoaded = false;
  static double height = bannerAd!.size.height.toDouble();
  static double width = bannerAd!.size.width.toDouble();

  //*****************Interstitial Ad******************

  static void precacheInterstitialAd() {
    log('------------Precache Interstitial Ad - Id: ${Config.interstitialAd}');

    if (Config.hideAds) return;

    InterstitialAd.load(
      adUnitId: Config.interstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          //ad listener
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            _resetInterstitialAd();
            precacheInterstitialAd();
          });
          _interstitialAd = ad;
          _interstitialAdLoaded = true;
        },
        onAdFailedToLoad: (err) {
          _resetInterstitialAd();
          log('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  static void _resetInterstitialAd() {
    _interstitialAd?.dispose();
    _interstitialAd = null;
    _interstitialAdLoaded = false;
  }

  static void _resetBannerAd() {
    bannerAd?.dispose();
    bannerAd = null;
  }

  static void showInterstitialAd({required VoidCallback onComplete}) {
    log('Interstitial Ad Id: ${Config.interstitialAd}');

    if (Config.hideAds) {
      onComplete();
      return;
    }

    if (_interstitialAdLoaded && _interstitialAd != null) {
      _interstitialAd?.show();
      onComplete();
      return;
    }

    MyDialogs.showProgress();

    InterstitialAd.load(
      adUnitId: Config.interstitialAd,
      request: const AdRequest(),
      adLoadCallback: InterstitialAdLoadCallback(
        onAdLoaded: (ad) {
          //ad listener
          ad.fullScreenContentCallback =
              FullScreenContentCallback(onAdDismissedFullScreenContent: (ad) {
            onComplete();
            _resetInterstitialAd();
            precacheInterstitialAd();
          });
          Get.back();
          ad.show();
        },
        onAdFailedToLoad: (err) {
          fboadInterstitialAd(onComplete: onComplete);
          log('Failed to load an interstitial ad: ${err.message}');
        },
      ),
    );
  }

  static void fboadInterstitialAd({required VoidCallback onComplete}) {
    FacebookInterstitialAd.loadInterstitialAd(
      placementId: Config.fbInterstial,
      listener: (result, value) {
        print(">> FAN > Interstitial Ad: $result --> $value");
        if (result == InterstitialAdResult.LOADED) {
          FacebookInterstitialAd.showInterstitialAd();
          onComplete();
        } else if (result == InterstitialAdResult.ERROR) {
          showInterstitialAd(onComplete: onComplete);
        } else if (result == InterstitialAdResult.DISMISSED &&
            value["invalidated"] == true) {
          Get.back();
          onComplete();
        }
      },
    );
  }

  //*****************Native Ad******************

  static void precacheNativeAd() {
    log('Precache Native Ad - Id: ${Config.nativeAd}');

    if (Config.hideAds) return;

    nativeAd = NativeAd(
        adUnitId: Config.nativeAd,
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('====$NativeAd loaded.');
            _resetNativeAd();
            _nativeAdLoaded = true;
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeAd();
            log('======= n--$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  static void _resetNativeAd() {
    nativeAd?.dispose();
    nativeAd = null;
    _nativeAdLoaded = false;
  }

  static NativeAd? loadNativeAd({required NativeAdController adController}) {
    log('Native Ad Id: ${Config.nativeAd}');

    if (Config.hideAds) return null;

    if (_nativeAdLoaded && nativeAd != null) {
      adController.adLoaded.value = true;
      return nativeAd!;
    }

    return NativeAd(
        adUnitId: Config.nativeAd,
        nativeAdOptions: NativeAdOptions(
          mediaAspectRatio: MediaAspectRatio.any,
        ),
        listener: NativeAdListener(
          onAdLoaded: (ad) {
            log('$NativeAd loaded.');
            adController.adLoaded.value = true;
            _resetNativeAd();
            precacheNativeAd();
          },
          onAdFailedToLoad: (ad, error) {
            _resetNativeAd();
            log('$NativeAd failed to load: $error');
          },
        ),
        request: const AdRequest(),
        // Styling
        nativeTemplateStyle:
            NativeTemplateStyle(templateType: TemplateType.medium))
      ..load();
  }

  //*****************Rewarded Ad******************

  static void showRewardedAd({required VoidCallback onComplete}) {
    log('Rewarded Ad Id: ${Config.rewardedAd}');

    if (Config.hideAds) {
      onComplete();
      return;
    }

    MyDialogs.showProgress();

    RewardedAd.load(
      adUnitId: Config.rewardedAd,
      request: const AdRequest(),
      rewardedAdLoadCallback: RewardedAdLoadCallback(
        onAdLoaded: (ad) {
          Get.back();

          //reward listener
          ad.show(
              onUserEarnedReward: (AdWithoutView ad, RewardItem rewardItem) {
            onComplete();
          });
        },
        onAdFailedToLoad: (err) {
          Get.back();
          log('Failed to load an interstitial ad: ${err.message}');
          // onComplete();
        },
      ),
    );
  }

  static void loadAppOpenAd() {
    AppOpenAd.load(
        adUnitId: Config.appOpenAD, //Your ad Id from admob
        request: const AdRequest(),
        adLoadCallback: AppOpenAdLoadCallback(onAdLoaded: (ad) {
          myAppOpenAd = ad;
          myAppOpenAd!.show();
        }, onAdFailedToLoad: (error) {
          print("---------${Config.appOpenAD}-----------${error}");
        }),
        orientation: AppOpenAd.orientationPortrait);
  }
}

class NativeAdWidget extends StatefulWidget {
  const NativeAdWidget({super.key});

  @override
  _NativeAdWidgetState createState() => _NativeAdWidgetState();
}

class _NativeAdWidgetState extends State<NativeAdWidget> {
  NativeAd? _nativeAd;
  bool isAdLoaded = false;
  bool fbLoad = false;

  @override
  void initState() {
    super.initState();
    _loadNativeAd(); // Load the native ad when the widget is first initialized
  }

  @override
  void dispose() {
    _nativeAd?.dispose();
    super.dispose();
  }

  void _loadNativeAd() {
    _nativeAd = NativeAd(
      adUnitId: Config.nativeAd,
      factoryId:
          'adFactoryExample', // Use your custom ad factory ID if you have one.
      request: const AdRequest(),
      nativeAdOptions: NativeAdOptions(
        requestCustomMuteThisAd: true,
        adChoicesPlacement: AdChoicesPlacement.bottomLeftCorner,
      ),
      nativeTemplateStyle: NativeTemplateStyle(
        templateType: TemplateType.medium,
        mainBackgroundColor: Colors.white,
        cornerRadius: 15,
        callToActionTextStyle: NativeTemplateTextStyle(
            backgroundColor: white,
            textColor: Colors.white,
            style: NativeTemplateFontStyle.normal,
            size: 14),
      ),
      listener: NativeAdListener(
        onAdFailedToLoad: (ad, error) {
          setState(() {
            fbLoad = true;
            isAdLoaded = false;
          });
          print("------- _loadNativeAd -------> $error");
        },
        onAdLoaded: (Ad ad) {
          setState(() {
            isAdLoaded = true;
          });
        },
      ),
    );
    _nativeAd!.load();
  }

  Widget faceBoodNativeAd() {
    return FacebookNativeAd(
      placementId: Config.fbNative,
      adType: NativeAdType.NATIVE_AD_VERTICAL,
      width: double.infinity,
      height: 250,
      backgroundColor: white,
      titleColor: Colors.black,
      descriptionColor: Colors.black,
      buttonColor: Colors.white,
      buttonTitleColor: Colors.black,
      buttonBorderColor: Colors.black,
      listener: (result, value) {
        print("Native Ad: $result --> $value");
        if (result == NativeAdResult.LOADED) {
          setState(() {
            fbLoad = true;
          });
        } else if (result == NativeAdResult.ERROR) {
          setState(() {
            isAdLoaded = true;
          });
        }
      },
      keepExpandedWhileLoading: true,
      expandAnimationDuraion: 1000,
    );
  }

  @override
  Widget build(BuildContext context) {
    return isAdLoaded
        ? SizedBox(height: 200, child: AdWidget(ad: _nativeAd!))
        : fbLoad
            ? faceBoodNativeAd()
            : const SizedBox();
  }
}
