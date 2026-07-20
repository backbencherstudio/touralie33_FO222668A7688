import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/prescribed_screen/viewModel/prescribed_details_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';

class ImageDetailsScreen extends ConsumerStatefulWidget {
  const ImageDetailsScreen({super.key, this.id});

  final String? id;

  @override
  ConsumerState<ImageDetailsScreen> createState() => _ImageDetailsScreenState();
}

class _ImageDetailsScreenState extends ConsumerState<ImageDetailsScreen> {
  final ScrollController _scrollController = ScrollController();
  bool _isExpanded = false;
  late final PrescribedDetailsProvider _prescribedDetailsNotifier;

  @override
  void initState() {
    super.initState();
    _prescribedDetailsNotifier = ref.read(
      prescribedDetailsNotifierProvider.notifier,
    );
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final id = widget.id;
      if (id != null && id.isNotEmpty) {
        _prescribedDetailsNotifier.getPresCribedDetails(id: id);
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
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
              child: Customebar(text: "View Image"),
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
              child: Customebar(text: "View Image"),
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
              child: Customebar(text: "View Image"),
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

    final description = workout.description ?? '';
    final shortDescription = description.length > 126
        ? '${description.substring(0, 126)}... '
        : description;
    // final categoryText = workout.category ?? "All";

    final currentImageUrl = workout.thumbnailUrl ?? workout.url;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(
              ontap: () => Navigator.pop(context),
              text: "View Image",
            ),
          ),
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
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
                        ClipRRect(
                          borderRadius: BorderRadius.circular(12.r),
                          child:
                              (currentImageUrl != null &&
                                  currentImageUrl.isNotEmpty)
                              ? CachedNetworkImage(
                                  imageUrl: currentImageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.contain,
                                  placeholder: (context, url) => const Center(
                                    child: Padding(
                                      padding: EdgeInsets.all(40.0),
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                        ImageManager.gymGuide,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      ),
                                )
                              : Image.asset(
                                  ImageManager.gymGuide,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                workout.title ?? "Image Details",
                                style: getMedium500Style12(
                                  color: ColorManager.textPrimary,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            Image.asset(IconManager.bookMark, height: 16.h),
                          ],
                        ),
                        SizedBox(height: 5.h),

                        if (description.isNotEmpty) ...[
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
                                  text: _isExpanded
                                      ? description
                                      : shortDescription,
                                ),
                                if (description.length > 126)
                                  TextSpan(
                                    text: _isExpanded
                                        ? 'Read Less'
                                        : 'Read More',
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
                        ],
                        SizedBox(height: 10.h),
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
