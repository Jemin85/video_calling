import 'package:cloud_firestore/cloud_firestore.dart';
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

  Stream<QuerySnapshot<Object?>> findUserChatData(
      {required String name})  {
    final collection = FirebaseFirestore.instance.collection("chat");
    Query query = collection.where("name", isEqualTo: name);
    return query.snapshots();
  }

  @override
  void onInit() {
    findUserData();
    super.onInit();
  }
}
