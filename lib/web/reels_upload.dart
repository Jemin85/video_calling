import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_call/common/colors.dart';
import 'package:video_call/web/web_con.dart';

import '../common/msg.dart';

class ReelsUploadScreen extends StatefulWidget {
  const ReelsUploadScreen({super.key});

  @override
  State<ReelsUploadScreen> createState() => _ReelsUploadScreenState();
}

class _ReelsUploadScreenState extends State<ReelsUploadScreen> {
  final _form = GlobalKey<FormState>();
  WebController webController = Get.put(WebController());
  final ImagePicker picker = ImagePicker();
  Uint8List? _front;

  Future<Uint8List?> takePhoto(ImageSource source) async {
    final pickedFile = await picker.pickImage(source: source);
    if (pickedFile == null) {
      return null;
    } else {
      return await pickedFile.readAsBytes();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Container(
          padding: MediaQuery.of(context).size.width > 400
              ? EdgeInsets.only(
                  left: 125.w, top: 15.w, bottom: 30.w, right: 125.w)
              : const EdgeInsets.all(15),
          child: Form(
            key: _form,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                GestureDetector(
                  onTap: () async {
                    _front = await takePhoto(ImageSource.gallery);
                    setState(() {});
                  },
                  child: Container(
                    height: 150.h,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: greenColor.withOpacity(0.3))),
                    child: _front != null
                        ? CustomText(
                            text: "VideoPicked",
                            align: TextAlign.center,
                            weight: FontWeight.w600,
                            fontSize: 5.sp,
                            color: greenColor.withOpacity(0.5),
                          )
                        // ClipRRect(
                        //     borderRadius: BorderRadius.circular(10),
                        //     child: Image.memory(_front!, fit: BoxFit.cover))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image,
                                  size: 40, color: greenColor.withOpacity(0.5)),
                              const SizedBox(height: 8),
                              CustomText(
                                text: "Select Video",
                                align: TextAlign.center,
                                weight: FontWeight.w600,
                                fontSize: 5.sp,
                                color: greenColor.withOpacity(0.5),
                              )
                            ],
                          ),
                  ),
                ),
                const SizedBox(height: 15),
                const SizedBox(height: 30),
                Obx(() {
                  return ElevatedButton(
                    onPressed: () async {
                      if (webController.isLoad.value == false) {
                        if (_form.currentState!.validate()) {
                          if (_front != null) {
                            // String image = await uploadImage(_front!);
                            // print("----------${image}");
                            webController.addReels(image: _front!);
                          } else {
                            MassageBox.showMag("Select Image");
                          }
                        }
                      }
                    },
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(greenColor),
                        padding: MaterialStateProperty.all(
                            EdgeInsets.symmetric(vertical: 15.h))),
                    child: webController.isLoad.value
                        ? const CircularProgressIndicator()
                        : CustomText(
                            text: "Add Photo",
                            color: white,
                            fontSize: MediaQuery.of(context).size.width > 400
                                ? 5.sp
                                : 16.sp,
                            weight: FontWeight.w600,
                          ),
                  );
                })
              ],
            ),
          ),
        ),
      ),
    );
  }
}
