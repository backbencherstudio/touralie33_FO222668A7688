import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
          onTap: () {
          
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                ImageManager.notification,
                height: 28.h,
                width: 28.w,
                fit: BoxFit.contain,
              ),
              Positioned(
                top: 0,
                right: 2.w,
                child: Container(
                  height: 10.h,
                  width: 10.w,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5.w), 
                  ),
                ),
              )
            ],
          ),
        );
  }
}