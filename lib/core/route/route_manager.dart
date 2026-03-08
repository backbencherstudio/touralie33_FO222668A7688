import 'package:flutter/material.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/forget_password/view/forgot_password.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/new_password_screen/view/screen/new_password_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/otp/view/otp_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/signin_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signup/view/signup_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/onboarding_screen_weight/view/screen.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/view/screen.dart';
import 'package:touralie33_fo222668a7688/presentation/onboarding_screen/welcome_screen/view/welcome_screen.dart';
import 'package:touralie33_fo222668a7688/presentation/parent_screen/parent_screen.dart';

import '../../presentation/bottom_nav/view/bottom_nav_bar_screen.dart';
import '../../presentation/splash/view/splash_screen.dart';
import '../resource/constants/strings_manager.dart';
import 'routes_name.dart';



class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings routeSettings) {
    switch (routeSettings.name) {
      case RoutesName.splashRoute:
        return MaterialPageRoute(builder: (_) => const SplashScreen());
      case RoutesName.bottomNavRoute:
        return MaterialPageRoute(builder: (_) => BottomNavBarScreen());
      case RoutesName.onboardingScreen :
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case RoutesName.onBordingScreenWeight:
        return MaterialPageRoute(builder: (_) => OnBordingScreenWeight());
      case RoutesName.welcomeScreen:
        return MaterialPageRoute(builder: (_) => WelcomeScreen());
      case RoutesName.signInScreen:
        return MaterialPageRoute(builder: (_) => SigninScreen());
      case RoutesName.forgotPassword:
        return MaterialPageRoute(builder: (_) => ForgotPassword());
      case RoutesName.otpScreen:
        return MaterialPageRoute(builder: (_) => OtpScreen());
      case RoutesName.newPasswordScreen:
        return MaterialPageRoute(builder: (_) => NewPasswordScreen());
      case RoutesName.singInUpScreen:
        return MaterialPageRoute(builder: (_) => SingInUpScreen());
      case RoutesName.parentScreen:
        return MaterialPageRoute(builder: (_) => ParentScreen());
     

      default:
        return unDefineRoute();
    }
  }

  static Route<dynamic> unDefineRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: Text(StringManager.noRoute)),
        body: Center(child: Text(StringManager.noRoute)),
      ),
    );
  }
}
