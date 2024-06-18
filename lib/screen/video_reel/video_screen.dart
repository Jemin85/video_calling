import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_call/common/colors.dart';
import 'package:video_call/screen/video_reel/video_con.dart';
import 'package:video_player/video_player.dart';

import '../../Adhelper/ad_config.dart';
import '../../Adhelper/ad_helper.dart';

class VideoReelsScreen extends StatefulWidget {
  const VideoReelsScreen({super.key});

  @override
  State<VideoReelsScreen> createState() => _VideoReelsScreenState();
}

class _VideoReelsScreenState extends State<VideoReelsScreen>
    with WidgetsBindingObserver {
  VideoController videoController = Get.find();
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
          return Scaffold(
            backgroundColor: black,
            body: PageView.builder(
              itemCount: videoController.videoReesl.length,
              scrollDirection: Axis.vertical,
              itemBuilder: (context, index) {
                var object = videoController.videoReesl[index].data() as Map;
                print("-----------${videoController.videoReesl.length}");
                return VideoShowScreen(data: object);
              },
            ),
          );
        },
      ),
    );
  }
}

class VideoShowScreen extends StatefulWidget {
  final Map data;
  const VideoShowScreen({super.key, required this.data});

  @override
  State<VideoShowScreen> createState() => _VideoShowScreenState();
}

class _VideoShowScreenState extends State<VideoShowScreen> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    _controller = VideoPlayerController.networkUrl(
        Uri.parse('${widget.data["video"]}'),
        videoPlayerOptions: VideoPlayerOptions(allowBackgroundPlayback: false))
      ..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.

        setState(() {});
      })
      ..play()
      ..setLooping(true);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LayoutBuilder(
          builder: (context, constraints) => _controller.value.isInitialized
              ? AspectRatio(
                  aspectRatio: constraints.maxWidth / constraints.maxHeight,
                  // _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : const CircularProgressIndicator(color: white),
        ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
