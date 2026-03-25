import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/data/models/favourite_model.dart';
import 'package:touralie33_fo222668a7688/presentation/favourite_screen/viewModel/favourite_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/bottomSheet/bottomSheet_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/suggestion_video/suggestion_video_widget.dart';

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
                      gridDelegate:
                          SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10.w,
                        mainAxisSpacing: 10.h,
                        mainAxisExtent: 182.h,
                      ),
                      itemBuilder: (context, index) {
                        final item = data[index];
                        return SuggestionVideoWidget(
                          id: item.id,
                          duration: "${item.duration ?? 0} min",
                          categoryName: item.category ?? "Categories Name",
                          title: item.title ?? "Back Mobility Program",
                          level: item.level ?? "Beginner",
                          imageUrl: item.thumbnailUrl ?? ImageManager.gymGuide,
                          isBookmarked: true,
                          bookmarkIconColor: ColorManager.blackColor,
                          videoCountText:
                              "${item.chaptersCount ?? 0} Videos",
                          progressText: "${index + 1}/${data.length}",
                          onPlayTap: () {
                            Navigator.pushNamed(
                              context,
                              RoutesName.prescibedDetailsScreen,
                              arguments: {
                                'id': item.id,
                              },
                            );
                          },
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
}
