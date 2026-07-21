import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/data/models/favourite_model.dart';
import 'package:touralie33_fo222668a7688/presentation/favourite_screen/viewModel/favourite_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/favourite_id_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/suggested_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/bottomSheet/bottomSheet_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cached_network_image/cached_network_image.dart';

class FavouriteScreen extends ConsumerStatefulWidget {
  const FavouriteScreen({super.key});
  @override
  ConsumerState<FavouriteScreen> createState() => _FavouriteScreenState();
}

class _FavouriteScreenState extends ConsumerState<FavouriteScreen> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(favouriteProvider.notifier).getFavourite();
    });
  }

  @override
  Widget build(BuildContext context) {
    final favouriteState = ref.watch(favouriteProvider);
    final List<Data> data = favouriteState.getData?.data ?? [];

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(text: "Bookmark", showBackIcon: false),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: [
            Divider(color: ColorManager.beginerColor),
            SizedBox(height: 15.h),
            Padding(
              padding: EdgeInsets.all(12.r),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Your Favourite",
                        style: getLight300Style12(
                          color: ColorManager.textPrimary,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            backgroundColor: ColorManager.playlistBox,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(25.r),
                                topRight: Radius.circular(25.r),
                              ),
                            ),
                            builder: (context) {
                              return BottomsheetWidget();
                            },
                          );
                        },
                        child: Image.asset(
                          IconManager.filter,
                          fit: BoxFit.cover,
                          height: 20.h,
                          width: 20.w,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 11.h),
                  if (favouriteState.isloading)
                    const Padding(
                      padding: EdgeInsets.all(24),
                      child: Center(child: CircularProgressIndicator()),
                    )
                  else if (favouriteState.errormessage != null)
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Text(
                        favouriteState.errormessage!,
                        textAlign: TextAlign.center,
                        style: getMedium500Style12(
                          color: Colors.red,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  else if (data.isEmpty)
                    Padding(
                      padding: EdgeInsets.all(16.r),
                      child: Text(
                        "No favourite videos found",
                        style: getMedium500Style12(
                          color: ColorManager.textPrimary,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    )
                  else
                    GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.all(10),
                      itemCount: data.length,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        mainAxisExtent: 182.h,
                      ),
                      itemBuilder: (context, index) {
                        final item = data[index];
                        final isBookmarked = item.isFavorite ?? true; // In Favourite screen, it defaults to true

                        return GestureDetector(
                          onTap: () {
                            if (item.mediaType == "PDF") {
                              Navigator.pushNamed(
                                context,
                                RoutesName.pdfDetailsScreen,
                                arguments: {
                                  'id': item.id,
                                  'title': item.title,
                                },
                              );
                            } else if (item.mediaType == "IMAGE") {
                              Navigator.pushNamed(
                                context,
                                RoutesName.imageDetailsScreen,
                                arguments: {'id': item.id},
                              );
                            } else {
                              Navigator.pushNamed(
                                context,
                                RoutesName.prescibedDetailsScreen,
                                arguments: {'id': item.id},
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
                                    child: item.mediaType == "PDF"
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
                                                item.thumbnailUrl ?? "",
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
                                        item.title ?? "",
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
                                        try {
                                          await ref
                                              .read(favouriteIdProvider.notifier)
                                              .favouriteId(id: item.id!);
                                          ref
                                              .read(suggestedNotifierProvider.notifier)
                                              .addSuggestedFromFavourite(item);
                                          await ref
                                              .read(favouriteProvider.notifier)
                                              .getFavourite();
                                          if (context.mounted) {
                                            Fluttertoast.showToast(msg: 'Bookmark updated');
                                          }
                                        } catch (_) {
                                          if (context.mounted) {
                                            Fluttertoast.showToast(
                                              msg: 'Failed to update bookmark',
                                            );
                                          }
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
                                if (item.mediaType == "VIDEO" ||
                                    item.mediaType == null) ...[
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
                                            _formatDuration(item.duration),
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
                ],
              ),
            ),
          ],
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
