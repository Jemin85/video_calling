import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  RxInt currantIndex = 0.obs;
  RxList photos = [].obs;

  changeIndex(int index) {
    currantIndex.value = index;
  }

  bool userLogin() {
    return FirebaseAuth.instance.currentUser != null;
  }

  getPhotos()async{
    final collection = FirebaseFirestore.instance.collection("all_user");
    var listData = await collection.get();
    photos.value = listData.docs;
  }

  @override
  void onInit() {
    getPhotos();
    super.onInit();
  }

}
