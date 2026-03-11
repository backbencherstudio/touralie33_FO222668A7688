import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customeAppBarHome/custome_app_bar_home.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/remaining_progress/remaining_progress_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/suggestion_video/suggestion_video_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/workout_widget/workout_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key, this.onOpenDrawer});

  final VoidCallback? onOpenDrawer;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RemainingProgressWidget(),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: Text(
                "Your Prescribed Video",
                style: getMedium500Style12(
                  color: ColorManager.subtextColor,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Padding(padding: EdgeInsets.all(16.r), child: WorkoutWidget()),
            SizedBox(height: 15.h),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: ColorManager.whiteColor,
                border: Border.all(
                          color: ColorManager.subtextColorGrey,width: .2
                        ),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(30.r),
                  topRight: Radius.circular(30.r),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  children: [
                    // Container(
                    //   height: 3.h,
                    //   width: 80.w,
                    //   decoration: BoxDecoration(
                    //     color: ColorManager.hintTextColor,
                    //     borderRadius: BorderRadius.circular(30.r),
                        
                    //   ),
                    // ),
                    SizedBox(height: 15.h),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Suggested Videos",
                          style: getMedium500Style16(
                            color: ColorManager.subtextColor,
                            fontSize: 18.sp,
                          ),
                        ),
                        Text(
                          "View All",
                          style: getMedium500Style12(
                            color: ColorManager.subtextColor,
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                 
                    Row(
                      children: [
                        Expanded(
                          child: SuggestionVideoWidget(
                            categoryName: "Hydrotherapy",
                            title: "Back Mobility Program",
                            duration: "45 min",
                            level: "Beginner",
                            imageUrl: ImageManager.gymGuide,
                            onPlayTap: () {
                              print("Video Playing...");
                            },
                          ),
                        ),
                        SizedBox(width: 6.w,),
                        Expanded(
                          child: SuggestionVideoWidget(
                            categoryName: "Hydrotherapy",
                            title: "Back Mobility Program",
                            duration: "45 min",
                            level: "Beginner",
                            imageUrl: ImageManager.gymGuide,
                            onPlayTap: () {
                              print("Video Playing...");
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h),
                    Row(
                      children: [
                        Expanded(
                          child: SuggestionVideoWidget(
                            categoryName: "Hydrotherapy",
                            title: "Back Mobility Program",
                            duration: "45 min",
                            level: "Beginner",
                            imageUrl: ImageManager.gymGuide,
                            onPlayTap: () {
                              print("Video Playing...");
                            },
                          ),
                        ),
                        SizedBox(width: 6.w,),
                        Expanded(
                          child: SuggestionVideoWidget(
                            categoryName: "Hydrotherapy",
                            title: "Back Mobility Program",
                            duration: "45 min",
                            level: "Beginner",
                            imageUrl: ImageManager.gymGuide,
                            onPlayTap: () {
                              print("Video Playing...");
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 15.h,),
                    Row(
                      children: [
                        Expanded(
                          child: SuggestionVideoWidget(
                            categoryName: "Hydrotherapy",
                            title: "Back Mobility Program",
                            duration: "45 min",
                            level: "Beginner",
                            imageUrl: ImageManager.gymGuide,
                            onPlayTap: () {
                              print("Video Playing...");
                            },
                          ),
                        ),
                        SizedBox(width: 6.w,),
                        Expanded(
                          child: SuggestionVideoWidget(
                            categoryName: "Hydrotherapy",
                            title: "Back Mobility Program",
                            duration: "45 min",
                            level: "Beginner",
                            imageUrl: ImageManager.gymGuide,
                            onPlayTap: () {
                              print("Video Playing...");
                            },
                          ),
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
    );
  }
}
