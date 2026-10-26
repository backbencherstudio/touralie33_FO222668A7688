import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/data/sources/local/shared_preference/shared_preference.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customTextField.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/viewmodel/signin_viewmodel.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/successfull_screen/viewmodel/email_otp_verify_provider.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  DateTime? _lastPressedAt;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final signInState = ref.watch(signInViewModelProvider);
    final isEyeon = ref.watch(eyeSecure);
    final isCheck = ref.watch(checkIcon);

    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, result) {
        if (didPop) {
          return;
        }
        final now = DateTime.now();
        if (_lastPressedAt == null ||
            now.difference(_lastPressedAt!) > const Duration(seconds: 2)) {
          _lastPressedAt = now;
          Fluttertoast.showToast(msg: "Press back again to exit");
        } else {
          SystemNavigator.pop();
        }
      },
      child: Scaffold(
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [ColorManager.primary, ColorManager.primarygrey],
            ),
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20.w),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 100.h),
                  Text(
                    "Welcome Back",
                    style: TextStyle(
                      fontSize: 24.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Login to your account below",
                    style: TextStyle(fontSize: 14.sp, color: Colors.grey),
                  ),

                  SizedBox(height: 40.h),

                  Container(
                    padding: EdgeInsets.all(16.r),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(15.r),
                      boxShadow: [
                        BoxShadow(color: Colors.black12, blurRadius: 10),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Email Address"),
                        SizedBox(height: 8.h),

                        CustomTextField(
                          controller: _emailController,
                          hintText: "alexa.mate@example.com",
                        ),

                        SizedBox(height: 15.h),
                        Text("Password"),
                        SizedBox(height: 8.h),

                        CustomTextField(
                          controller: _passwordController,
                          hintText: "enter your password",
                          obscureText: isEyeon,
                          suffixIcon: IconButton(
                            onPressed: () =>
                                ref.read(eyeSecure.notifier).state = !isEyeon,
                            icon: Icon(
                              isEyeon ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                        ),

                        SizedBox(height: 15.h),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () =>
                                  ref.read(checkIcon.notifier).state = !isCheck,
                              child: Row(
                                children: [
                                  Icon(
                                    isCheck
                                        ? Icons.check_box
                                        : Icons.check_box_outline_blank,
                                  ),
                                  SizedBox(width: 5),
                                  Text("Remember Me"),
                                ],
                              ),
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  RoutesName.forgotPassword,
                                );
                              },
                              child: Text(
                                "Forgot Password?",
                                style: TextStyle(color: Colors.green),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 30.h),

                        Customebutton(
                          text: signInState.isLoading
                              ? "Verifying..."
                              : "Login",
                          onTap: signInState.isLoading
                              ? null
                              : () async {
                                  if (_emailController.text.isEmpty ||
                                      _passwordController.text.isEmpty) {
                                    Fluttertoast.showToast(
                                      msg: "Email and Password are required",
                                    );
                                    return;
                                  }
                                  final storedFcmToken =
                                      await SharedPreferenceData.getFcmToken();
                                  final success = await ref
                                      .read(signInViewModelProvider.notifier)
                                      .signIn(
                                        email: _emailController.text.trim(),
                                        password: _passwordController.text
                                            .trim(),
                                        fcmToken: storedFcmToken,
                                      );
                                  print(
                                    "--- Stored FCM Token: $storedFcmToken ---",
                                  );
                                  log(
                                    "--- Stored FCM Token: $storedFcmToken ---",
                                  );
                                  if (success) {
                                    final fcmToken =
                                        await SharedPreferenceData.getFcmToken();
                                    log(
                                      'FCM Token: ${fcmToken ?? "Not available"}',
                                    );
                                    Navigator.pushReplacementNamed(
                                      context,
                                      RoutesName.parentScreen,
                                    );
                                  } else {
                                    final latestState = ref.read(
                                      signInViewModelProvider,
                                    );
                                    if (latestState.isUnverified) {
                                      final unverifiedEmail =
                                          latestState.email ??
                                          _emailController.text.trim();
                                      ref
                                          .read(emailOtpVerifyProvider.notifier)
                                          .resendOtp(email: unverifiedEmail);
                                      if (context.mounted) {
                                        Navigator.pushNamed(
                                          context,
                                          RoutesName.emailOtpVerify,
                                          arguments: unverifiedEmail,
                                        );
                                      }
                                    } else {
                                      Fluttertoast.showToast(
                                        msg:
                                            latestState.errorMessage ??
                                            "Login Failed!",
                                      );
                                    }
                                  }
                                },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 30.h),

                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(
                      horizontal: 14.w,
                      vertical: 12.h,
                    ),
                    decoration: BoxDecoration(
                      color: ColorManager.primaryLight,
                      borderRadius: BorderRadius.circular(12.r),
                      border: Border.all(
                        color: ColorManager.drawrColor.withValues(alpha: 0.25),
                      ),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20.sp,
                          color: ColorManager.drawrColor,
                        ),
                        SizedBox(width: 10.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Don't have an account?",
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w600,
                                  color: ColorManager.titleText,
                                ),
                              ),
                              SizedBox(height: 4.h),
                              Text(
                                "Accounts are created from the admin dashboard. Please contact your clinic to receive your login credentials.",
                                style: TextStyle(
                                  fontSize: 12.sp,
                                  color: ColorManager.subtitleText1,
                                  height: 1.4,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
