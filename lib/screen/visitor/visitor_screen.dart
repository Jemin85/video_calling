import 'package:flutter/material.dart';
import 'package:video_call/common/colors.dart';

class VisitorScreem extends StatefulWidget {
  const VisitorScreem({super.key});

  @override
  State<VisitorScreem> createState() => _VisitorScreemState();
}

class _VisitorScreemState extends State<VisitorScreem> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: yellowOpacity,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: yellowOpacity,
        surfaceTintColor: Colors.transparent,
      ),
      body: Container(),
    );
  }
}