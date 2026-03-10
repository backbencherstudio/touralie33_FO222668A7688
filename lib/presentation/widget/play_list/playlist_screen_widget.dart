import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';

class PlayListScreenWidget extends StatelessWidget {
  final String ?image;         
  final String? videoCount;    
  final String ?title;          
  final String ?videoDuration;  
  final String? totalTime;      
  final String ?buttonText, sufImage,bookMarkIcon;     
  final VoidCallback? onTap;   
  final Color? buttonIconColor,colorbg; 

  const PlayListScreenWidget({
    super.key,
   this.image,
  this.videoCount,
     this.title,
   this.videoDuration,
     this.totalTime,
    this.buttonText,
    this.onTap,
    this.buttonIconColor, this.sufImage, this.colorbg, this.bookMarkIcon,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(12.r),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: colorbg?? ColorManager.playlistBox,
          border: Border.all(
            color: const Color.fromARGB(255, 195, 195, 195),
            width: .8.w,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(8.r),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                 
                  Container(
                  
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16.r),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16.r),
                      child: Image.asset(image ?? "", fit: BoxFit.cover,height: 73.h,width: 81.w,),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                       
                        Text(
                          videoCount ?? "",
                          style: getMedium500Style10(
                            color: ColorManager.subtextColorGrey,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                       
                        Text(
                          title ?? "",
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: getMedium500Style16(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              IconManager.videoICon,
                              height: 13.h,
                              width: 11.w,
                              color: ColorManager.blackColor,
                            ),
                            SizedBox(width: 6.w),
                           
                            Text(
                              videoDuration ?? "",
                              style: getMedium500Style12(
                                color: ColorManager.textPrimary,
                                fontSize: 12.sp,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Image.asset(
                            IconManager.clock,
                            height: 13.h,
                            color: ColorManager.blackColor,
                          ),
                          SizedBox(width: 5.w),
                         
                          Text(
                            totalTime ?? "",
                            style: getMedium500Style12(
                              color: ColorManager.textPrimary,
                              fontSize: 12.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 40.h),
                      Image.asset(bookMarkIcon ?? IconManager.bookMark, width: 9.w, height: 12.h),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 8.h),
            
              Customebutton(
                sufImage: sufImage,
                text: buttonText,
                onTap: onTap,
                sufImageColor: buttonIconColor, 
              )
            ],
          ),
        ),
      ),
    );
  }
}