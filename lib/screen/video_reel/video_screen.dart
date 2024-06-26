import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        Uri.parse(Config.hideAds
            ? "https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4"
            : '${widget.data["video"]}'),
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
      child: !_controller.value.isInitialized
          ? const CircularProgressIndicator(color: white)
          : Column(
              children: [
                Flexible(
                  child: GestureDetector(
                    onTap: () {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                      setState(() {});
                    },
                    child: Container(
                      color: Colors.transparent,
                      child: Stack(
                        alignment: Alignment.bottomCenter,
                        fit: StackFit.expand,
                        children: [
                          ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                colors: [
                                  Colors.black,
                                  Colors.transparent,
                                ],
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                stops: [0.7, 0.98],
                              ).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            child: LayoutBuilder(
                              builder: (context, constraints) => AspectRatio(
                                aspectRatio: _controller.value.aspectRatio,
                                // _controller.value.aspectRatio,
                                child: VideoPlayer(_controller),
                              ),
                            ),
                          ),
                          if (!_controller.value.isPlaying)
                            Positioned(
                              top: 0,
                              bottom: 0,
                              left: 150,
                              right: 150,
                              child: CircleAvatar(
                                radius: 30,
                                backgroundColor: white.withOpacity(0.2),
                                child: const Icon(Icons.play_arrow,
                                    color: white, size: 50),
                              ),
                            ),
                          Positioned(
                            bottom: 15,
                            left: 0,
                            right: 0,
                            child: Container(
                                padding: const EdgeInsets.all(15),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          CustomText(
                                            text: "Bafs dsffs",
                                            color: white,
                                            fontSize: 20.sp,
                                          ),
                                          CustomText(
                                            text: "Bafs dsffs",
                                            color: white.withOpacity(0.5),
                                            fontSize: 12.sp,
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: (){},
                                      child: Icon(
                                        Icons.send,
                                        color: white.withOpacity(0.9),
                                        size: 30,
                                      ),
                                    ),
                                  ],
                                )

                                ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                VideoProgressIndicator(_controller,
                    colors: VideoProgressColors(
                        backgroundColor: Colors.white,
                        playedColor: white.withOpacity(0.5),
                        bufferedColor: black.withOpacity(0.5)),
                    allowScrubbing: true)
              ],
            ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
