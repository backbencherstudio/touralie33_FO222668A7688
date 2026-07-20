import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class ImageDetailsScreen extends StatefulWidget {
  const ImageDetailsScreen({super.key});

  @override
  State<ImageDetailsScreen> createState() => _ImageDetailsScreenState();
}

class _ImageDetailsScreenState extends State<ImageDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Image Details",
          style: getMedium500Style16(color: Colors.black, fontSize: 18.sp),
        ),
      ),
    );
  }
}
