import 'dart:io';
import 'package:dio/dio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/favourite_screen/viewModel/favourite_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/favourite_id_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/suggested_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/prescribed_screen/viewModel/prescribed_details_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';

Future<void> downloadPdf(String url, String title) async {
  try {
    Fluttertoast.showToast(msg: "Downloading PDF...");



    Directory? directory;
    if (Platform.isAndroid) {
      directory = Directory('/storage/emulated/0/Download');
      if (!await directory.exists()) {
        directory = await getExternalStorageDirectory();
      }
    } else {
      directory = await getApplicationDocumentsDirectory();
    }

    if (directory != null) {
      String fileName = title.replaceAll(' ', '_');
      if (fileName.isEmpty) fileName = 'document';
      String savePath = "${directory.path}/$fileName.pdf";

      await Dio().download(url, savePath);
      Fluttertoast.showToast(msg: "Saved to Downloads");
    } else {
      Fluttertoast.showToast(msg: "Could not access storage");
    }
  } catch (e) {
    Fluttertoast.showToast(msg: "Download failed");
  }
}


class PdfDetailsScreen extends ConsumerStatefulWidget {
  const PdfDetailsScreen({super.key, this.id, this.title});
  final String? id;
  final String? title;

  @override
  ConsumerState<PdfDetailsScreen> createState() => _PdfDetailsScreenState();
}

class _PdfDetailsScreenState extends ConsumerState<PdfDetailsScreen> {
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
              child: Customebar(text: "PDF Details"),
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
              child: Customebar(text: "PDF Details"),
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
              child: Customebar(text: "PDF Details"),
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

    final currentImageUrl = workout.thumbnailUrl;
    final isBookmarked = workout.isFavorite ?? false;

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(
              ontap: () => Navigator.pop(context),
              text: widget.title ?? "PDF Details",
              showNotification: false,
              trailing: IconButton(
                icon: Icon(Icons.download, color: ColorManager.textPrimary),
                onPressed: () {
                  if (workout.url != null && workout.url!.isNotEmpty) {
                    downloadPdf(workout.url!, workout.title ?? "PDF Document");
                  } else {
                    Fluttertoast.showToast(msg: "No PDF URL found");
                  }
                },
              ),
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
                        GestureDetector(
                          onTap: () {
                            if (workout.url != null &&
                                workout.url!.isNotEmpty) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => PdfViewerScreen(
                                    url: workout.url!,
                                    title: workout.title ?? "PDF Document",
                                  ),
                                ),
                              );
                            }
                          },
                          child: Stack(
                            alignment: Alignment.center,
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(12.r),
                                child:
                                    (currentImageUrl != null &&
                                        currentImageUrl.isNotEmpty)
                                    ? CachedNetworkImage(
                                        imageUrl: currentImageUrl,
                                        width: double.infinity,
                                        height: 200.h,
                                        fit: BoxFit.cover,
                                        placeholder: (context, url) =>
                                            const Center(
                                              child: Padding(
                                                padding: EdgeInsets.all(40.0),
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                        errorWidget: (context, url, error) =>
                                            _buildPdfPlaceholder(),
                                      )
                                    : _buildPdfPlaceholder(),
                              ),
                              Container(
                                padding: EdgeInsets.all(16.r),
                                decoration: const BoxDecoration(
                                  color: Colors.black54,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.picture_as_pdf,
                                  color: Colors.white,
                                  size: 40.sp,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                workout.title ?? "PDF Details",
                                style: getMedium500Style12(
                                  color: ColorManager.textPrimary,
                                  fontSize: 20.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                            SizedBox(width: 12.w),
                            GestureDetector(
                              onTap: () async {
                                if (workout.id == null || workout.id!.isEmpty)
                                  return;
                                try {
                                  // Optimistic UI update
                                  ref
                                      .read(suggestedNotifierProvider.notifier)
                                      .toggleSuggestedFavourite(workout.id!);
                                  ref
                                      .read(
                                        prescribedDetailsNotifierProvider
                                            .notifier,
                                      )
                                      .togglePrescribedFavourite();

                                  try {
                                    await ref
                                        .read(favouriteIdProvider.notifier)
                                        .favouriteId(id: workout.id!);
                                    await ref
                                        .read(favouriteProvider.notifier)
                                        .getFavourite();

                                    Fluttertoast.showToast(
                                      msg: 'Bookmark updated',
                                    );
                                  } catch (e) {
                                    // Revert optimistic update
                                    ref
                                        .read(
                                          suggestedNotifierProvider.notifier,
                                        )
                                        .toggleSuggestedFavourite(workout.id!);
                                    ref
                                        .read(
                                          prescribedDetailsNotifierProvider
                                              .notifier,
                                        )
                                        .togglePrescribedFavourite();
                                    Fluttertoast.showToast(msg: "Error: $e");
                                  }
                                } catch (e) {
                                  Fluttertoast.showToast(msg: "Error: $e");
                                }
                              },
                              child: Image.asset(
                                isBookmarked
                                    ? IconManager.bookMarkFill
                                    : IconManager.bookMark,
                                height: 16.h,
                                color: isBookmarked
                                    ? ColorManager.backgroundColorgreen
                                    : null,
                              ),
                            ),
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

  Widget _buildPdfPlaceholder() {
    return Container(
      width: double.infinity,
      height: 200.h,
      color: Colors.grey[200],
    );
  }
}

class PdfViewerScreen extends StatelessWidget {
  final String url;
  final String title;

  const PdfViewerScreen({Key? key, required this.url, required this.title})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(
              ontap: () => Navigator.pop(context),
              text: title,
              showNotification: false,
              trailing: IconButton(
                icon: Icon(Icons.download, color: ColorManager.textPrimary),
                onPressed: () {
                  downloadPdf(url, title);
                },
              ),
            ),
          ),
        ),
      ),
      body: PDF().cachedFromUrl(
        url,
        placeholder: (double progress) =>
            const Center(child: CircularProgressIndicator()),
        errorWidget: (dynamic error) => Center(child: Text(error.toString())),
      ),
    );
  }
}
