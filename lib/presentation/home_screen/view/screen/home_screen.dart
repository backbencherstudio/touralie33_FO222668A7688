import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customeAppBarHome/custome_app_bar_home.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/drawer/drawer_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/remaining_progress/remaining_progress_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/workout_widget/workout_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      drawer: const DrawerScreen(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Builder(
              builder: (appBarContext) => CustomeAppBarHome(
                onProfileTap: () => Scaffold.of(appBarContext).openDrawer(),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RemainingProgressWidget(),
            SizedBox(height: 15.h,),
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: 16.w),
              child: Text("Your Prescribed Video",style: getMedium500Style12(color: ColorManager.subtextColor,fontSize:18.sp,fontWeight: FontWeight.w500 ),),
            ),
            Padding(
              padding:  EdgeInsets.all(16.r),
              child: WorkoutWidget(),
            )
          ],
        ),
      ),
    );
  }
}
