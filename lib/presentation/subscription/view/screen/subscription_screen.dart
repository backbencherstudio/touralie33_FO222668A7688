import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/subscription/view/widget/plan_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';

class SubscriptionScreen extends StatelessWidget {
  const SubscriptionScreen({super.key});

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
              text: "Membership!",
              ontap: () {
                Navigator.pushReplacementNamed(context, RoutesName.parentScreen);
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
          colors: [ColorManager.primary, Colors.white],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        )),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start, // Fixed typo here
            children: [
              SizedBox(height: 10.h),
              Center(
                  child: Image.asset(
                IconManager.subscriptionIcon,
                fit: BoxFit.cover,
                height: 40.h,
                width: 40.w,
              )),
              SizedBox(height: 10.h),
              Center(
                child: Text(
                  "Unlock more benefits",
                  style: getMedium500Style12(
                      color: ColorManager.textPrimary,
                      fontSize: 24.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              Center(
                child: Text(
                  "With a memberships!", // Fixed typo
                  style: getMedium500Style12(
                      color: ColorManager.textPrimary,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600),
                ),
              ),
              SizedBox(height: 15.h),

        
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  children: [
                   
                    PlanWidget(
                      title: "Platinum",
                      price: "\$199.00/week",
                      description: "The complete program for post-operative patients 8 those needing a fast return to work or sport - focused on reducing inflammation, increasing active range of motion 8 restoring function.",
                      featureHeader: "Gym, Hydrotherapy, Sauna & Ice Bath",
                      features: [
                        "Initial 1-Hour Exercise Physiology Session",
                        "Monthly 30-Minute Exercise Physiology Sessions",
                        "By Appointment Only - to ensure your spot",
                        "Access to Staff for Ongoing Support",
                        "No Contract Period",
                        "Each Session Includes: Cym and/or Hydrotherapy, Sauna / Ice Bath",
                      ],
                      onSelect: () {
                             Navigator.pushReplacementNamed(context,RoutesName.getInTouchScreen);
                      },
                    ),
                    
                    // GOLD PLAN
                    PlanWidget(
                      title: "Gold",
                      price: "\$165.00/week",
                      description: "When you need structured care & guidance, with focus on strength & function for your rehabilitation journey.",
                      featureHeader: "Gym + Hydrotherapy",
                      features: [
                        "Gym & Hydrotherapy Programming",
                        "Initial 1-Hour Exercise Physiology Session",
                        "Monthly 30-Minute Exercise Physiology Sessions",
                        "By Appointment Only - to ensure your spot",
                        "No Contract Period",
                      ],
                      onSelect: () {
                             Navigator.pushReplacementNamed(context,RoutesName.getInTouchScreen);
                      },
                    ),
                     PlanWidget(
                      title: "Weekly Membership",
                      price: "\$79.00/week",
                      description: "If you already have a program from us or your external physio, and you're looking for the best hydrotherapy and gym combination in the Illawarra to stay fit, strong, functional, and pain-free.",
                      featureHeader: "Gym + Hydrotherapy",
                      features: [
                        "Hydrotherapy & gym",
                        "By appointment only to ensure your spot",
                        "No Contracted period",
                        "Ask for assistance at any time!",
                      
                      ],
                      onSelect: () {
                        Navigator.pushReplacementNamed(context,RoutesName.getInTouchScreen);
                      },
                    ),
                     PlanWidget(
                      title: "One-off Exercise Prescription",
                      price: "\$199.00/hour",
                    
                      onSelect: () {
                             Navigator.pushReplacementNamed(context,RoutesName.getInTouchScreen);
                      },
                    ),
                    
                
                    SizedBox(height: 20.h), 
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}