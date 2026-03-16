import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/successfull_screen/view/widget/dialog_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/provider/file_image_picker_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/setting_screen/view/widget/height_setting_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/setting_screen/view/widget/setting_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/setting_screen/view/widget/successfully_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/setting_screen/view/widget/weight_setting_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';

class SettingScreen extends ConsumerWidget {
  const SettingScreen({super.key});

  @override
  Widget build(BuildContext context,WidgetRef ref) {
     final heightUnitIndex = ref.watch(heightUnitProvider);
     final weightUnitIndex = ref.watch(weightStateProvider);
     final pickerState = ref.watch(fileImagePickerProvider);
 
    final heightUnitText = heightUnitIndex == 0 ? "feet" : "cm";
    final weightUnitText = weightUnitIndex  == 0 ? "Kg" : "Lb";
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
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16.r),
          child: Column(
            children: [
              Container(
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
                          fontSize: 18.sp,
                        ),
                      ),
                      SizedBox(height: 15.h),
                      InkWell(
                        borderRadius: BorderRadius.circular(999),
                        onTap: () {
                          ref
                              .read(fileImagePickerProvider.notifier)
                              .pickSingleImage();
                        },
                        child: Stack(
                          clipBehavior: Clip.none,
                          children: [
                            Container(
                              width: 96.w,
                              height: 96.w,
                              decoration: BoxDecoration(
                                color: const Color(0xFFF1F3F0),
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: ColorManager.borderColor,
                                  width: 1.2.w,
                                ),
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: pickerState.singleImage != null
                                      ? FileImage(
                                          File(pickerState.singleImage!.path),
                                        )
                                      : const AssetImage(
                                          'assets/images/profile_pic.png',
                                        ) as ImageProvider,
                                ),
                              ),
                            ),
                            Positioned(
                              right: -2.w,
                              bottom: -2.h,
                              child: Container(
                                width: 30.w,
                                height: 30.w,
                                decoration: BoxDecoration(
                                  color: ColorManager.backgroundColorgreen,
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: ColorManager.whiteColor,
                                    width: 2.w,
                                  ),
                                ),
                                child: Center(
                                  child: Image.asset(
                                    IconManager.camera,
                                    width: 14.w,
                                    height: 14.w,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16.h),
             
                      Text(
                        "UserName",
                        style: getMedium500Style10(
                          color: ColorManager.textPrimary,
                          fontSize: 16.sp,
                        ),
                      ),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'enter your username',
                          hintStyle: TextStyle(color: Colors.grey, fontSize: 14.sp),
                          suffixIcon: Padding(
                            padding:  EdgeInsets.all(11.r),
                            child: Image.asset(
                              IconManager.edit,
                              height: 12.h,
                              width: 12.w,
                            ),
                          ),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade300),
                          ),
                          focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: ColorManager.hintTextColor),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.h),

               
                      Text(
                        "Gender",
                        style: getMedium500Style10(
                          color: ColorManager.textPrimary,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      const SettingWidgetGender(), 
                      SizedBox(height: 20.h),

                
                      Text(
                        "Weight",
                        style: getMedium500Style10(
                          color: ColorManager.textPrimary,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: ColorManager.borderColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.r),
                          child: Column(
                            children: [
                              const WeightSettingWidget(), 
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IntrinsicWidth(
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '52',
                                            hintStyle: const TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 5.w,),
                                      Text(
                                        weightUnitText ,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    IconManager.edit,
                                    height: 18.h,
                                    width: 18.w,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 15.h,),
                      Text(
                        "Height",
                        style: getMedium500Style10(
                          color: ColorManager.textPrimary,
                          fontSize: 16.sp,
                        ),
                      ),
                      SizedBox(height: 8.h),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12.r),
                          border: Border.all(color: ColorManager.borderColor),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(12.r),
                          child: Column(
                            children: [
                              const HeightSettingWidget(), 
                              SizedBox(height: 12.h),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      IntrinsicWidth(
                                        child: TextField(
                                          keyboardType: TextInputType.number,
                                          style: TextStyle(
                                            fontSize: 16.sp,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                          decoration: InputDecoration(
                                            hintText: '52',
                                            hintStyle: const TextStyle(color: Colors.grey),
                                            border: InputBorder.none,
                                            isDense: true,
                                            contentPadding: EdgeInsets.zero,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8.w,),
                                      Text(
                                        heightUnitText,
                                        style: TextStyle(
                                          fontSize: 14.sp,
                                          color: Colors.grey,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Image.asset(
                                    IconManager.edit,
                                    height: 18.h,
                                    width: 18.w,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                     
                      
                    ],
                  ),
                ),
              ),
               SizedBox(height: 20.h,),
              Customebutton(
                onTap: () {
                   showDialog(
  context: context,
  barrierDismissible: true, 
  
  builder: (BuildContext context) {
    return SuccessfullyWidget();
  },
);
                },
                        text: "Save",
                      )
            ],
          ),
        ),
      ),
    );
  }
}
