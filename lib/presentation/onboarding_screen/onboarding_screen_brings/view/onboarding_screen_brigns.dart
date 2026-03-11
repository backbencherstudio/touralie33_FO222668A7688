import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
// ignore: unused_import
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';


final selectItemsProvider = StateProvider<List<String>>((ref) => []);

class OnboardingScreenBrigns extends ConsumerStatefulWidget {
  const OnboardingScreenBrigns({super.key});

  @override
  ConsumerState<OnboardingScreenBrigns> createState() => _OnboardingScreenBrignsState();
}

class _OnboardingScreenBrignsState extends ConsumerState<OnboardingScreenBrigns> {
  

  void _toggleSelection(String item) {
    final currentList = ref.read(selectItemsProvider);
    if (currentList.contains(item)) {
     
      ref.read(selectItemsProvider.notifier).state =
          currentList.where((element) => element != item).toList();
    } else {
    
      ref.read(selectItemsProvider.notifier).state = [...currentList, item];
    }
  }

  @override
  Widget build(BuildContext context) {
  
    final selectedItems = ref.watch(selectItemsProvider);

    return Padding(
      padding: EdgeInsets.all(12.r),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Text(
              "What brings you here ?",
              style: getMedium500Style20(
                  color: ColorManager.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 20.sp),
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                _buildSelectableItem("Physiotherapy", selectedItems),
                SizedBox(width: 16.w),
                _buildSelectableItem("Exercise Physiology", selectedItems),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                _buildSelectableItem("Hydrotherapy", selectedItems),
                SizedBox(width: 16.w),
                _buildSelectableItem("Ice Bath", selectedItems),
                SizedBox(width: 16.w),
                _buildSelectableItem("Dry Needing", selectedItems),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                _buildSelectableItem("Spinal Regabiliation", selectedItems),
                SizedBox(width: 16.w),
                _buildSelectableItem("Manual Therapy", selectedItems),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                _buildSelectableItem("Program Membership", selectedItems),
                SizedBox(width: 16.w),
                _buildSelectableItem("Saunas", selectedItems),
              ],
            ),
            SizedBox(height: 16.h),
            Row(
              children: [
                _buildSelectableItem("Neurological Injuries", selectedItems),
              ],
            ),
          ],
        ),
      ),
    );
  }


  Widget _buildSelectableItem(String title, List<String> selectedItems) {
    final bool isSelected = selectedItems.contains(title);
    
    return InkWell(
      onTap: () => _toggleSelection(title),
      borderRadius: BorderRadius.circular(12.r),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected 
              ? ColorManager.backgroundColorgreen 
              : ColorManager.buttonbgBrings, 
        ),
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 12.h),
            child: Text(
              title,
              style: getMedium500Style16(
                  color: ColorManager.textPrimary, 
                  fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
