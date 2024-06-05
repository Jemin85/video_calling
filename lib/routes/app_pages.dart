import 'package:get/get.dart';

import '../screen/chat_screen/show_chat.dart';
import '../screen/home_screen/home_screen.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const indroduction = Routes.indroduction;
  static const homeScreen = Routes.homeScreen;
  static const showchat = Routes.showchat;

  static final routes = [
    GetPage(name: _Paths.homeScreen, page: () => const HomeScreen()),
    GetPage(name: _Paths.showchat, page: () => const ShowChatScreen()),
  ];
}
