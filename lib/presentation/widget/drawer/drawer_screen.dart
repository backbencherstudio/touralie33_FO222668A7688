import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';

class DrawerScreen extends StatelessWidget {
  const DrawerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      width: MediaQuery.of(context).size.width * 0.68,
      backgroundColor: ColorManager.drawrColor,
      child: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 18.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: CircleAvatar(
                  radius: 30.r,
                  backgroundImage: const AssetImage(ImageManager.profilePic),
                ),
              ),
              SizedBox(height: 12.h),
              Center(
                child: Text(
                  'Jannatul',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 2.h),
              Center(
                child: Text(
                  'jannatul@gmail.com',
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: .9),
                    fontSize: 13.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              SizedBox(height: 28.h),
              Text(
                'Settings',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: 14.h),
               _DrawerItem(
                ontap: () {
                          Navigator.pushReplacementNamed(context, RoutesName.subscriptionScreen);
                },
                icon: IconManager.subscriptionPlan,
                title: 'Subscribe Plan',
              ),
               _DrawerItem(icon: IconManager.security, title: 'Security'),
               _DrawerItem(
                ontap: () {
                  Navigator.pushReplacementNamed(context, RoutesName.settingScreen);
                },
                icon: IconManager.setting, title: 'Settings'),
               _DrawerItem(
                icon: IconManager.security,
                title: 'Help and support',
              ),
              const Spacer(),
               _DrawerItem(icon: IconManager.logout, title: 'Logout'),
            ],
          ),
        ),
      ),
    );
  }
}

class _DrawerItem extends StatelessWidget {
  final String icon;
  final String title;
  final VoidCallback ? ontap;

  const _DrawerItem({required this.icon, required this.title, this.ontap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 16.h),
      child: InkWell(
        onTap:ontap,
        borderRadius: BorderRadius.circular(10.r),
        child: Row(
          children: [
            Image.asset(icon,fit: BoxFit.cover,height: 16.h,width: 16.w,),
            SizedBox(width: 12.w),
            Text(
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
