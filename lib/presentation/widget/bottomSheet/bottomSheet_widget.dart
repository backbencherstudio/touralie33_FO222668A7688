import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';


final selectedCategoryProvider = StateProvider<int?>((ref) => null);

class BottomsheetWidget extends ConsumerStatefulWidget {
  const BottomsheetWidget({super.key});

  @override
  ConsumerState<BottomsheetWidget> createState() => _BottomsheetWidgetState();
}

class _BottomsheetWidgetState extends ConsumerState<BottomsheetWidget> {

  final List<String> categories = [
    "Hydrotherapy",
    "Pre & Post Operative",
    "Spinal Rehabilitation",
    "Hot / Cold Therapy",
    "Scoliosis",
    "Headaches",
    "Manual Therapy",
    "Exercise Therapy",
    "TMJ",
  ];

  @override
  Widget build(BuildContext context) {
    final selectedIndex = ref.watch(selectedCategoryProvider);  

    return Container(
  
      constraints: BoxConstraints(maxHeight: 650.h),
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.playlistBox, 
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 12.h),
          // Top Handle Icon
          Image.asset(
            IconManager.upIcon,
            fit: BoxFit.cover,
            height: 20.h,
            width: 20.w,
          ),
          SizedBox(height: 10.h),
          Text(
            "Categories",
            style: getMedium500Style10(
              color: ColorManager.textPrimary,
              fontSize: 18.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          SizedBox(height: 10.h),
          
          // Scrollable area for items
          Flexible(
            child: SingleChildScrollView(
              child: Column(
                children: List.generate(categories.length, (index) {
                  final isSelected = selectedIndex == index;
                  
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 14.w,vertical: 4.h ),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(15.r),
                      onTap: () {
                     
                        ref.read(selectedCategoryProvider.notifier).state = index;
                      },
                      child: Container(
                        width: double.infinity,
                        height: isSelected ? 55.h : 30.h,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15.r),
                          
                          color: isSelected 
                              ? ColorManager.bottomSheetColor 
                              : Colors.transparent,
                          border: Border.all(
                            color: isSelected 
                                ? Colors.transparent 
                                : ColorManager.bottomSheetColor.withOpacity(0.3)
                          )
                        ),
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 20.w),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              categories[index],
                              style: getMedium500Style14(
                                color: ColorManager.textPrimary,
                                fontSize: 14.sp,
                                fontWeight:  FontWeight.w500 ,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ),
          SizedBox(height: 20.h), 
        ],
      ),
    );
  }
}