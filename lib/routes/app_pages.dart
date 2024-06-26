import 'package:get/get.dart';
import 'package:video_call/screen/diamond/diamond_screen.dart';
import 'package:video_call/screen/home_screen/main_home.dart';
import 'package:video_call/screen/introduction/splash_screen.dart';
import 'package:video_call/screen/login/login_screen.dart';
import 'package:video_call/screen/profile/presents_screen.dart';
import 'package:video_call/screen/profile/profile_screen.dart';
import 'package:video_call/screen/profile/tearm_condition.dart';
import 'package:video_call/screen/user_screen/user_screen.dart';
import 'package:video_call/screen/profile/vip_screen.dart';
import 'package:video_call/screen/video_reel/video_screen.dart';
import 'package:video_call/web/photos_add.dart';
import 'package:video_call/web/reels_upload.dart';
import 'package:video_call/web/web_home.dart';

import '../screen/chat_screen/show_chat.dart';
import '../screen/chat_screen/user_show_scree.dart';
import '../screen/home_screen/home_screen.dart';
import '../screen/visitor/visitor_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const indroduction = Routes.indroduction;
  static const homeScreen = Routes.homeScreen;
  static const showchat = Routes.showchat;
  static const userScreen = Routes.userScreen;
  static const login = Routes.login;
  static const vipScreen = Routes.vipScreen;
  static const diamond = Routes.diamond;
  static const videoReels = Routes.videoReels;
  static const userChat = Routes.userChat;
  static const mainHome = Routes.mainHome;
  static const profile = Routes.profile;
  static const visitor = Routes.visitor;
  static const splash = Routes.splash;
  static const myPresents = Routes.myPresents;
  static const tearmCondition = Routes.tearmCondition;

  static const webHome = Routes.webHome;
  static const photoAdd = Routes.photoAdd;
  static const uploadReels = Routes.uploadReels;

  static final routes = [
    GetPage(name: _Paths.homeScreen, page: () => const HomeScreen()),
    GetPage(name: _Paths.showchat, page: () => const ShowChatScreen()),
    GetPage(name: _Paths.userScreen, page: () => const UserScreen()),
    GetPage(name: _Paths.login, page: () => const LoginScreen()),
    GetPage(name: _Paths.vipScreen, page: () => const VIPScreen()),
    GetPage(name: _Paths.diamond, page: () => const DiamondScreen()),
    GetPage(name: _Paths.videoReels, page: () => const VideoReelsScreen()),
    GetPage(name: _Paths.userChat, page: () => const UserShowScreen()),
    GetPage(name: _Paths.profile, page: () => const ProfileScreen()),
    GetPage(name: _Paths.mainHome, page: () => const MainHomeScreen()),
    GetPage(name: _Paths.visitor, page: () => const VisitorScreem()),
    GetPage(name: _Paths.splash, page: () => const SplashScreen()),
    GetPage(name: _Paths.webHome, page: () => const WebHomeScreen()),
    GetPage(name: _Paths.myPresents, page: () => const MyPresentsScreen()),
    GetPage(
      name: _Paths.photoAdd,
      page: () => const PhotosAddScreen(),
    ),
    GetPage(
      name: _Paths.tearmCondition,
      page: () => const TearmAndConditions(),
    ),
    GetPage(
      name: _Paths.uploadReels,
      page: () => const ReelsUploadScreen(),
    )
  ];
}
