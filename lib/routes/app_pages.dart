import 'package:get/get.dart';
import 'package:video_call/screen/login/login_screen.dart';
import 'package:video_call/screen/user_screen/user_screen.dart';
import 'package:video_call/screen/profile/vip_screen.dart';

import '../screen/chat_screen/show_chat.dart';
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

  static final routes = [
    GetPage(name: _Paths.homeScreen, page: () => const HomeScreen()),
    GetPage(name: _Paths.showchat, page: () => const ShowChatScreen()),
    GetPage(
      name: _Paths.userScreen,
      page: () => const UserScreen(),
    ),
    GetPage(
      name: _Paths.login,
      page: () => const LoginScreen(),
    ),
    GetPage(name: _Paths.vipScreen, page: () => const VIPScreen()),
  ];
}
