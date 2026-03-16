import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/play_list/playlist_screen_widget.dart';

class PlaylistScreen extends StatelessWidget {
  const PlaylistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(text: "Playlist",showBackIcon: false,),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Divider(),
            SizedBox(height: 10.h,),
           
Padding(
  padding:  EdgeInsets.only(left: 12.w),
  child: Text(" Watch your remaining prescribed videos",style: getMedium500Style12(color: ColorManager.blackColor,fontSize: 16.sp,fontWeight: FontWeight.w500)),
),   
     
            PlayListScreenWidget(
              image: ImageManager.gymGuide,
              videoCount: "0/4 videos",
              title: "Back Mobility Program",
              videoDuration: "45 min",
              totalTime: "45 min",
              buttonText: "Start Now",
              buttonIconColor: Colors.white,
              onTap: () {
                print("Button Clicked!");
              },
            ),
            PlayListScreenWidget(
              image: ImageManager.gymGuide,
              videoCount: "0/4 videos",
              title: "Back Mobility Program",
              videoDuration: "45 min",
              totalTime: "45 min",
              buttonText: "In Progress",
              buttonIconColor: Colors.black,
              sufImage: IconManager.playButton,
              
              onTap: () {
                print("Button Clicked!");
              },
            ),
            PlayListScreenWidget(
              image: ImageManager.gymGuide,
              videoCount: "0/4 videos",
              title: "Back Mobility Program",
              videoDuration: "45 min",
              totalTime: "45 min",
              buttonText: "Start Now",
              buttonIconColor: Colors.white,
              onTap: () {
                print("Button Clicked!");
              },
            ),
          ],
        ),
      ),
    );
  }
}
