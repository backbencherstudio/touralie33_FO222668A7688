import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/notification/notification_screen.dart';

class CustomeAppBarHome extends StatelessWidget {
  final VoidCallback? onProfileTap;
  final String? name;
  final String? email;
  final String? avatarUrl;

  const CustomeAppBarHome({
    super.key,
    this.onProfileTap,
    this.name,
    this.email,
    this.avatarUrl,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
       
        Row(
          crossAxisAlignment: CrossAxisAlignment.center, 
          children: [
             GestureDetector(
              onTap: () {
                onProfileTap?.call();
              },
             child: Container(
                height: 42.h,
                width: 42.w,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                    image: (avatarUrl != null && avatarUrl!.trim().isNotEmpty)
                        ? NetworkImage(avatarUrl!.trim())
                        : const AssetImage(ImageManager.profilePic),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(width: 12.w),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  (name != null && name!.trim().isNotEmpty) ? name!.trim() : "Jannatul",
                  style: getMedium500Style18(
                    color: ColorManager.subtextColor,
                    fontSize: 16.sp,
                  ),
                ),
                Text(
                  (email != null && email!.trim().isNotEmpty)
                      ? email!.trim()
                      : "jannatul@gmail.com",
                  style: getMedium500Style10(
                    color: const Color(0xFFA2A1A1), 
                    fontSize: 12.sp,
                  ),
                ),
              ],
            )
          ],
        ),

        NotificationScreen()
      ],
    );
  }
}
