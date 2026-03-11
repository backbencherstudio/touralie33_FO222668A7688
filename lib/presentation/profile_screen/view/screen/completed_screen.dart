import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/play_list/playlist_screen_widget.dart';

class CompletedScreen extends StatelessWidget {
  const CompletedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: [
          PlayListScreenWidget(
                image: ImageManager.gymGuide,
                videoCount: "0/4 videos",
                title: "Back Mobility Program",
                videoDuration: "45 min",
                totalTime: "45 min",
                buttonText: "Completed",
            
              
                buttonIconColor: Colors.black,
                colorbg: Color(0XFFF5F9F1),
                
                bookMarkIcon:IconManager.bookMarkFill,
                onTap: () {
                  print("Button Clicked!");
                },
              ),
             
          PlayListScreenWidget(
                image: ImageManager.gymGuide,
                videoCount: "0/4 videos",
                title: "Back Mobility Program",
                videoDuration: "45 min",
                totalTime: "45 min",
                buttonText: "Completed",
            
              
                buttonIconColor: Colors.black,
                colorbg: Color(0XFFF5F9F1),
                
                bookMarkIcon:IconManager.bookMarkFill,
                onTap: () {
                  print("Button Clicked!");
                },
              ),
          PlayListScreenWidget(
                image: ImageManager.gymGuide,
                videoCount: "0/4 videos",
                title: "Back Mobility Program",
                videoDuration: "45 min",
                totalTime: "45 min",
                buttonText: "Completed",
             
              
                buttonIconColor: Colors.black,
                colorbg: Color(0XFFF5F9F1),
                
                bookMarkIcon:IconManager.bookMarkFill,
                onTap: () {
                  print("Button Clicked!");
                },
              ),
        ],
      ),
    );
  }
}