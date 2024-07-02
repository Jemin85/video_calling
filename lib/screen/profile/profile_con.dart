import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:video_call/common/msg.dart';
import 'package:video_call/routes/app_pages.dart';

class ProfileController extends GetxController {
  purchaseProduct({required String subId}) async {
    final collection = FirebaseFirestore.instance.collection("tbl_user");
    Query query = collection.where("email",
        isEqualTo: FirebaseAuth.instance.currentUser!.email);
    var data = await query.get();
    String id = data.docs[0].id;
    collection.doc(id).update({"is_purhcasd": true, "sucription_id": subId});
    Get.offAllNamed(AppPages.mainHome);
    MassageBox.showMag("Purchase SuccessFully");
  }
}
