import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';

const greenColor = Color(0xff89c5a9);
const yellowOpacity = Color(0xfff4f7ef);
const mendicolor = Color(0xffe7dc71);
const black = Color(0xff221f24);
const white = Color(0xfffffffd);

class CustomText extends StatelessWidget {
  final String text;
  final Color? color;
  final FontWeight? weight;
  final int? maxline;
  final double? fontSize;
  final TextAlign? align;
  final TextDecoration? decoration;
  const CustomText(
      {super.key,
      required this.text,
      this.color,
      this.weight,
      this.fontSize,
      this.align,
      this.maxline,
      this.decoration});

  @override
  Widget build(BuildContext context) {
    return Text(text,
        textAlign: align,
        maxLines: maxline,
        style: GoogleFonts.urbanist(
            decoration: decoration,
            color: color ?? black,
            fontWeight: weight ?? FontWeight.w400,
            fontSize: fontSize ?? 16.sp));
  }
}
