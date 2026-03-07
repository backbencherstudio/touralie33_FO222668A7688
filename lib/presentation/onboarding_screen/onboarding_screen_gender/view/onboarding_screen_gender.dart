import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class OnboardingScreenGender extends ConsumerStatefulWidget {
  const OnboardingScreenGender({super.key});

  @override
  ConsumerState<OnboardingScreenGender> createState() =>
      _OnboardingScreenGenderState();
}

class _OnboardingScreenGenderState
    extends ConsumerState<OnboardingScreenGender> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary1,
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: EdgeInsets.all(8.r),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 80.h),
                Image.asset(ImageManager.birthday, width: 108.w, height: 108.h),
                SizedBox(height: 16.h),
                Text(
                  "What is your Gender",
                  style: getMedium500Style16(
                    color: ColorManager.textPrimary,
                  ).copyWith(fontSize: 16.sp, fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 40.h),
               Container(
                height: 120.h,
                width: 130.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16.r),
                  color: ColorManager.backgroundColorgreen,
                ),
               )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
