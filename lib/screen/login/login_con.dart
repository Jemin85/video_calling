import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../Adhelper/ad_helper.dart';
import '../../routes/app_pages.dart';

class LoginController extends GetxController {
  var isload = false.obs;

   Future<void> signInWithGoogle() async {
    isload(true);
    SharedPreferences pref = await SharedPreferences.getInstance();
    String token = await FirebaseMessaging.instance.getToken() ?? "";
    try {
      await GoogleSignIn().signOut();
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth!.accessToken,
        idToken: googleAuth.idToken,
      );
      FirebaseAuth.instance.signInWithCredential(credential);
      var collection = FirebaseFirestore.instance.collection('tbl_user');
      var data =
          await collection.where("email", isEqualTo: googleUser!.email).get();
      if (data.docs.isNotEmpty) {
        isload(false);
        for (var user in data.docs) {
          if (googleUser.email == user.data()["email"]) {
            user.reference.update({"token": token});
            pref.setString("name", user.data()["name"]);
            pref.setString("email", user.data()["email"]);
            pref.setString("profile", user.data()["profile"]);
            pref.setInt("clickCount", data.docs[0].data()["clickCount"] ?? 0);
            pref.setInt("lastClickTimestamp",
                data.docs[0].data()["lastClickTimestamp"] ?? 0);
          }
        }
        AdHelper.showInterstitialAd(onComplete: () {
        Get.toNamed(AppPages.homeScreen);
        });
        isload(false);
      } else {
        isload(false);
        collection.add({
          "name": googleUser.displayName ??
              "User${DateTime.now().millisecondsSinceEpoch.toStringAsFixed(5)}",
          "email": googleUser.email,
          'balance': "0",
          "profile": "${googleUser.photoUrl}",
          "pass": "",
          "clickCount": 0,
          "mobile": "",
          "token": token,
          "lastClickTimestamp": 0
        });
        pref.setString("name", googleUser.displayName ?? "User");
        pref.setString("email", googleUser.email);
        pref.setString("profile", "${googleUser.photoUrl}");
        Get.toNamed(AppPages.homeScreen);
        isload(false);
      }
    } on Exception catch (e) {
      isload(false);
      debugPrint('exception->$e');
    }
  }
}
