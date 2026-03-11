import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/notification_widget/notification_widget.dart';

class NotificationScreen1 extends StatelessWidget {
  const NotificationScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.symmetric(horizontal: 16.w),
      backgroundColor: Colors.transparent,
      child: Container(
 
        decoration: BoxDecoration(
          color: ColorManager.whiteColor, 
          borderRadius: BorderRadius.circular(12.r),
        ),
        padding: EdgeInsets.all(16.r), 
        child: Column(
          mainAxisSize: MainAxisSize.min, 
          children: [
            NotificationWidget(
              time: '15 minutes ago',
              title: "New Prescription Suggested",
              description: "You have prescription suggested. Please check it out! Adding more text to test auto-resize behavior.",
          color:  ColorManager.errorColor
            ),
       
            SizedBox(height: 16.h),
            NotificationWidget(
              time: '15 minutes ago',
              title: "New Prescription Suggested",
             
              description: "You have prescription suggested. Please check it out! Adding more text to test auto-resize behavior.",
            
             color:  ColorManager.errorColor
            ),
       
            SizedBox(height: 16.h),
            NotificationWidget(
              time: '15 minutes ago',
              title: "New Prescription Suggested",
              description: "You have prescription suggested. Please check it out! Adding more text to test auto-resize behavior.",
            ),
       
            SizedBox(height: 16.h),
           
          ],
        ),
      ),
    );
  }
}

class CustomButton {
}