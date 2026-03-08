import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class CustomeAppBarHome extends StatelessWidget {
  final VoidCallback? onProfileTap;

  const CustomeAppBarHome({super.key, this.onProfileTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
        Row(
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
             GestureDetector(
              onTap: () {
                onProfileTap?.call();
              },
              child: Container(
                height: 42.h,
                width: 42.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: AssetImage(ImageManager.profilePic),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  "Jannatul",
                  style: getMedium500Style18(
                    color: ColorManager.subtextColor,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  "jannatul@gmail.com",
                  style: getMedium500Style10(
                    color: const Color(0xFFA2A1A1), 
                    fontSize: 12.sp,
                  ),
                ),
              ],
            )
          ],
        ),

        GestureDetector(
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
        )
      ],
    );
  }
}
