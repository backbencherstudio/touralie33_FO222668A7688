import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customTextField.dart';

class SigninScreen extends StatelessWidget {
  const SigninScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
  
      body: Container(
        width: double.infinity, 
        height: double.infinity,
        decoration: BoxDecoration(
       
          gradient: LinearGradient(
            begin: Alignment.topCenter, 
            end: Alignment.bottomCenter, 
            colors: [
              ColorManager.primary, 
              ColorManager.primarygrey, 
           
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w), 
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            children: [
              Text(
                "Welcome Back",
                style: getMedium500Style22(
                  color: ColorManager.textPrimary,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.h), 
              Text(
                "Login to your account below",
                style: getMedium500Style14(color: ColorManager.subtextColor,fontSize: 14.sp,fontWeight: FontWeight.w400),
              ),
              SizedBox(height: 16.h,),
              Container(
                height: 306.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.r),
                  color: Colors.white
                ),
                child: Padding(
                  padding:  EdgeInsets.all(16.r),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email Address",style: getMedium500Style14(color: ColorManager.textPrimary,fontSize: 14.sp,fontWeight: FontWeight.w400),),
                      SizedBox(height: 8.h,),
                      CustomTextField(
                        hintText: "alexa.mate@example.com",
                        
                      ),
                    ],
                  ),
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}