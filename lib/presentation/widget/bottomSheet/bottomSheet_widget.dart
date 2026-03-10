import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class BottomsheetWidget extends StatelessWidget {
  const BottomsheetWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      
      width: double.infinity,
      child: Column(
        children: [
          SizedBox(height: 5.h,),
          Image.asset(IconManager.upIcon,fit: BoxFit.cover,height: 20.h,width: 20.w,),
          SizedBox(height: 5.h,),
          Text("Categories",style: getMedium500Style10(color: ColorManager.textPrimary,fontSize: 18.sp,fontWeight: FontWeight.w500),),
          SizedBox(height: 5.h,),
          Padding(
            padding:  EdgeInsets.all(14.r),
            child: Container(
              width: double.infinity,
              height: 44.h,
              decoration: BoxDecoration(
                borderRadius:BorderRadius.circular(15.r),
                color: ColorManager.bottomSheetColor
              ),
              child: Padding(
                padding:  EdgeInsets.symmetric(vertical: 15.h,horizontal: 20.w),
                child: Text("Hydrotherapy",style: getMedium500Style14(color: ColorManager.textPrimary,fontSize: 14.sp,fontWeight: FontWeight.w400),),
              ),
            ),
          )
        ],
      ),
    );
  }
}