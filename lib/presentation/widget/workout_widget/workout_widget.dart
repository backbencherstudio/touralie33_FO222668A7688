import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class WorkoutWidget extends StatelessWidget {
  const WorkoutWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12.r),
        color: ColorManager.primary,
        border: Border.all(
          width: 2,
          color: ColorManager.backgroundColorgreen.withValues(alpha: .5)
        )
      ),
      child: Padding(
        padding:  EdgeInsets.all(12.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Today's Workout",style: getMedium500Style12(color: Colors.grey,fontSize: 12.sp),),
                Row(
                  children: [
                    Image.asset(IconManager.clock,height: 16.h,width: 13.w,color: ColorManager.blackColor,),
                    Text("45 min",style: getMedium500Style14(color: ColorManager.blackColor,fontSize: 12.sp),)
                  ],
                )
              ],
            ),
            SizedBox(height: 5.h,),
            Text("Back Mobility Program",style: getMedium500Style14(color: ColorManager.subtextColor,fontSize: 16.sp),)
          ],
        ),
      ),
    );
  }
}