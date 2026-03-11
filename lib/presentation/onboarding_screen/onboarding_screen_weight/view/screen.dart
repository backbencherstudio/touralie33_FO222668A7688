import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';


final weightUnitProvider = StateProvider<String>((ref) => "Kg");
final selectedWeightProvider = StateProvider<int>((ref) => 50); 

class OnBordingScreenWeight extends ConsumerStatefulWidget {
  const OnBordingScreenWeight({super.key});

  @override
  ConsumerState<OnBordingScreenWeight> createState() => _OnBordingScreenWeightState();
}

class _OnBordingScreenWeightState extends ConsumerState<OnBordingScreenWeight> {
  late ScrollController _scrollController;
  final double itemWidth = 60.0; 

  @override
  void initState() {
    super.initState();

    
    int initialIndex = 50 - 20;

  
    _scrollController = ScrollController(
      initialScrollOffset: initialIndex * itemWidth.w,
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final selectedUnit = ref.watch(weightUnitProvider);
    final selectedWeight = ref.watch(selectedWeightProvider);

    return Scaffold(
      backgroundColor: ColorManager.primary,
      body: Center(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50.h), 
              Image.asset(
                ImageManager.weight,
                width: 108.w,
                height: 108.h,
              ),
              SizedBox(height: 16.h),
              Text(
                "What is your Weight",
                style: getMedium500Style16(
                  color: ColorManager.textPrimary,
                  fontWeight: FontWeight.w600,
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 40.h),
          
              SizedBox(
                height: 70.h,
                child: ListView.builder(
                  controller: _scrollController,
                  scrollDirection: Axis.horizontal,
                  itemCount: 81, 
                  padding: EdgeInsets.symmetric(
                    horizontal: MediaQuery.of(context).size.width / 2 - (itemWidth.w / 2),
                  ),
                  itemBuilder: (context, index) {
                    int weightValue = index + 20;
                    bool isSelected = selectedWeight == weightValue;
          
                    return GestureDetector(
                      onTap: () {
                      
                        ref.read(selectedWeightProvider.notifier).state = weightValue;
          
                      
                        _scrollController.animateTo(
                          index * itemWidth.w,
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        );
                      },
                      child: Container(
                        width: itemWidth.w,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: isSelected
                              ? ColorManager.backgroundColorgreen
                              : Colors.transparent,
                        ),
                        child: Text(
                          "$weightValue",
                          style: getMedium500Style16(
                            color: isSelected ? Colors.black : Colors.grey.withOpacity(0.6),
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.w400,
                            fontSize: isSelected ? 18.sp : 14.sp,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
          
              SizedBox(height: 30.h),
          
              // --- Kg / Lb Toggle Switch ---
              Container(
                height: 35.h,
                width: 110.w,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  color: ColorManager.bgColorgrey,
                ),
                child: Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: Row(
                    children: [
                 
                      Expanded(
                        child: GestureDetector(
                          onTap: () => ref.read(weightUnitProvider.notifier).state = "Kg",
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: selectedUnit == "Kg"
                                  ? ColorManager.backgroundColorgreen
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                "Kg",
                                style: getMedium500Style14(
                                  color: ColorManager.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
            
                      Expanded(
                        child: GestureDetector(
                          onTap: () => ref.read(weightUnitProvider.notifier).state = "Lb",
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.r),
                              color: selectedUnit == "Lb"
                                  ? ColorManager.backgroundColorgreen
                                  : Colors.transparent,
                            ),
                            child: Center(
                              child: Text(
                                "Lb",
                                style: getMedium500Style14(
                                  color: ColorManager.textPrimary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}