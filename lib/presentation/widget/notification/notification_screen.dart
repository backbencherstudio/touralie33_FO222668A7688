import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/notification_screen/view/screen/notification_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/notification_screen/viewModel/notification_provider.dart';

class NotificationScreen extends ConsumerWidget {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final notificationState = ref.watch(notificationProvider);
    final hasNotification = (notificationState.getData?.data?.isNotEmpty ?? false);

    return GestureDetector(
          onTap: () {
            showDialog(
              context: context,
              builder: (contex) {
                return const NotificationScreen1();
              },
            );
          },
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Image.asset(
                ImageManager.notification,
                height: 28.h,
                width: 28.w,
                fit: BoxFit.contain,
              ),
              if (hasNotification)
                Positioned(
                  top: 0,
                  right: 2.w,
                  child: Container(
                    height: 10.h,
                    width: 10.w,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 1.5.w),
                    ),
                  ),
                )
            ],
          ),
        );
  }
}
