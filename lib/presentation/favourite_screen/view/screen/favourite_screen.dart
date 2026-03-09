import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/suggestion_video/suggestion_video_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/workout_set/workOut_set.dart';

class FavouriteScreen extends StatelessWidget {
  const FavouriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
    appBar:  PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(text: "Bookmark",showBackIcon: false,),
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(12.r),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Divider(),
              SizedBox(height: 15.h,),
              Row(
                children: [
                  Text("Your Favorite",style: getLight300Style12(color: ColorManager.textPrimary,fontSize: 18.sp,fontWeight: FontWeight.w500),),
          
                ],
              ),
            Row(
              children: [
                Expanded(
                  child: SuggestionVideoWidget(
                    duration: "15 min",
                    categoryName: "Categories Name",title: "Back Mobility Program",level: "Beginner",imageUrl: ImageManager.gymGuide,onPlayTap: () {
                    
                  },),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: SuggestionVideoWidget(
                    
                    duration: "15 min",
                    categoryName: "Categories Name",title: "Back Mobility Program",level: "Beginner",imageUrl: ImageManager.gymGuide,onPlayTap: () {
                    
                  },),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SuggestionVideoWidget(
                    duration: "15 min",
                    categoryName: "Categories Name",title: "Back Mobility Program",level: "Beginner",imageUrl: ImageManager.gymGuide,onPlayTap: () {
                    
                  },),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: SuggestionVideoWidget(
                    
                    duration: "15 min",
                    categoryName: "Categories Name",title: "Back Mobility Program",level: "Beginner",imageUrl: ImageManager.gymGuide,onPlayTap: () {
                    
                  },),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  child: SuggestionVideoWidget(
                    duration: "15 min",
                    categoryName: "Categories Name",title: "Back Mobility Program",level: "Beginner",imageUrl: ImageManager.gymGuide,onPlayTap: () {
                    
                  },),
                ),
                SizedBox(width: 10.w,),
                Expanded(
                  child: SuggestionVideoWidget(
                    
                    duration: "15 min",
                    categoryName: "Categories Name",title: "Back Mobility Program",level: "Beginner",imageUrl: ImageManager.gymGuide,onPlayTap: () {
                    
                  },),
                ),
              ],
            )
            ],
          ),
        ),
      ),
    );
  }
}