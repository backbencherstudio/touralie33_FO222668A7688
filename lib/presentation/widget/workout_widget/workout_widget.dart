import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/workout_video_player_screen/workout_video_player_screen.dart';
import 'package:video_player/video_player.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:chewie/chewie.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class WorkoutWidget extends StatelessWidget {
  const WorkoutWidget({
    super.key,
    this.videoUrl =
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  });

  final String videoUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
  
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: ColorManager.primary,
        border: Border.all(
          width: 1,
          color: ColorManager.backgroundColorgreen.withValues(alpha: .5),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Today's Workout",
                  style: getMedium500Style12(
                    color: Colors.grey,
                    fontSize: 12.sp,
                  ),
                ),
                Row(
                  children: [
                    Image.asset(
                      IconManager.clock,
                      height: 16.h,
                 
                      color: ColorManager.blackColor,
                    ),
                    SizedBox(width: 5.w,),
                    Text(
                      "45 min",
                      style: getMedium500Style14(
                        color: ColorManager.blackColor,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 5.h),
            Text(
              "Back Mobility Program",
              style: getMedium500Style14(
                color: ColorManager.subtextColor,
                fontSize: 16.sp,
              ),
            ),
            SizedBox(height: 15.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(
                      IconManager.videoICon,
                      fit: BoxFit.cover,
                      height: 14.h,
                      width: 14.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      "4 Videos",
                      style: getMedium500Style14(
                        color: ColorManager.subtextColor,
                        fontSize: 12.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                Image.asset(
                  IconManager.bookMark,
                  fit: BoxFit.cover,
               
                  height: 13.h,
                ),
              ],
            ),
            SizedBox(height: 15.h,),
            ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (_) => WorkoutVideoPlayerScreen(
                        videoUrl: videoUrl,
                      ),
                    ),
                  );
                },
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    Image.asset(
                      ImageManager.gymGuide,
                      width: double.infinity,
                      height: 250,
                      fit: BoxFit.cover,
                    ),
                    SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.asset(IconManager.playCircle),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 15.h,),
            Customebutton(
              text: "Watch Now",
              sufImage: IconManager.playButton,
              sufImageColor: ColorManager.blackColor,
            )
          ],
        ),
      ),
    );
  }
}
