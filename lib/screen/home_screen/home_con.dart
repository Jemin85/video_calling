import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';

class HomeController extends GetxController {
  RxInt currantIndex = 0.obs;
  RxBool loading = false.obs;
  RxList photos = [].obs;
  RxBool userVipPurchased = false.obs;

  changeIndex(int index) {
    currantIndex.value = index;
  }

  bool userLogin() {
    return FirebaseAuth.instance.currentUser != null;
  }

  getPurchaseData() async {
    final collection = FirebaseFirestore.instance.collection("tbl_user");
    Query query = collection.where("email",
        isEqualTo: FirebaseAuth.instance.currentUser!.email);
    var data = await query.get();
    userVipPurchased.value = data.docs[0]["is_purhcasd"];
  }

  getPhotos() async {
    final collection = FirebaseFirestore.instance.collection("all_user");
    var listData = await collection.get();
    photos.value = listData.docs;
  }

  @override
  void onInit() {
    getPhotos();
    getPurchaseData();
    super.onInit();
  }
}
