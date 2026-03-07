import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 5),(){
      if(mounted){

        Navigator.pushReplacementNamed(context, RoutesName.onboardingScreen);
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
         
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorManager.primary, 
                  Colors.white, 
                ],
              ),
            ),
          ),

        
          Positioned(
            bottom: 0,
            child: Center(
              child: Container(
             
               
                child: Image.asset(
                  ImageManager.vector,
                  width: 1.sw, 
                  fit: BoxFit.contain,
                ),
              ),
            ),
          ),

        
          Positioned(
            bottom: 230.r,
            left: 0,
            right: 0,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                 
                  Image.asset(
                    ImageManager.splash,
                    width: 150.w,
                    height: 150.h,
                  ),
                  
                  SizedBox(height: 50.h), 
                  
                
                  const CircularProgressIndicator(
                    color: Color(0xFF4CAF50), 
                    strokeWidth: 3,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}