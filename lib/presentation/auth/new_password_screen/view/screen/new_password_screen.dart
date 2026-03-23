import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/forget_password/view/widget/customeApp.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/new_password_screen/viewModel/resetPassword_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customTextField.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/successfull_screen/view/widget/dialog_widget.dart';

class NewPasswordScreen extends ConsumerStatefulWidget {
  final String? email;
  final String? token;

  const NewPasswordScreen({super.key, this.email, this.token});

  @override
  ConsumerState<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends ConsumerState<NewPasswordScreen> {
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _isEyeOn = false;
  bool _isEyeOn1 = false;
  bool _isCheck = false;

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final resetState = ref.watch(resetPasswordProvider);
    return Scaffold(
       backgroundColor: ColorManager.primary,
      appBar: CustomeApp(
        text: "Change PassWord",
        onBackTap: () => Navigator.pop(context),
      ),
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
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
             
              Divider(
          color: Color.fromARGB(255, 231, 232, 231),
          thickness: 1,
        ),
        SizedBox(height: 50.h,),
              Text(
                "Enter New Password",
                style: getMedium500Style22(
                  color: ColorManager.textPrimary,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 5.h),
              Text(
                "Enter Your New Password",
                style: getMedium500Style14(
                  color: ColorManager.subtextColor,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w400,
                ),
              ),
              SizedBox(height: 38.h),
              Padding(
                padding:  EdgeInsets.all(16.r),
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.r),
                    color: Colors.white,
                    boxShadow: [
                            BoxShadow(
                color: Colors.black.withValues(alpha: .05), 
                blurRadius: 10.r,    
                spreadRadius: 2.r,   
                offset: Offset(0, 4), 
                            ),
                          ],
                  ),
                  
                  child: Padding(
                    padding: EdgeInsets.all(16.r),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "New Password",
                          style: getMedium500Style14(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          controller: _passwordController,
                          hintText: "enter your password",
                          obscureText: !_isEyeOn1,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isEyeOn1 = !_isEyeOn1;
                              });
                            },
                            icon: Icon(
                              _isEyeOn1 ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                        ),
                        SizedBox(height: 12.h),
                        Text(
                          "Re-Enter New Password",
                          style: getMedium500Style14(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomTextField(
                          controller: _confirmPasswordController,
                          hintText: "enter your password",
                          obscureText: !_isEyeOn,
                          suffixIcon: IconButton(
                            onPressed: () {
                              setState(() {
                                _isEyeOn = !_isEyeOn;
                              });
                            },
                            icon: Icon(
                              _isEyeOn ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isCheck = !_isCheck;
                                    });
                                  },
                                  child: Container(
                                    height: 18.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.r),
                                      color: _isCheck? ColorManager.backgroundColorgreen1 : null,
                                      border: Border.all(
                                        color:_isCheck? ColorManager.background : ColorManager.backgroundColorgreen,
                                        
                                      )
                                    ),
                                    child: _isCheck?  Center(
                                      child: Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 20.sp,
                                      ),
                                    ) : null
                                  ),
                                ),
                                SizedBox(width: 10.w),
                                Text(
                                  "Remember Me",
                                  style: getMedium500Style14(
                                    color: ColorManager.textPrimary,
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, RoutesName.forgotPassword);
                              },
                              child: Text(
                                "Forgot Password?",
                                style:
                                    getMedium500Style14(
                                      color: ColorManager.backgroundColorgreen1,
                                      fontSize: 16.sp,
                                    )
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 15.h),
                        if (resetState.isLoading)
                          const Center(child: CircularProgressIndicator())
                        else
                          Customebutton(
                            text: "Reset Password",
                            onTap: () async {
                              final email = widget.email?.trim();
                              final token = widget.token?.trim().toString();
                              final pass = _passwordController.text.trim();
                              final confirm = _confirmPasswordController.text.trim();

                              if (email == null ||
                                  email.isEmpty ||
                                  token == null ||
                                  token.isEmpty) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Email or token is missing')),
                                );
                                return;
                              }
                              if (pass.isEmpty || confirm.isEmpty) return;
                              if (pass != confirm) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Passwords do not match')),
                                );
                                return;
                              }

                              final ok = await ref
                                  .read(resetPasswordProvider.notifier)
                                  .resetPass(email: email, token: token, pass: pass);

                              if (!ok) {
                                if (!context.mounted) return;
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      ref.read(resetPasswordProvider).errorMessage ??
                                          'Failed to reset password',
                                    ),
                                  ),
                                );
                                return;
                              }

                              if (!context.mounted) return;
                              showDialog(
                                context: context,
                                barrierDismissible: true,
                                builder: (context) => DialogWidget(),
                              );
                            },
                          ),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              
            ],
          ),
        ),
      ),
    );
  }
}
