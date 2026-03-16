import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';

class InstructionWidget extends StatelessWidget {
  const InstructionWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 12.w),
      backgroundColor: const Color.fromARGB(255, 83, 83, 83),
      child: Container(
        height: 365.h,
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.r),
          color: ColorManager.primary,
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 15.h),
              Text(
                "Instruction",
                style: getMedium500Style10(
                  color: ColorManager.textPrimary,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 15.h,),
              Text(
                "This Video is focused on back mobility that will help you to reduce stress of your back. Few essential tips before and in between this exercise must need to follow:",
                style: getMedium500Style12(color: const Color.fromARGB(255, 85, 85, 85),fontSize: 14.sp,fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 15.h,),
              Row(
                children: [
                  Image.asset(IconManager.checkIcon,fit: BoxFit.cover,height: 20.h,width: 20.w,),
                  SizedBox(width: 10.w,),
                  Text("Focus on the mobility of back and hand",style: getMedium500Style12(color: ColorManager.textPrimary,fontSize: 14.sp,fontWeight: FontWeight.w400),)
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                children: [
                  Image.asset(IconManager.checkIcon,fit: BoxFit.cover,height: 20.h,width: 20.w,),
                  SizedBox(width: 10.w,),
                  Text("Before all, start warming up for 10 min",style: getMedium500Style12(color: ColorManager.textPrimary,fontSize: 14.sp,fontWeight: FontWeight.w400),)
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                children: [
                  Image.asset(IconManager.checkIcon,fit: BoxFit.cover,height: 20.h,width: 20.w,),
                  SizedBox(width: 10.w,),
                  Text("Take nap in between each steps for 1 min",style: getMedium500Style12(color: ColorManager.textPrimary,fontSize: 14.sp,fontWeight: FontWeight.w400),)
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                children: [
                  Image.asset(IconManager.checkIcon,fit: BoxFit.cover,height: 20.h,width: 20.w,),
                  SizedBox(width: 10.w,),
                  Text("Don’t stretch without warm up",style: getMedium500Style12(color: ColorManager.textPrimary,fontSize: 14.sp,fontWeight: FontWeight.w400),)
                ],
              ),
              SizedBox(height: 8.h,),
              Row(
                children: [
                  Image.asset(IconManager.checkIcon,fit: BoxFit.cover,height: 20.h,width: 20.w,),
                  SizedBox(width: 10.w,),
                  Text("Take nap in between each steps for 1 min",style: getMedium500Style12(color: ColorManager.textPrimary,fontSize: 14.sp,fontWeight: FontWeight.w400),)
                ],
              ),
              SizedBox(height: 16.h,),
              Customebutton(
                onTap: () {
                 Navigator.pushReplacementNamed(context, RoutesName.prescibedDetailsScreen);
                },
                text: "I'm Ready — Begin",
              )
              
            
            ],
          ),
        ),
      ),
    );
  }
}
