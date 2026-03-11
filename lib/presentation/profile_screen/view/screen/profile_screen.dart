import 'package:buttons_tabbar/buttons_tabbar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/view/screen/all_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/view/screen/completed_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/view/screen/progess_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/view/widet/custome_widget_profile.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customeAppBarHome/custome_app_bar_home.dart';

class ProfileScreen extends StatelessWidget {
  final VoidCallback? onOpenDrawer;
  const ProfileScreen({super.key, this.onOpenDrawer});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar:PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: CustomeAppBarHome(
              onProfileTap: onOpenDrawer,
            ),
          ),
        ),
      ),
      body: DefaultTabController(
      length: 3,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 4.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
        
             Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16.r),
              color: ColorManager.whiteColor
            ),
            child: Padding(
              padding:  EdgeInsets.symmetric(horizontal: 12.w,vertical: 6.h),
              child: Row(
                children: [
                  Expanded(child: CustomeWidgetProfile(
                    title: "Age",
                    value: "29 Year",
                  )),
                  SizedBox(width: 8.w,),
                  Expanded(child: CustomeWidgetProfile(
                    title: "Height",
                    value: "170 cm",
                  )),   SizedBox(width: 8.w,),
                  Expanded(child: CustomeWidgetProfile(
                    title: "Weight",
                    value: "52 Kg",
                  ))
                ],
              ),
            ),
          ),
          
        ],
      ),
            
            SizedBox(height: 15.h),
      
           
      Center(
  child: ButtonsTabBar(
    height: 35.h,
  
    contentPadding: EdgeInsets.symmetric(horizontal: 20.w),
    backgroundColor: ColorManager.backgroundColorgreen, 
    unselectedBackgroundColor: const Color(0XFFEDEFEB),

    labelStyle: TextStyle(
      color: ColorManager.blackColor,
      fontWeight: FontWeight.bold,
      fontSize: 14.sp,
    ),

    unselectedLabelStyle: TextStyle(
      color: Colors.grey, 
      fontWeight: FontWeight.bold,
      fontSize: 14.sp,
    ),

    radius: 100,
    tabs: [

      Tab(text: "All"),
      Tab(text: "Progress"),
      Tab(text: "Completed"),
    ],
  ),
),
            SizedBox(height: 8.h),
      
          
            Expanded(
              child: TabBarView(
                children: [
             
                    AllScreen(),
                 ProgessScreen(),
                  CompletedScreen(),
                ],
              ),
            ),
          ],
        ),
      ),
            ));
  }
        
}