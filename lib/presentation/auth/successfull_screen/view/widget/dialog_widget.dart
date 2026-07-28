import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';

class DialogWidget extends StatelessWidget {
  final String title;
  final String subtitle;
  final String description;
  final String buttonText;
  final VoidCallback? onTap;

  const DialogWidget({
    super.key,
    this.title = "Password Update",
    this.subtitle = "Successfully",
    this.description = "Your password has been updated successfully",
    this.buttonText = "Back to Login",
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Dialog(
       insetPadding: EdgeInsets.symmetric(horizontal: 12.w), 
       backgroundColor: Colors.transparent,
      child: Container(
        height: 446.h,
        width: 363.w,
        decoration: BoxDecoration(
          color: ColorManager.primary,
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding:  EdgeInsets.all(8.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageManager.success,fit: BoxFit.cover,width: 240.w,height: 240.h,),
              Text(title,style: getMedium500Style22(color: ColorManager.subtextColor,fontSize: 24.sp)),
              Text(subtitle,style: getMedium500Style22(color: ColorManager.subtextColor,fontSize: 24.sp),),
              Text(description,
              textAlign: TextAlign.center,
              style: getMedium500Style16(color: const Color.fromARGB(255, 149, 149, 149)),),
              SizedBox(height: 8.h,),
              Customebutton(
                text: buttonText,
                onTap: onTap ?? () {
                  Navigator.pushReplacementNamed(context, RoutesName.signInScreen);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}