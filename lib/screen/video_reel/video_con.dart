import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class VideoController extends GetxController {
  RxList videoReesl = [].obs;

  getVideoReels()async{
     final collection = FirebaseFirestore.instance.collection("all_reels");
    var data = await collection.get();
    if (data.docs.isNotEmpty) {
      videoReesl.value = data.docs;
    }
  }

  @override
  void onInit() {
    getVideoReels();
    super.onInit();
  }

}