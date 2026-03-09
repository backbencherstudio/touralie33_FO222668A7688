import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/custom_video_player/Custom_video_player.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/workout_set/workOut_set.dart';

class PrescibedDetailsScreen extends StatefulWidget {
  const PrescibedDetailsScreen({super.key});

  @override
  State<PrescibedDetailsScreen> createState() => _PrescibedDetailsScreenState();
}

class _PrescibedDetailsScreenState extends State<PrescibedDetailsScreen> {
  bool _isExpanded = false;
  final String _description =
      'This Video is focused on back mobility that will help you to reduce pain, '
      'improve flexibility, and build better posture through guided movements.'
      'This Video is focused on back mobility that will help you to reduce pain, '
      ;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(text: "Your Prescribed Video"),
          ),
        ),
      ),
      body: Padding(
        padding:  EdgeInsets.all(12.r),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
              color: ColorManager.whiteColor,
              border: Border.all(
                color:ColorManager.backgroundColorgreen1 
              )
                ),
                child: Padding(
                  padding:  EdgeInsets.all(12.r),
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        CustomVideoPlayer(
                          videoUrl: 'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
                          thumbnailAsset: ImageManager.gymGuide,
                        ),
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text("Categories Name",style: getMedium500Style14(color: ColorManager.subtextColorGrey,fontSize:12.sp, ),),
                            Image.asset(IconManager.bookMark,height: 16.h,)
                          ],
                        ),
                        SizedBox(height: 5.h,),
                        Text("Back Mobility Program",style: getMedium500Style12(color: ColorManager.textPrimary,fontSize: 20.sp,fontWeight: FontWeight.w500),),
                        SizedBox(height: 5.h,),
                        RichText(
                          text: TextSpan(
                            style: getRegular400Style14(
                              color: const Color.fromARGB(255, 92, 92, 92),
                              fontSize: 13.sp,
                              fontWeight: FontWeight.w400,
                              
                            ).copyWith(
                              height: 1.6,        
                      letterSpacing: 0.5,
                            ),
                            children: [
                              TextSpan(
                                text: _isExpanded
                                    ? _description
                                    : '${_description.substring(0, 126)}... ',
                              ),
                              TextSpan(
                                text: _isExpanded ? 'Read Less' : 'Read More',
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
                        SizedBox(height: 10.h,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                Image.asset(IconManager.clock,width: 16.w,height: 19.h,fit: BoxFit.cover,),SizedBox(width: 8.w,),
                                Text("45 min",style: getMedium500Style10(color: ColorManager.textPrimary,fontSize: 14.sp,fontWeight: FontWeight.w400),)
                              ],
                            ),
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.r),
                                color: ColorManager.drawrColor.withValues(alpha: .4),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text("Beginner",style: getMedium500Style14(color: ColorManager.textPrimary,fontSize:10.sp,fontWeight: FontWeight.w500 ),),
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: 10.h,),
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            color: ColorManager.whiteColor,
                            border: Border.all(
                              color: ColorManager.backgroundColorgreen,
                              width: .5.w
                            )
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(12.r),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  Text("Workout Set",style: getMedium500Style12(color: ColorManager.textPrimary,fontSize:16.sp,fontWeight: FontWeight.w600 ),)
                                   ,Row(
                                    children: [
                                      Image.asset(IconManager.videoICon,fit: BoxFit.cover,height: 13.h,),SizedBox(width: 4.w,),
                                      Text("1/4 videos",style: getMedium500Style16(color: ColorManager.textPrimary,fontSize: 13.sp,fontWeight: FontWeight.w400),)
                                    ],
                                   )
                                
                                ],),
                                SizedBox(height: 10.h,),
                                WorkoutSet(
                                  mainImage: ImageManager.gymGuide,
                                  duration: "10 min",
                                  title: "Introduction to the class",
                                  iconBgColor: ColorManager.backgroundColorgreen,
                                  borderColor: ColorManager.backgroundColorgreen1,
                                ),
                                SizedBox(height: 15.h,),
                                  WorkoutSet(
                                  mainImage: ImageManager.gymGuide,
                                  duration: "20 min",
                                  title: "Warm up Session",
                                
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 15.h,),
                        Customebutton(
                          text:"Watch Now",
                          textColor: ColorManager.whiteColor,
                          color: ColorManager.blackColor,
                          sufImage: IconManager.playButton,
                          sufImageColor: ColorManager.whiteColor,
                        )
                      ],
                    ),
                   
                  ),
                ),
              
              ),
              SizedBox(height: 70.h,)
            ],
          ),
        ),
       
      
      )
    );
  }
}
