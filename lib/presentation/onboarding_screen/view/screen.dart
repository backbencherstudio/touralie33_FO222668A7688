import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_birthday/view/onboarding_screen_birthday.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_brings/view/onboarding_screen_brigns.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_gender/view/onboarding_screen_gender.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_height/view/onboarding_screen_height.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_weight/view/screen.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_weight/view/widget/custome_appBar.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/welcome_screen/view/welcome_screen.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;
  int totalPages = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: CustomeAppbar(
        onBackTap: () {
          if (_currentPage > 0) {
            _pageController.previousPage(
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          }
        },
      ),
      body: SafeArea(
        child: Column(
          children: [
           
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Row(
                children: List.generate(totalPages, (index) {
                  return Expanded(
                    child: Container(
                      height: 4,
                      margin: EdgeInsets.symmetric(horizontal: 2),
                      decoration: BoxDecoration(
                        color: index == _currentPage 
                            ? Color(0xFF98D14F) 
                            : Colors.grey.withOpacity(0.2), 
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  );
                }),
              ),
            ),

            // Page View
            Expanded(
              child: PageView(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                   OnBordingScreenWeight(),
                  OnboardingScreenHeight(),
                  OnboardingScreenBirthday(),
                  OnboardingScreenGender(),
                  OnboardingScreenBrigns(),
                ],
              ),
            ),

            // Continue Button
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    if (_currentPage < totalPages - 1) {
                      _pageController.nextPage(
                        duration: Duration(milliseconds: 300),
                        curve: Curves.easeInOut,
                      );
                    }
                    else{
                      Navigator.pushReplacementNamed(context,RoutesName.welcomeScreen);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF98D14F),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Continue",
                        style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 10),
                      Image.asset(IconManager.arrowRight,height: 16.h,width: 16.w,)
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}