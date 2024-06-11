import 'package:get/get.dart';
import 'package:video_call/screen/diamond/diamond_screen.dart';
import 'package:video_call/screen/home_screen/main_home.dart';
import 'package:video_call/screen/login/login_screen.dart';
import 'package:video_call/screen/profile/profile_screen.dart';
import 'package:video_call/screen/user_screen/user_screen.dart';
import 'package:video_call/screen/profile/vip_screen.dart';
import 'package:video_call/screen/video_reel/video_screen.dart';

import '../screen/chat_screen/show_chat.dart';
import '../screen/chat_screen/user_show_scree.dart';
import '../screen/home_screen/home_screen.dart';

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
    GetPage(name: _Paths.mainHome, page: () => const MainHomeScreen())
  ];
}
