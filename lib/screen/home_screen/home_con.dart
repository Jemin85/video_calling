import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currantIndex = 0.obs;

  changeIndex(int index) {
    currantIndex.value = index;
  }
}