import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/data/models/prescribed_model.dart';
import 'package:touralie33_fo222668a7688/presentation/playlist/viewModel/prescribed_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/play_list/playlist_screen_widget.dart';

class PlaylistScreen extends ConsumerStatefulWidget {
  const PlaylistScreen({super.key});

  @override
  ConsumerState<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends ConsumerState<PlaylistScreen> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(prescribedProvider.notifier).fetchPrescribed();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final prescribedState = ref.watch(prescribedProvider);
    final List<Data> prescribed = prescribedState.data?.data ?? [];

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(text: "Playlist", showBackIcon: false),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Divider(),
            SizedBox(height: 10.h),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 12.w),
              child: Text(
                "Watch your remaining prescribed videos",
                style: getMedium500Style12(
                  color: ColorManager.blackColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            SizedBox(height: 10.h),
            if (prescribedState.isLoading)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (prescribedState.errorMessage != null)
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Text(
                  prescribedState.errorMessage!,
                  style: getMedium500Style12(
                    color: Colors.red,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            else if (prescribed.isEmpty)
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Text(
                  "No prescribed videos found",
                  style: getMedium500Style12(
                    color: ColorManager.blackColor,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              )
            else
              ...prescribed.map(_buildPlaylistItem),
          ],
        ),
      ),
    );
  }

  Widget _buildPlaylistItem(Data data) {
    final buttonText = _getButtonText(data);
    final canOpenDetails = data.isCompleted != true;

    return PlayListScreenWidget(
      image: data.thumbnailUrl ?? ImageManager.gymGuide,
      videoCount:
          "${data.chaptersCount ?? 0} video${(data.chaptersCount ?? 0) == 1 ? '' : 's'}",
      title: data.title ?? "",
      videoDuration: "${data.duration ?? 0} min",
      totalTime: data.level ?? "",
      buttonText: buttonText,
      buttonIconColor: Colors.white,
      onTap: canOpenDetails
          ? () {
        Navigator.pushNamed(
          context,
          RoutesName.prescibedDetailsScreen,
          arguments: {
            'id': data.id,
          },
        );
      }
          : null,
    );
  }

  String _getButtonText(Data data) {
    if (data.isCompleted == true) {
      return "Completed";
    }

    if ((data.watchStatus ?? '').toUpperCase() == 'IN_PROGRESS') {
      return "In Progress";
    }

    return "Start Now";
  }
}
