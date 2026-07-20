import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/presentation/prescribed_screen/viewModel/prescribed_details_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';

class PdfDetailsScreen extends ConsumerStatefulWidget {
  const PdfDetailsScreen({super.key, this.id, this.title});
  final String? id;
  final String? title;

  @override
  ConsumerState<PdfDetailsScreen> createState() => _PdfDetailsScreenState();
}

class _PdfDetailsScreenState extends ConsumerState<PdfDetailsScreen> {
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
  Widget build(BuildContext context) {
    final detailsState = ref.watch(prescribedDetailsNotifierProvider);
    final workout = detailsState.prescribedDetailsData?.data;

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
            ),
          ),
        ),
      ),
      body: Container(
        color: Colors.white,
        child: Builder(
          builder: (context) {
            if (detailsState.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (detailsState.errorMessage != null) {
              return Center(
                child: Padding(
                  padding: EdgeInsets.all(16.r),
                  child: Text(
                    detailsState.errorMessage!,
                    textAlign: TextAlign.center,
                  ),
                ),
              );
            }

            if (workout == null || workout.url == null || workout.url!.isEmpty) {
              return const Center(child: Text("No PDF available."));
            }

            return const PDF().cachedFromUrl(
              workout.url!,
              placeholder: (double progress) => const Center(child: CircularProgressIndicator()),
              errorWidget: (dynamic error) => Center(child: Text(error.toString())),
            );
          },
        ),
      ),
    );
  }
}
