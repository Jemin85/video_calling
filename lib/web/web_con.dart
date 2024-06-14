import 'dart:math';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:video_call/common/msg.dart';

class WebController extends GetxController {
  var isLoad = false.obs;

  addUser(
      {required String name,
      required String desc,
      required String dob,
      required String height,
      required String weight,
      required String profesion,
      required Uint8List image}) async {
    isLoad(true);
    String p1 = await uploadImage(image);
    final collection = FirebaseFirestore.instance.collection("all_user");
    collection.add({
      "name": name,
      "description": desc,
      "photo": p1,
      "dob": dob,
      "height": height,
      "weight": weight,
      "profesion": profesion
    });
    isLoad(false);
    MassageBox.showMag("Image Uploaded Successfully");
    Get.back();
  }

  addReels({required Uint8List image}) async {
    isLoad(true);
    String p1 = await uploadVideo(image);
    final collection = FirebaseFirestore.instance.collection("all_reels");
    collection.add({"video": p1});
    isLoad(false);
    MassageBox.showMag("Video Uploaded Successfully");
    Get.back();
  }

  Future<String> uploadImage(Uint8List img) async {
    String image = "";
    final String name = RandomString.generateRandomHashKey(15);
    // final fileName = img;
    try {
      final ref = FirebaseStorage.instance.ref('category').child(name);
      UploadTask uploadTask = ref.putData(
        img,
        SettableMetadata(contentType: 'image/png'),
      );
      TaskSnapshot snapshot = await uploadTask;
      image = await snapshot.ref.getDownloadURL();
    } catch (e) {
      debugPrint('--------$e');
    }
    return image;
  }

  Future<String> uploadVideo(Uint8List img) async {
    String image = "";
    final String name = RandomString.generateRandomHashKey(15);
    // final fileName = img;
    try {
      final ref = FirebaseStorage.instance.ref('reels').child(name);
      UploadTask uploadTask = ref.putData(
        img,
        SettableMetadata(contentType: 'video/mp4'),
      );
      TaskSnapshot snapshot = await uploadTask;
      image = await snapshot.ref.getDownloadURL();
    } catch (e) {
      debugPrint('--------$e');
    }
    return image;
  }
}

class RandomString {
  static String generateRandomHashKey(int length) {
    // final random = Random();
    // final buffer = StringBuffer();

    // for (int i = 0; i < 16; i++) {
    //   buffer.write(random.nextInt(10));
    // }
    // return buffer.toString();

    const chars =
        'AaBbCcDdEeFfGgHhIiJjKkLlMmNnOoPpQqRrSsTtUuVvWwXxYyZz1234567890';
    Random rnd = Random();
    String getRandomString() => String.fromCharCodes(Iterable.generate(
        length, (_) => chars.codeUnitAt(rnd.nextInt(chars.length))));

    return getRandomString();
  }
}
