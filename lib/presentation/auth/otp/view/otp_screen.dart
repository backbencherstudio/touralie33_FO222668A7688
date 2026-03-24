import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/forget_password/view/widget/customeApp.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/otp/view/widget/pinFieldWidget.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/otp/viewmodel/otp_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';

class OtpScreen extends ConsumerStatefulWidget {
  final String ? email;

  const OtpScreen({super.key, this.email,});

  @override
  ConsumerState<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends ConsumerState<OtpScreen> {
  final TextEditingController _textEditingController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final otpState = ref.watch(otpProvider);
    final email = widget.email?.trim();

    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: CustomeApp(
        text: "Change PassWord",
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
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(height: 8.h),
                    Text(
                      "We have sent a code verificaiton to ",
                      style: getMedium500Style14(
                          color: ColorManager.subtextColor1,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      email != null && email.isNotEmpty ? email : "your email address",
                      style: getMedium500Style14(
                          color: ColorManager.subtextColor1,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w400),
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
                            PinFieldWidget(textController: _textEditingController),
                            SizedBox(height: 15.h),
                            if (otpState.isLoading || _isSubmitting)
                              const Center(child: CircularProgressIndicator())
                            else
                              Customebutton(
                                text: "Submit",
                                onTap: () async {
                                  if (_isSubmitting || otpState.isLoading) return;

                                  final token = _textEditingController.text.trim();
                                  final currentEmail = widget.email?.trim();

                                  if (currentEmail == null || currentEmail.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Email is missing')),
                                    );
                                    return;
                                  }
                                  if (token.isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Please enter token')),
                                    );
                                    return;
                                  }

                                  setState(() {
                                    _isSubmitting = true;
                                  });

                                  try {
                                    final ok = await ref
                                        .read(otpProvider.notifier)
                                        .verifyOtp(email: currentEmail, token: token);

                                    if (!ok) {
                                      if (!context.mounted) return;
                                      ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                          content: Text(
                                            ref.read(otpProvider).errorMessage ??
                                                'OTP verification failed',
                                          ),
                                        ),
                                      );
                                      return;
                                    }

                                    if (!context.mounted) return;
                                    Navigator.pushNamed(
                                      context,
                                      RoutesName.newPasswordScreen,
                                      arguments: {
                                        'email': currentEmail,
                                        'token': ref.read(otpProvider).resetToken ?? token,
                                      },
                                    );
                                  } finally {
                                    if (mounted) {
                                      setState(() {
                                        _isSubmitting = false;
                                      });
                                    }
                                  }
                                },
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
