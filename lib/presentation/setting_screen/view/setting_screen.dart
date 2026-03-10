import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';

class SettingScreen extends StatelessWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(
              text: "Settings",
              ontap: () {
                Navigator.pushReplacementNamed(
                  context,
                  RoutesName.parentScreen,
                );
              },
            ),
          ),
        ),
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorManager.primary, ColorManager.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              Container(
                height: 394.h,
                width: 343.w,
                decoration: BoxDecoration(
                  color: ColorManager.playlistBox,
                  border: Border.all(
                    color: ColorManager.borderColor,
                    width: 1.5.w,
                  ),
                  borderRadius: BorderRadius.circular(12.r),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Info",
                        style: getMedium500Style10(
                          color: ColorManager.textPrimary,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        "UserName",
                        style: getMedium500Style10(
                          color: ColorManager.textPrimary,
                          fontSize: 14.sp,
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'enter your username',
                          hintStyle: TextStyle(color: Colors.grey),

                          suffixIconConstraints: BoxConstraints(
                            minHeight: 16.h,
                            minWidth: 16.w,
                          ),

                          suffixIcon: Image.asset(
                            IconManager.edit,
                            height: 18.h,
                            width: 18.w,
                          ),

                          enabledBorder: UnderlineInputBorder(
                            
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.hintTextColor),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
