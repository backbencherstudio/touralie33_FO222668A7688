import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/successfull_screen/viewmodel/email_otp_verify_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/forget_password/view/widget/customeApp.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/otp/view/widget/pinFieldWidget.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/successfull_screen/view/widget/dialog_widget.dart';
import 'package:fluttertoast/fluttertoast.dart';

class EmailOtpVerify extends ConsumerStatefulWidget {
  final String email;
  EmailOtpVerify({required this.email});

  @override
  ConsumerState<EmailOtpVerify> createState() => _EmailOtpVerifyState();
}

class _EmailOtpVerifyState extends ConsumerState<EmailOtpVerify> {
  final TextEditingController _textEditingController = TextEditingController();
  Timer? _timer;
  int _startSeconds = 120; // 2 minutes

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _startSeconds = 120;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_startSeconds == 0) {
        setState(() {
          timer.cancel();
        });
      } else {
        setState(() {
          _startSeconds--;
        });
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _textEditingController.dispose();
    super.dispose();
  }

  Future<void> _resendOtp() async {
    final email = widget.email.trim();
    if (email.isEmpty) return;

    final ok = await ref
        .read(emailOtpVerifyProvider.notifier)
        .resendOtp(email: email);
    if (ok) {
      Fluttertoast.showToast(msg: "OTP has been resent successfully");
      _startTimer();
    } else {
      final error =
          ref.read(emailOtpVerifyProvider).errorMessage ??
          "Failed to resend OTP";
      Fluttertoast.showToast(msg: error);
    }
  }

  @override
  Widget build(BuildContext context) {
    final otpState = ref.watch(emailOtpVerifyProvider);
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: CustomeApp(
        text: "Email Verification",
        onBackTap: () => Navigator.pop(context),
      ),
      body: Column(
        children: [
          const Divider(
            color: Color.fromARGB(255, 231, 232, 231),
            thickness: 1,
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 90.h),
                    Text(
                      "Enter Verification Code ",
                      style: getMedium500Style20(
                        color: ColorManager.subtextColor,
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "We have sent a code verificaiton to ",
                      style: getMedium500Style14(
                        color: ColorManager.subtextColor1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "your email address",
                      style: getMedium500Style14(
                        color: ColorManager.subtextColor1,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    SizedBox(height: 30.h),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12.r),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: .05),
                            blurRadius: 10.r,
                            spreadRadius: 2.r,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(16.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            PinFieldWidget(
                              textController: _textEditingController,
                            ),
                            SizedBox(height: 15.h),
                            Customebutton(
                              text: otpState.loading
                                  ? "Verifying..."
                                  : "Submit",
                              onTap: otpState.loading
                                  ? null
                                  : () async {
                                      final success = await ref
                                          .read(emailOtpVerifyProvider.notifier)
                                          .verifyOtpEmail(
                                            email: widget.email,
                                            otp: _textEditingController.text
                                                .trim(),
                                          );

                                      if (success) {
                                        if (!context.mounted) return;
                                        showDialog(
                                          context: context,
                                          barrierDismissible: true,
                                          builder: (BuildContext context) {
                                            return const DialogWidget(
                                              title: "Email Verification",
                                              subtitle: "Successfully",
                                              description:
                                                  "Your email address has been verified successfully.",
                                              buttonText: "Back to Login",
                                            );
                                          },
                                        );
                                      } else {
                                        Fluttertoast.showToast(
                                          msg:
                                              otpState.errorMessage ??
                                              "Verification Failed",
                                        );
                                      }
                                    },
                            ),
                            SizedBox(height: 20.h),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "Didn't receive the code? ",
                                  style: getMedium500Style14(
                                    color: ColorManager.subtextColor1,
                                  ),
                                ),
                                if (_startSeconds > 0)
                                  Text(
                                    "${(_startSeconds ~/ 60).toString().padLeft(2, '0')}:${(_startSeconds % 60).toString().padLeft(2, '0')}",
                                    style: getMedium500Style14(
                                      color: ColorManager.backgroundColorgreen1,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  )
                                else
                                  GestureDetector(
                                    onTap: _resendOtp,
                                    child: Text(
                                      "Resend OTP",
                                      style: getMedium500Style14(
                                        color:
                                            ColorManager.backgroundColorgreen1,
                                        fontWeight: FontWeight.w800,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 50.h),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
