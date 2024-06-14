import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_call/common/colors.dart';
import 'package:video_call/web/web_con.dart';

import '../common/msg.dart';

class PhotosAddScreen extends StatefulWidget {
  const PhotosAddScreen({super.key});

  @override
  State<PhotosAddScreen> createState() => _PhotosAddScreenState();
}

class _PhotosAddScreenState extends State<PhotosAddScreen> {
  TextEditingController imagelink = TextEditingController();
  TextEditingController title = TextEditingController();
  TextEditingController desc = TextEditingController();
  TextEditingController height = TextEditingController();
  TextEditingController weight = TextEditingController();
  TextEditingController profesion = TextEditingController();
  TextEditingController dob = TextEditingController();

  final _form = GlobalKey<FormState>();
  WebController webController = Get.put(WebController());
  final ImagePicker picker = ImagePicker();
  Uint8List? _front;

  Future<Uint8List?> takePhoto(ImageSource source) async {
    final pickedFile = await picker.pickVideo(source: source, maxDuration: const Duration(minutes: 5));
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
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: Image.memory(_front!, fit: BoxFit.cover))
                        : Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.image,
                                  size: 40, color: greenColor.withOpacity(0.5)),
                              const SizedBox(height: 8),
                              CustomText(
                                text: "Select Image",
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
                TextFormField(
                  controller: title,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Name';
                    }
                    return null;
                  },
                  cursorHeight:
                      MediaQuery.of(context).size.width > 400 ? 23.h : 23,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.urbanist(
                    color: greenColor,
                    fontWeight: FontWeight.w600,
                    fontSize:
                        MediaQuery.of(context).size.width > 400 ? 5.sp : 15.sp,
                  ),
                  decoration:
                      decoration(label: "Name", hint: "Enter Image Name"),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: desc,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Description';
                    }
                    return null;
                  },
                  textAlign: TextAlign.start,
                  maxLines: 2,
                  cursorHeight:
                      MediaQuery.of(context).size.width > 400 ? 23.h : 23,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.urbanist(
                    color: black,
                    fontWeight: FontWeight.w600,
                    fontSize:
                        MediaQuery.of(context).size.width > 400 ? 5.sp : 15.sp,
                  ),
                  decoration: decoration(
                      label: "Description", hint: "Enter Description"),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: dob,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter DOB';
                    }
                    return null;
                  },
                  textAlign: TextAlign.start,
                  cursorHeight:
                      MediaQuery.of(context).size.width > 400 ? 23.h : 23,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.urbanist(
                    color: black,
                    fontWeight: FontWeight.w600,
                    fontSize:
                        MediaQuery.of(context).size.width > 400 ? 5.sp : 15.sp,
                  ),
                  decoration: decoration(label: "DOB", hint: "Enter DOB"),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: profesion,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter Profesion';
                    }
                    return null;
                  },
                  cursorHeight:
                      MediaQuery.of(context).size.width > 400 ? 23.h : 23,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.urbanist(
                    color: greenColor,
                    fontWeight: FontWeight.w600,
                    fontSize:
                        MediaQuery.of(context).size.width > 400 ? 5.sp : 15.sp,
                  ),
                  decoration:
                      decoration(label: "Profesion", hint: "Enter Profesion"),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: height,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter height';
                    }
                    return null;
                  },
                  cursorHeight:
                      MediaQuery.of(context).size.width > 400 ? 23.h : 23,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.urbanist(
                    color: greenColor,
                    fontWeight: FontWeight.w600,
                    fontSize:
                        MediaQuery.of(context).size.width > 400 ? 5.sp : 15.sp,
                  ),
                  decoration:
                      decoration(label: "Height", hint: "Enter  height"),
                ),
                const SizedBox(height: 15),
                TextFormField(
                  controller: weight,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter weight';
                    }
                    return null;
                  },
                  cursorHeight:
                      MediaQuery.of(context).size.width > 400 ? 23.h : 23,
                  keyboardType: TextInputType.text,
                  style: GoogleFonts.urbanist(
                    color: greenColor,
                    fontWeight: FontWeight.w600,
                    fontSize:
                        MediaQuery.of(context).size.width > 400 ? 5.sp : 15.sp,
                  ),
                  decoration: decoration(label: "Weight", hint: "Enter weight"),
                ),
                const SizedBox(height: 30),
                Obx(() {
                  return ElevatedButton(
                    onPressed: () async {
                      if (webController.isLoad.value == false) {
                        if (_form.currentState!.validate()) {
                          if (_front != null) {
                            // String image = await uploadImage(_front!);
                            // print("----------${image}");
                            webController.addUser(
                                name: title.text,
                                dob: dob.text,
                                height: height.text,
                                profesion: profesion.text,
                                weight: weight.text,
                                desc: desc.text,
                                image: _front!);
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

  decoration({required String label, required String hint}) {
    return InputDecoration(
      alignLabelWithHint: true,
      labelText: label,
      hintText: hint,
      hintStyle: GoogleFonts.urbanist(
        color: black,
        fontWeight: FontWeight.w600,
        fontSize: MediaQuery.of(context).size.width > 400 ? 5.sp : 15.sp,
      ),
      labelStyle: GoogleFonts.urbanist(
        color: black,
        fontWeight: FontWeight.w400,
        fontSize: MediaQuery.of(context).size.width > 400 ? 5.sp : 15.sp,
      ),
      border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: greenColor.withOpacity(0.3))),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: greenColor.withOpacity(0.3))),
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: greenColor.withOpacity(0.3))),
      errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: greenColor.withOpacity(0.3))),
    );
  }
}
