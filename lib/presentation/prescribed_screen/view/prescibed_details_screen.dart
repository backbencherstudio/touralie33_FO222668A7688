import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/data/models/prescription_resume_model.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/getPrescription_resume_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/custom_video_player/Custom_video_player.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/workout_set/workOut_set.dart';

class PrescibedDetailsScreen extends ConsumerStatefulWidget {
  const PrescibedDetailsScreen({
    super.key,
    this.id,
    this.appBarTitle,
    this.videoUrl,
    this.thumbnailAsset,
    this.categoryName,
    this.title,
    this.description,
    this.duration,
    this.level,
    this.workoutSetTitle,
    this.workoutProgressText,
    this.workoutSets,
    this.onWatchNow,
    this.watchNowText,
  });

  final String? id;
  final String? appBarTitle;
  final String? videoUrl;
  final String? thumbnailAsset;
  final String? categoryName;
  final String? title;
  final String? description;
  final String? duration;
  final String? level;
  final String? workoutSetTitle;
  final String? workoutProgressText;
  final List<Widget>? workoutSets;
  final VoidCallback? onWatchNow;
  final String? watchNowText;

  @override
  ConsumerState<PrescibedDetailsScreen> createState() => _PrescibedDetailsScreenState();
}

class _PrescibedDetailsScreenState extends ConsumerState<PrescibedDetailsScreen> {
  bool _isExpanded = false;
  String? _selectedVideoUrl;
  String? _selectedThumbnail;
  int _selectedChapterIndex = 0;

  int? _parseTimeToSeconds(String? value) {
    if (value == null || value.isEmpty) return null;
    final direct = int.tryParse(value);
    if (direct != null) return direct;

    final parts = value.split(':').map(int.tryParse).toList();
    if (parts.any((part) => part == null)) return null;
    if (parts.length == 3) {
      return (parts[0] ?? 0) * 3600 + (parts[1] ?? 0) * 60 + (parts[2] ?? 0);
    }
    if (parts.length == 2) {
      return (parts[0] ?? 0) * 60 + (parts[1] ?? 0);
    }
    return null;
  }

  String _formatChapterDuration(String? startTime, String? endTime) {
    final startSeconds = _parseTimeToSeconds(startTime);
    final endSeconds = _parseTimeToSeconds(endTime);
    if (startSeconds != null && endSeconds != null && endSeconds >= startSeconds) {
      final durationInMinutes = ((endSeconds - startSeconds) / 60).ceil();
      return '$durationInMinutes min';
    }
    if ((startTime ?? '').isNotEmpty && (endTime ?? '').isNotEmpty) {
      return '$startTime - $endTime';
    }
    return startTime ?? endTime ?? '0 min';
  }

  List<Widget> _buildChapterWorkoutSets({
    required List<VideoChapters> chapters,
    required PrescriptionResumeData? workout,
  }) {
    return chapters.asMap().entries.map((entry) {
      final chapter = entry.value;
      return Padding(
        padding: EdgeInsets.only(
          bottom: entry.key == chapters.length - 1 ? 0 : 15.h,
        ),
        child: WorkoutSet(
          mainImage: chapter.thumbnailUrl ?? ImageManager.gymGuide,
          duration: _formatChapterDuration(
            chapter.startTime,
            chapter.endTime,
          ),
          title: chapter.title ?? 'Workout Chapter',
          iconBgColor: entry.key == _selectedChapterIndex
              ? ColorManager.backgroundColorgreen
              : null,
          borderColor: entry.key == _selectedChapterIndex
              ? ColorManager.backgroundColorgreen1
              : null,
          ontap: () {
            setState(() {
              _selectedChapterIndex = entry.key;
              _selectedVideoUrl = chapter.videoUrl ?? workout?.url;
              _selectedThumbnail = chapter.thumbnailUrl ?? workout?.thumbnail;
            });
          },
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final prescriptionState = ref.watch(getPrescriptionResumeProvider);
    final providerWorkout = prescriptionState.prescriptionData?.data;
    final matchedWorkout =
        widget.id == null || providerWorkout?.id == widget.id ? providerWorkout : null;

    final description = widget.description ??
        matchedWorkout?.instruction?.description ??
        'This Video is focused on back mobility that will help you to reduce pain, improve flexibility, and build better posture through guided movements.';
    final shortDescription = description.length > 126
        ? '${description.substring(0, 126)}... '
        : description;
    final categoryText = widget.categoryName ?? "Categories Name";
    final levelText = widget.level ?? "Beginner";
    final chapterCount = matchedWorkout?.videoChapters?.length ??
        matchedWorkout?.chapterCount ??
        1;
    final chapters = matchedWorkout?.videoChapters ?? const <VideoChapters>[];
    final currentVideoUrl = _selectedVideoUrl ??
        widget.videoUrl ??
        matchedWorkout?.url ??
        'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4';
    final currentThumbnail = _selectedThumbnail ??
        widget.thumbnailAsset ??
        matchedWorkout?.thumbnail ??
        ImageManager.gymGuide;
    final chapterWidgets = _buildChapterWorkoutSets(
      chapters: chapters,
      workout: matchedWorkout,
    );
    final workoutSets = widget.workoutSets ?? (chapterWidgets.isNotEmpty 
      ? chapterWidgets 
      : (prescriptionState.prescriptionData?.data?.videoChapters != null 
          ? prescriptionState.prescriptionData!.data!.videoChapters!.map((item) => Padding(
              padding: EdgeInsets.only(bottom: 15.h),
              child: WorkoutSet(
                mainImage: item.thumbnailUrl?? ImageManager.gymGuide,
                duration: "${item.startTime} min",
                title: item.title ?? "Untitled",
              ),
            )).toList()
          : [ /* Your hardcoded fallback here */ ]
        )
    );

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(
              text: widget.appBarTitle ?? "Your Prescribed Video",
            ),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorManager.primary, ColorManager.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(12.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: ColorManager.whiteColor,
                    border: Border.all(color: ColorManager.backgroundColorgreen1),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomVideoPlayer(
                          videoUrl: currentVideoUrl,
                          thumbnailAsset: currentThumbnail,
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              categoryText,
                              style: getMedium500Style14(
                                color: ColorManager.subtextColorGrey,
                                fontSize: 12.sp,
                              ),
                            ),
                            Image.asset(IconManager.bookMark, height: 16.h),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Text(
                          widget.title ??
                              matchedWorkout?.title ??
                              "Back Mobility Program",
                          style: getMedium500Style12(
                            color: ColorManager.textPrimary,
                            fontSize: 20.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5.h),
                        RichText(
                          text: TextSpan(
                            style: getRegular400Style14(
                              color: const Color.fromARGB(255, 92, 92, 92),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                            ).copyWith(height: 1.6, letterSpacing: 0.5),
                            children: [
                              TextSpan(
                                text: _isExpanded ? description : shortDescription,
                              ),
                              if (description.length > 126)
                                TextSpan(
                                  text: _isExpanded ? 'Read Less' : 'Read More',
                                  style: getMedium500Style14(
                                    color: ColorManager.backgroundColorgreen1,
                                    fontSize: 13.sp,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      setState(() {
                                        _isExpanded = !_isExpanded;
                                      });
                                    },
                                ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(
                                  IconManager.clock,
                                  width: 16.w,
                                  height: 19.h,
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(width: 8.w),
                                Text(
                                  widget.duration ??
                                      '${matchedWorkout?.duration ?? 45} min',
                                  style: getMedium500Style10(
                                    color: ColorManager.textPrimary,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: ColorManager.drawrColor.withValues(alpha: .4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  levelText,
                                  style: getMedium500Style14(
                                    color: ColorManager.textPrimary,
                                    fontSize: 10.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: ColorManager.whiteColor,
                            border: Border.all(
                              color: ColorManager.backgroundColorgreen,
                              width: .5.w,
                            ),
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.r),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      widget.workoutSetTitle ?? "Workout Set",
                                      style: getMedium500Style12(
                                        color: ColorManager.textPrimary,
                                        fontSize: 16.sp,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    Row(
                                      children: [
                                        Image.asset(
                                          IconManager.videoICon,
                                          fit: BoxFit.cover,
                                          height: 13.h,
                                        ),
                                        SizedBox(width: 4.w),
                                        Text(
                                          widget.workoutProgressText ??
                                              '${chapters.isEmpty ? 1 : _selectedChapterIndex + 1}/$chapterCount videos',
                                          style: getMedium500Style16(
                                            color: ColorManager.textPrimary,
                                            fontSize: 13.sp,
                                            fontWeight: FontWeight.w400,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                SizedBox(height: 10.h),
                                ...(chapters.isNotEmpty ? chapterWidgets : workoutSets),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h),
                        Customebutton(
                          onTap: widget.onWatchNow,
                          text: widget.watchNowText ?? "Watch Now",
                          textColor: ColorManager.whiteColor,
                          color: ColorManager.blackColor,
                          sufImage: IconManager.playButton,
                          sufImageColor: ColorManager.whiteColor,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 70.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
