import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/data/models/prescribed_detail_model.dart'
    as detail_model;
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/prescribed_screen/viewModel/prescribed_details_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/prescribed_screen/viewModel/library_progress_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/profile_screen/viewModel/profile_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/custom_video_player/Custom_video_player.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/workout_set/workOut_set.dart';

class PrescibedDetailsScreen extends ConsumerStatefulWidget {
  const PrescibedDetailsScreen({
    super.key,
    this.id,
    this.videoUrl,
    this.initialPositionMilliseconds = 0,
  });

  final String? id;
  final String? videoUrl;
  final int initialPositionMilliseconds;

  @override
  ConsumerState<PrescibedDetailsScreen> createState() =>
      _PrescibedDetailsScreenState();
}

class _PrescibedDetailsScreenState
    extends ConsumerState<PrescibedDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isExpanded = false;
  String? _selectedVideoUrl;
  String? _selectedThumbnail;
  int? _selectedChapterIndex;
  int? _selectedPositionMilliseconds;
  int _playRequestId = 0;
  late final LibraryProgressProvider _libraryProgressNotifier;
  late final ProfileProvider _profileNotifier;
  late final PrescribedDetailsProvider _prescribedDetailsNotifier;

  @override
  void initState() {
    super.initState();
    _libraryProgressNotifier = ref.read(libraryProgressProvider.notifier);
    _profileNotifier = ref.read(profileProvider.notifier);
    _prescribedDetailsNotifier =
        ref.read(prescribedDetailsNotifierProvider.notifier);
    if (widget.initialPositionMilliseconds > 0) {
      _selectedPositionMilliseconds = widget.initialPositionMilliseconds;
    }
    Future.microtask(() {
      final id = widget.id;
      if (id != null && id.isNotEmpty) {
        _prescribedDetailsNotifier.getPresCribedDetails(id: id);
      }
    });
  }

  @override
  void dispose() {
    Future.microtask(() {
      _profileNotifier.profileData();
    });
    _scrollController.dispose();
    super.dispose();
  }

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

  int _chapterStartMilliseconds(detail_model.VideoChapters chapter) {
    return (_parseTimeToSeconds(chapter.startTime) ?? 0) * 1000;
  }

  int _normalizeStoredPositionMilliseconds(
    int rawPosition,
    int? durationHintSeconds,
  ) {
    if (rawPosition <= 0) {
      return 0;
    }
    if (durationHintSeconds != null && rawPosition <= durationHintSeconds + 5) {
      return rawPosition * 1000;
    }
    return rawPosition;
  }

  int? _chapterEndMilliseconds(detail_model.VideoChapters chapter) {
    final seconds = _parseTimeToSeconds(chapter.endTime);
    return seconds == null ? null : seconds * 1000;
  }

  int _resolveChapterIndex({
    required List<detail_model.VideoChapters> chapters,
    required int positionMilliseconds,
  }) {
    if (chapters.isEmpty || positionMilliseconds <= 0) {
      return 0;
    }

    for (int index = 0; index < chapters.length; index++) {
      final chapter = chapters[index];
      final start = _chapterStartMilliseconds(chapter);
      final end = _chapterEndMilliseconds(chapter);
      if (positionMilliseconds >= start &&
          (end == null || positionMilliseconds <= end)) {
        return index;
      }
    }

    return 0;
  }

  String _formatChapterDuration(String? startTime, String? endTime) {
    final startSeconds = _parseTimeToSeconds(startTime);
    final endSeconds = _parseTimeToSeconds(endTime);
    if (startSeconds != null &&
        endSeconds != null &&
        endSeconds >= startSeconds) {
      final durationInMinutes = ((endSeconds - startSeconds) / 60).ceil();
      return '$durationInMinutes min';
    }
    if ((startTime ?? '').isNotEmpty && (endTime ?? '').isNotEmpty) {
      return '$startTime - $endTime';
    }
    return startTime ?? endTime ?? '0 min';
  }

  List<Widget> _buildChapterWorkoutSets({
    required List<detail_model.VideoChapters> chapters,
    required detail_model.Data? workout,
    required int selectedChapterIndex,
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
          iconBgColor: entry.key == selectedChapterIndex
              ? ColorManager.backgroundColorgreen
              : null,
          borderColor: entry.key == selectedChapterIndex
              ? ColorManager.backgroundColorgreen1
              : null,
          ontap: () {
            setState(() {
              _selectedChapterIndex = entry.key;
              _selectedVideoUrl =
                  chapter.videoUrl ?? workout?.url ?? widget.videoUrl;
              _selectedThumbnail = chapter.thumbnailUrl ?? workout?.thumbnailUrl;
              _selectedPositionMilliseconds =
                  _chapterStartMilliseconds(chapter);
            });
          },
        ),
      );
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final detailsState = ref.watch(prescribedDetailsNotifierProvider);
    final workout = detailsState.prescribedDetailsData?.data;

    if (detailsState.isLoading) {
      return Scaffold(
        backgroundColor: ColorManager.primary,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Customebar(
                text: "Watch Video",
              ),
            ),
          ),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    if (detailsState.errorMessage != null) {
      return Scaffold(
        backgroundColor: ColorManager.primary,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Customebar(
                text:  "Your Prescribed Video",
              ),
            ),
          ),
        ),
        body: Center(
          child: Padding(
            padding: EdgeInsets.all(16.r),
            child: Text(
              detailsState.errorMessage!,
              textAlign: TextAlign.center,
              style: getMedium500Style12(
                color: ColorManager.blackColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ),
      );
    }

    if (workout == null) {
      return Scaffold(
        backgroundColor: ColorManager.primary,
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(60.h),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
              child: Customebar(
                text:"Your Prescribed Video",
              ),
            ),
          ),
        ),
        body: Center(
          child: Text(
            "No data found.",
            style: getMedium500Style12(
              color: ColorManager.blackColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    }

    final description = 
        workout.description ??
        '';
    final shortDescription = description.length > 126
        ? '${description.substring(0, 126)}... '
        : description;
    final categoryText = workout.category ?? "All";
    final levelText =  workout.level ?? "";
    final chapters = workout.videoChapters ?? const <detail_model.VideoChapters>[];
    final chapterCount = chapters.isEmpty ? 1 : chapters.length;
    final normalizedBackendPositionMilliseconds =
        _normalizeStoredPositionMilliseconds(
          workout.lastWatchPosition ?? 0,
          workout.duration,
        );
    final effectiveInitialPositionMilliseconds =
        _selectedPositionMilliseconds ??
        (widget.initialPositionMilliseconds > 0
            ? widget.initialPositionMilliseconds
            : normalizedBackendPositionMilliseconds);
    final effectiveSelectedChapterIndex = _selectedChapterIndex ??
        _resolveChapterIndex(
          chapters: chapters,
          positionMilliseconds: effectiveInitialPositionMilliseconds,
        );
    final currentVideoUrl = _selectedVideoUrl ??
        widget.videoUrl ??
        workout.url ??
        '';
    final currentThumbnail = _selectedThumbnail ??
        workout.thumbnailUrl ??
        ImageManager.gymGuide;
    final chapterWidgets = _buildChapterWorkoutSets(
      chapters: chapters,
      workout: workout,
      selectedChapterIndex: effectiveSelectedChapterIndex,
    );

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(
              ontap: () => Navigator.pop(context),
              text:  "Watch Video",
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
            controller: _scrollController,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                    color: ColorManager.whiteColor,
                    border: Border.all(
                      color: ColorManager.backgroundColorgreen1,
                    ),
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
                          initialPositionMilliseconds:
                              effectiveInitialPositionMilliseconds,
                          playRequestId: _playRequestId,
                          onPositionChanged: (position) {
                            final id = widget.id;
                            if (id == null || id.isEmpty) return;
                            if (chapters.isNotEmpty) {
                              final liveChapterIndex = _resolveChapterIndex(
                                chapters: chapters,
                                positionMilliseconds: position,
                              );
                              if (_selectedChapterIndex != liveChapterIndex) {
                                setState(() {
                                  _selectedChapterIndex = liveChapterIndex;
                                });
                              }
                            }
                            _libraryProgressNotifier.syncProgress(
                                  id: id,
                                  positionMilliseconds: position,
                                );
                          },
                          onPlaybackStopped: (position) {
                            final id = widget.id;
                            if (id == null || id.isEmpty) return;
                            _libraryProgressNotifier.syncProgress(
                                  id: id,
                                  positionMilliseconds: position,
                                  force: true,
                                );
                          },
                          onCompleted: (position) {
                            final id = widget.id;
                            if (id == null || id.isEmpty) return;
                            _libraryProgressNotifier.syncProgress(
                                  id: id,
                                  positionMilliseconds: position,
                                  isCompleted: true,
                                  force: true,
                                );
                          },
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                categoryText,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: getMedium500Style14(
                                  color: ColorManager.subtextColorGrey,
                                  fontSize: 12.sp,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Image.asset(IconManager.bookMark, height: 16.h),
                          ],
                        ),
                        SizedBox(height: 5.h),
                        Text(
                         workout.title ?? "Back Mobility Program",
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
                      
                                      '${workout.duration ?? 0} min',
                                  style: getMedium500Style10(
                                    color: ColorManager.textPrimary,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            // Container(
                            //   decoration: BoxDecoration(
                            //     borderRadius: BorderRadius.circular(8.r),
                            //     color: ColorManager.drawrColor.withValues(
                            //       alpha: .4,
                            //     ),
                            //   ),
                            //   child: Padding(
                            //     padding: const EdgeInsets.all(8.0),
                            //     child: Text(
                            //       levelText,
                            //       style: getMedium500Style14(
                            //         color: ColorManager.textPrimary,
                            //         fontSize: 10.sp,
                            //         fontWeight: FontWeight.w500,
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                        SizedBox(height: 10.h),
                        // Container(
                        //   decoration: BoxDecoration(
                        //     borderRadius: BorderRadius.circular(12.r),
                        //     color: ColorManager.whiteColor,
                        //     border: Border.all(
                        //       color: ColorManager.backgroundColorgreen,
                        //       width: .5.w,
                        //     ),
                        //   ),
                        //   child: Padding(
                        //     padding: EdgeInsets.all(12.r),
                        //     child: Column(
                        //       children: [
                        //         Row(
                        //           mainAxisAlignment:
                        //               MainAxisAlignment.spaceBetween,
                        //           children: [
                        //             Text(
                        //            "Workout Set",
                        //               style: getMedium500Style12(
                        //                 color: ColorManager.textPrimary,
                        //                 fontSize: 16.sp,
                        //                 fontWeight: FontWeight.w600,
                        //               ),
                        //             ),
                        //             Row(
                        //               children: [
                        //                 Image.asset(
                        //                   IconManager.videoICon,
                        //                   fit: BoxFit.cover,
                        //                   height: 13.h,
                        //                 ),
                        //                 SizedBox(width: 4.w),
                        //                 Text(
                        //                   '${chapters.isEmpty ? 1 : effectiveSelectedChapterIndex + 1}/$chapterCount videos',
                        //                   style: getMedium500Style16(
                        //                     color: ColorManager.textPrimary,
                        //                     fontSize: 13.sp,
                        //                     fontWeight: FontWeight.w400,
                        //                   ),
                        //                 ),
                        //               ],
                        //             ),
                        //           ],
                        //         ),
                        //         SizedBox(height: 10.h),
                        //         if (chapterWidgets.isNotEmpty) ...chapterWidgets,
                        //       ],
                        //     ),
                        //   ),
                        // ),
                        // SizedBox(height: 15.h),
                        // Customebutton(
                        //   onTap: () {
                        //     if (_scrollController.hasClients) {
                        //       _scrollController.animateTo(
                        //         0,
                        //         duration: const Duration(milliseconds: 350),
                        //         curve: Curves.easeOut,
                        //       );
                        //     }
                        //     setState(() {
                        //       _selectedVideoUrl = currentVideoUrl;
                        //       _selectedThumbnail = currentThumbnail;
                        //       _playRequestId++;
                        //     });
                        //   },
                        //   text:  "Watch Now",
                        //   textColor: ColorManager.whiteColor,
                        //   color: ColorManager.blackColor,
                        //   sufImage: IconManager.playButton,
                        //   sufImageColor: ColorManager.whiteColor,
                        // ),
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
