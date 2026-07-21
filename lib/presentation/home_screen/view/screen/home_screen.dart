import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/getMe_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/getPrescription_resume_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/suggested_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customeAppBarHome/custome_app_bar_home.dart';

import 'package:touralie33_fo222668a7688/presentation/widget/workout_widget/workout_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touralie33_fo222668a7688/presentation/favourite_screen/viewModel/favourite_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/favourite_id_provider.dart';

import '../../../../core/resource/constants/icon_manager.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key, this.onOpenDrawer});

  final VoidCallback? onOpenDrawer;

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(suggestedNotifierProvider.notifier).getSuggested();
      ref.read(getPrescriptionResumeProvider.notifier).getPrescription();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final suggested = ref.watch(suggestedNotifierProvider);
    final suggestedList = suggested.suggestedData?.data ?? [];
    final state = ref.watch(getMeProvider);
    final user = state.me?.data;
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: CustomeAppBarHome(
              onProfileTap: widget.onOpenDrawer,
              name: user?.name,
              email: user?.email,
              avatarUrl: user?.avatarUrl ?? user?.avatar,
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          await ref.read(suggestedNotifierProvider.notifier).getSuggested();
          await ref
              .read(getPrescriptionResumeProvider.notifier)
              .getPrescription();
        },
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WorkoutWidget(),
              SizedBox(height: 15.h),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: ColorManager.whiteColor,
                  border: Border.all(
                    color: ColorManager.subtextColorGrey,
                    width: .2,
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30.r),
                    topRight: Radius.circular(30.r),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Column(
                    children: [
                      // Container(
                      //   height: 3.h,
                      //   width: 80.w,
                      //   decoration: BoxDecoration(
                      //     color: ColorManager.hintTextColor,
                      //     borderRadius: BorderRadius.circular(30.r),

                      //   ),
                      // ),
                      SizedBox(height: 15.h),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Suggested Exercises",
                            style: getMedium500Style16(
                              color: ColorManager.subtextColor,
                              fontSize: 18.sp,
                            ),
                          ),
                          // Text(
                          //   "View All",
                          //   style: getMedium500Style12(
                          //     color: ColorManager.subtextColor,
                          //     fontSize: 14.sp,
                          //   ),
                          // ),
                        ],
                      ),
                      SizedBox(height: 15.h),
                      if (suggested.isLoading)
                        const Center(child: CircularProgressIndicator())
                      else if (suggested.errorMessage != null)
                        Center(
                          child: Text(
                            suggested.errorMessage!,
                            textAlign: TextAlign.center,
                            style: getMedium500Style12(
                              color: ColorManager.subtextColor,
                              fontSize: 14.sp,
                            ),
                          ),
                        )
                      else if (suggestedList.isNotEmpty)
                        GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: suggestedList.length,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10.w,
                                mainAxisSpacing: 15.h,
                                mainAxisExtent: 150.h,
                              ),
                          itemBuilder: (context, index) {
                            final video = suggestedList[index];
                            final isBookmarked = video.isFavorite ?? false;

                            return GestureDetector(
                              onTap: () {
                                if (video.mediaType == "PDF") {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.pdfDetailsScreen,
                                    arguments: {
                                      'id': video.id,
                                      'title': video.title,
                                    },
                                  );
                                } else if (video.mediaType == "IMAGE") {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.imageDetailsScreen,
                                    arguments: {'id': video.id},
                                  );
                                } else if (video.mediaType == "VIDEO") {
                                  Navigator.pushNamed(
                                    context,
                                    RoutesName.prescibedDetailsScreen,
                                    arguments: {'id': video.id},
                                  );
                                }
                              },
                              child: Container(
                                padding: EdgeInsets.all(8.sp),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: const Color(0xffD3D4D2),
                                  ),
                                  borderRadius: BorderRadius.circular(12.r),
                                ),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(
                                          8.r,
                                        ),
                                        child: video.mediaType == "PDF"
                                            ? Container(
                                                width: double.infinity,
                                                color: Colors.grey[200],
                                                child: Center(
                                                  child: Icon(
                                                    Icons.picture_as_pdf,
                                                    size: 40.sp,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                              )
                                            : CachedNetworkImage(
                                                imageUrl:
                                                    video.thumbnailUrl ?? "",
                                                width: double.infinity,
                                                fit: BoxFit.cover,
                                                placeholder: (context, url) =>
                                                    const Center(
                                                      child:
                                                          CircularProgressIndicator(),
                                                    ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Center(
                                                          child: Icon(
                                                            Icons.error,
                                                          ),
                                                        ),
                                              ),
                                      ),
                                    ),
                                    8.verticalSpace,
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            video.title ?? "",
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: getMedium500Style12(
                                              color: ColorManager.subtextColor,
                                              fontSize: 16.sp,
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: 4.w),
                                        GestureDetector(
                                          onTap: () async {
                                              // Optimistic UI update instantly
                                              ref
                                                  .read(suggestedNotifierProvider.notifier)
                                                  .toggleSuggestedFavourite(video.id!);

                                              try {
                                                await ref
                                                    .read(favouriteIdProvider.notifier)
                                                    .favouriteId(id: video.id!);

                                                ref
                                                    .read(favouriteProvider.notifier)
                                                    .getFavourite();
                                                
                                                Fluttertoast.showToast(msg: 'Bookmark updated');
                                              } catch (e) {
                                                // Revert optimistic update on failure
                                                ref
                                                    .read(suggestedNotifierProvider.notifier)
                                                    .toggleSuggestedFavourite(video.id!);
                                                Fluttertoast.showToast(msg: 'Failed to update bookmark');
                                              }
                                          },
                                          child: Image.asset(
                                            isBookmarked ? IconManager.bookMarkFill : IconManager.bookMark,
                                            height: 16.h,
                                            color: isBookmarked ? ColorManager.backgroundColorgreen : ColorManager.subtextColorGrey,
                                          ),
                                        ),
                                      ],
                                    ),
                                    if (video.mediaType == "VIDEO" ||
                                        video.mediaType == null) ...[
                                      4.verticalSpace,
                                      Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Image.asset(
                                            IconManager.clock,
                                            height: 14.h,
                                            width: 14.w,
                                          ),
                                          SizedBox(width: 4.w),
                                          Flexible(
                                            child: FittedBox(
                                              fit: BoxFit.scaleDown,
                                              alignment: Alignment.centerLeft,
                                              child: Text(
                                                _formatDuration(video.duration),
                                                maxLines: 1,
                                                style: getMedium500Style10(
                                                  color: ColorManager
                                                      .subtextColorGrey,
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      SizedBox(height: 15.h),
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

  String _formatDuration(int? durationInSeconds) {
    if (durationInSeconds == null || durationInSeconds <= 0) return "0 sec";
    int minutes = durationInSeconds ~/ 60;
    int seconds = durationInSeconds % 60;
    if (minutes > 0 && seconds > 0) {
      return "$minutes min $seconds sec";
    } else if (minutes > 0) {
      return "$minutes min";
    } else {
      return "$seconds sec";
    }
  }
}
