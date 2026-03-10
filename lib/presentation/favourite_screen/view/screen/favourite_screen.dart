import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/bottomSheet/bottomSheet_widget.dart';
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
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Divider(color: ColorManager.beginerColor,),
            SizedBox(height: 15.h,),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                children: [
                  Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Favourite",style: getLight300Style12(color: ColorManager.textPrimary,fontSize: 18.sp,fontWeight: FontWeight.w500),),
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(context: context, 
                        isScrollControlled: true,
                      backgroundColor: ColorManager.playlistBox,
                      shape: RoundedRectangleBorder(
                        
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.r),
                          topRight: Radius.circular(25.r)
                        )
                      ),
                      builder: (context){
                        return BottomsheetWidget();
                      });
                    },
                    child: Image.asset(IconManager.filter,fit: BoxFit.cover,height: 20.h,width: 20.w,))
                ],
              ),
              SizedBox(height: 11.h,),
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
                    categoryName: "Categories Name",title: "Back Mobility Program",level: "Active",imageUrl: ImageManager.gymGuide,onPlayTap: () {
                    
                  },),
                ),
              ],
                        ),
                        SizedBox(height: 8.h,),
                        Row(
              children: [
                Expanded(
                  child: SuggestionVideoWidget(
                    duration: "15 min",
                    categoryName: "Categories Name",title: "Back Mobility Program",level: "Intermediate",imageUrl: ImageManager.gymGuide,onPlayTap: () {
                    
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
                  SizedBox(height: 8.h,),
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
                    categoryName: "Categories Name",title: "Back Mobility Program",level: "Intermadiate",imageUrl: ImageManager.gymGuide,onPlayTap: () {
                    
                  },),
                ),
              ],
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}