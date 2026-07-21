import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';

class PlayListScreenWidget extends ConsumerWidget {
  final String? id;
  final String? image;
  final String? videoCount;
  final String? title;
  final String? videoDuration;
  final String? totalTime;
  final String? buttonText, sufImage, bookMarkIcon;
  final VoidCallback? onTap;
  final Future<void> Function()? onBookmarkTap;
  final Color? buttonIconColor, colorbg;
  final Color? bookmarkIconColor;
  final bool isBookmarked;
  final bool enableBookmarkTap;

  const PlayListScreenWidget({
    super.key,
    this.id,
    this.image,
    this.videoCount,
    this.title,
    this.videoDuration,
    this.totalTime,
    this.buttonText,
    this.onTap,
    this.buttonIconColor,
    this.sufImage,
    this.colorbg,
    this.bookMarkIcon,
    this.onBookmarkTap,
    this.bookmarkIconColor,
    this.isBookmarked = false,
    this.enableBookmarkTap = true,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 6.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          color: colorbg ?? ColorManager.playlistBox,
          border: Border.all(
            color: const Color.fromARGB(255, 195, 195, 195),
            width: .8.w,
          ),
        ),
        padding: EdgeInsets.all(10.r),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // 1. Thumbnail Image
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: _buildImage(),
                  ),
                ),
                SizedBox(width: 12.w),

                // 2. Content (Title, Time, Duration, Bookmark)
                Expanded(
                  child: SizedBox(
                    height: 73.h, // Matches image height
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment
                          .center, // Centers content vertically to fix the large gap
                      children: [
                        // --- TOP SECTION: Title & Total Time ---
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Text(
                                title ?? "",
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                                style: getMedium500Style16(
                                  color: ColorManager.textPrimary,
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 8.w),
                            Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Image.asset(
                                  IconManager.clock,
                                  height: 13.h,
                                  color: ColorManager.blackColor,
                                ),
                                SizedBox(width: 4.w),
                                ConstrainedBox(
                                  constraints: BoxConstraints(maxWidth: 60.w),
                                  child: Text(
                                    totalTime ?? "",
                                    maxLines: 1,
                                    textAlign: TextAlign.end,
                                    overflow: TextOverflow.ellipsis,
                                    style: getMedium500Style12(
                                      color: ColorManager.textPrimary,
                                      fontSize: 12.sp,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),

                        // Controlled space instead of spaceBetween
                        SizedBox(height: 12.h),

                        // --- BOTTOM SECTION: Video Icon & Bookmark ---
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
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
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
                      ],
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            // 3. Custom Button
            Customebutton(
              sufImage: sufImage,
              text: buttonText,
              onTap: onTap,
              sufImageColor: buttonIconColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImage() {
    final imagePath = image ?? "";

    if (imagePath.isEmpty) {
      return _fallbackImage();
    }

    if (imagePath.startsWith('http://') || imagePath.startsWith('https://')) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        height: 73.h,
        width: 81.w,
        errorBuilder: (_, __, ___) => _fallbackImage(),
      );
    }

    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      height: 73.h,
      width: 81.w,
      errorBuilder: (_, __, ___) => _fallbackImage(),
    );
  }

  Widget _fallbackImage() {
    return Container(
      height: 73.h,
      width: 81.w,
      color: const Color.fromARGB(255, 230, 230, 230),
      alignment: Alignment.center,
      child: Icon(
        Icons.image_outlined,
        color: ColorManager.subtextColorGrey,
        size: 24.r,
      ),
    );
  }
}
