import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class ChatController extends GetxController {
  RxList getChatData = [].obs;
  RxList chatData = [].obs;

  findUserData() async {
    final collection = FirebaseFirestore.instance.collection("chat");
    var data = await collection.get();
    if (data.docs.isNotEmpty) {
      getChatData.value = data.docs;
    }
  }

  Stream<QuerySnapshot<Object?>> findUserChatData({required String name}) {
    final collection = FirebaseFirestore.instance.collection("chat");
    Query query = collection.where("name", isEqualTo: name);

    return query.snapshots();
  }

  @override
  void onInit() {
    findUserData();
    super.onInit();
  }

  addData({required String msg}) async {
    var massege = {
      "email": FirebaseAuth.instance.currentUser!.email,
      "msg": msg,
      'timestamp': DateTime.now().millisecondsSinceEpoch
    };
    final collection = FirebaseFirestore.instance.collection("chat");
    Query query = collection.where("email",
        isEqualTo: FirebaseAuth.instance.currentUser!.email);
    var data = await query.get();
    collection.doc(data.docs.first.id).update({
      "massage": FieldValue.arrayUnion([massege])
    });
  }

  noChatFound({required String name, required String profile}) {
    var massege = [
      {
        "email": name,
        "msg": "Hiii ",
        'timestamp': DateTime.now().millisecondsSinceEpoch
      },
      {
        "email": name,
        "msg": "How are you?",
        'timestamp': DateTime.now().millisecondsSinceEpoch
      },
    ];
    final collection = FirebaseFirestore.instance.collection("chat");
    var addData = {
      "name": name,
      "email": FirebaseAuth.instance.currentUser!.email,
      "profile": "$profile",
      "massage": massege,
    };
    collection.add(addData);
  }

  deleteUserChat(String id) {
    FirebaseFirestore.instance.collection("chat").doc(id).delete();
    findUserData();
  }
}
