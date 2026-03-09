import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class SuggestionVideoWidget extends StatelessWidget {
  final String categoryName;
  final String title;
  final String duration;
  final String level;
  final String imageUrl;
  final Color? colorBg;
  final VoidCallback? onPlayTap;

  const SuggestionVideoWidget({
    super.key,
    required this.categoryName,
    required this.title,
    required this.duration,
    required this.level,
    required this.imageUrl,
    this.onPlayTap, this.colorBg,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: colorBg ?? ColorManager.playlistBox,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(color:  ColorManager.borderColor, width: 1.5.w),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12.r),
                    topRight: Radius.circular(12.r)
                  ),
                  child: Image.asset(
                    imageUrl,
                    height: 100.h,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  left: 2.w,
                  bottom: 2.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 6.w,
                      vertical: 2.h,
                    ),

                    child: Text(
                      '1/4',
                      style: getMedium500Style12(
                        color: ColorManager.whiteColor,
                        fontSize: 14.sp,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: 0.w,
                  bottom: 0.h,
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 4.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.backgroundColorgreen,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(5.r),
                        topRight: Radius.circular(5.r),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          IconManager.videoICon,
                          height: 10.h,
                       
                        ),
                        SizedBox(width: 6.w),
                        Text(
                          '4 Videos',
                          style: TextStyle(
                            color: ColorManager.subtextColor,
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),

            SizedBox(height: 12.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  categoryName,
                  style: getMedium500Style10(
                    color: ColorManager.subtextColorGrey,
                    fontSize: 12.sp,
                  ),
                ),
                Image.asset(IconManager.bookMark,height: 12.h,),
              ],
            ),
            SizedBox(height: 8.h),
            Text(
              title,
              style: getMedium500Style10(
                color: ColorManager.subtextColor,
                fontSize: 13.sp,
              ),
            ),
            SizedBox(height: 5.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Image.asset(IconManager.clock, height: 16.h, width: 16.w),
                    SizedBox(width: 5.w),
                    Text(
                      duration,
                      style: getMedium500Style10(
                        color: ColorManager.subtextColorGrey,
                        fontSize: 12.sp,
                      ),
                    ),
                  ],
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: ColorManager.beginerColor,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 10.w,
                      vertical: 6.h,
                    ),
                    child: Text(
                      level,
                      style: getMedium500Style10(
                        color: ColorManager.textPrimary,
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
