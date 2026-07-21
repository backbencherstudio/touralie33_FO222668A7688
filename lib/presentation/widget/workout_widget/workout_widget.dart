import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/getPrescription_resume_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/prescribed_screen/view/only_playlist_details_screen.dart';

class WorkoutWidget extends ConsumerWidget {
  const WorkoutWidget({super.key, this.id});

  final String? id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final prescriptionState = ref.watch(getPrescriptionResumeProvider);
    final workout = prescriptionState.prescriptionData?.data;

    final workoutId = workout?.prescriptionId ?? workout?.id ?? id;
    final imageUrl = workout?.thumbnail;
    final canOpenDetails = (workoutId ?? '').trim().isNotEmpty;
    
    final int rawProgress = workout?.watchProgress ?? 0;
    final double progressValue = (rawProgress.clamp(0, 100)) / 100;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: ColorManager.backgroundColorgreen,
        image: const DecorationImage(
          image: AssetImage(ImageManager.vertical),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(Colors.black12, BlendMode.dstIn),
        ),
      ),
      child: prescriptionState.isLoading
          ? const Center(child: Padding(
              padding: EdgeInsets.all(20.0),
              child: CircularProgressIndicator(),
            ))
          : prescriptionState.errorMessage != null
              ? Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      prescriptionState.errorMessage!,
                      style: getMedium500Style12(
                        color: ColorManager.subtextColor,
                        fontSize: 14.sp,
                      ),
                    ),
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.fromLTRB(16.w, 16.h, 16.w, 8.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "todays workout",
                            style: getMedium500Style14(
                              color: ColorManager.subtextColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            '${workout?.chapterCount ?? 1} video',
                            style: getMedium500Style14(
                              color: ColorManager.subtextColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 10.h),
                          Text(
                            "keep going - be consistent",
                            style: getMedium500Style14(
                              color: ColorManager.subtextColor,
                              fontSize: 14.sp,
                            ),
                          ),
                          SizedBox(height: 16.h),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(12.r),
                            child: GestureDetector(
                              onTap: !canOpenDetails
                                  ? null
                                  :() => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OnlyPlaylistDetailsScreen(
                                            id: workoutId,
                                            fallbackTabIndex: 0,
                                          ),
                                        ),
                                      ),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  imageUrl != null && imageUrl.startsWith('http')
                                      ? Image.network(
                                          imageUrl,
                                          width: double.infinity,
                                          height: 200.h,
                                          fit: BoxFit.cover,
                                          errorBuilder: (_, __, ___) => Image.asset(
                                            ImageManager.gymGuide,
                                            width: double.infinity,
                                            height: 200.h,
                                            fit: BoxFit.cover,
                                          ),
                                        )
                                      : Image.asset(
                                          ImageManager.gymGuide,
                                          width: double.infinity,
                                          height: 200.h,
                                          fit: BoxFit.cover,
                                        ),
                                  SizedBox(
                                    width: 60.w,
                                    height: 60.h,
                                    child: Image.asset(IconManager.playCircle),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Center(
                            child: GestureDetector(
                              onTap: !canOpenDetails
                                  ? null
                                  :() => Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => OnlyPlaylistDetailsScreen(
                                            id: workoutId,
                                            fallbackTabIndex: 0,
                                          ),
                                        ),
                                      ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Watch Now",
                                    style: getMedium500Style16(
                                      color: ColorManager.subtextColor,
                                      fontSize: 16.sp,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                  SizedBox(width: 8.w),
                                  Icon(Icons.play_arrow, size: 20.sp, color: ColorManager.subtextColor),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10.h),
                    // Remaining progress section
                    Container(
                      color: Colors.white.withValues(alpha: 0.3),
                      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
                      child: Row(
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Remaining progress",
                                  style: getMedium500Style20(
                                    color: ColorManager.subtextColor,
                                    fontSize: 20.sp,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                SizedBox(height: 6.h),
                                Text(
                                  "Great progress, buddy! Stay\nconsistent and keep up your\nfitness routine.",
                                  style: getMedium500Style12(
                                    color: ColorManager.subtextColor,
                                    fontSize: 12.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 10.w),
                          Container(
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.all(4.0),
                            child: CircularPercentIndicator(
                              radius: 30.r,
                              lineWidth: 4.w,
                              percent: progressValue,
                              backgroundColor: Colors.transparent,
                              progressColor: ColorManager.backgroundColorgreen1,
                              circularStrokeCap: CircularStrokeCap.round,
                              center: Container(
                                width: 48.w,
                                height: 48.h,
                                decoration: BoxDecoration(
                                  color: ColorManager.backgroundColorgreen.withValues(alpha: 0.2),
                                  shape: BoxShape.circle,
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      '$rawProgress%',
                                      style: getMedium500Style16(
                                        color: ColorManager.subtextColor,
                                        fontSize: 12.sp,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Text(
                                      "Progress",
                                      style: getMedium500Style10(
                                        color: ColorManager.subtextColor,
                                        fontSize: 8.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
    );
  }
}
