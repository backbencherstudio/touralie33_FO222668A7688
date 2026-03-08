import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customTextField.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';

final eyeSecure = StateProvider<bool>((ref) => false);
final checkIcon = StateProvider<bool>((ref) => false);

class SingInUpScreen extends ConsumerStatefulWidget {
  const SingInUpScreen({super.key});

  @override
  ConsumerState<SingInUpScreen> createState() => _SingInUpScreenState();
}

class _SingInUpScreenState extends ConsumerState<SingInUpScreen> {
  @override
  Widget build(BuildContext context) {
    final isEyeon = ref.watch(eyeSecure);
    final isCheck = ref.watch(checkIcon);
    return Scaffold(
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
            scrollDirection: Axis.vertical,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 60.h,),
                Text(
                  "Sign Up",
                  style: getMedium500Style22(
                    color: ColorManager.textPrimary,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 5.h),
                Text(
                  "Enter your details below to create your account",
                  style: getMedium500Style14(
                    color: Color.fromARGB(255, 149, 149, 149),
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                SizedBox(height: 38.h),
                Container(
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
                          "Name",
                          style: getMedium500Style14(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(hintText: "alexa mate"),
                        SizedBox(height: 10.h,),
                        Text(
                          "Email Address",
                          style: getMedium500Style14(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(hintText: "alexa.mate@example.com"),
                        SizedBox(height: 12.h),
                        Text(
                          "Password",
                          style: getMedium500Style14(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        SizedBox(height: 5),
                        CustomTextField(
                          hintText: "enter your password",
                          obscureText: !isEyeon,
                          suffixIcon: IconButton(
                            onPressed: () {
                              ref.read(eyeSecure.notifier).state = !isEyeon;
                            },
                            icon: Icon(
                              isEyeon ? Icons.visibility_off : Icons.visibility,
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
                                    ref.read(checkIcon.notifier).state = !isCheck;
                                  },
                                  child: Container(
                                    height: 18.h,
                                    width: 20.w,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(4.r),
                                      color: isCheck? ColorManager.backgroundColorgreen1 : null,
                                      border: Border.all(
                                        color:isCheck? ColorManager.background : ColorManager.backgroundColorgreen,
                                        
                                      )
                                    ),
                                    child: isCheck?  Center(
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
                                  "I Accept the Terms & Conditions",
                                  style: getMedium500Style14(
                                    color: ColorManager.textPrimary,
                                    fontSize: 14.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ],
                            ),
                            
                          ],
                        ),
                        SizedBox(height: 15.h),
                        Customebutton(text: "Sing Up",onTap: () {
                           Navigator.pushReplacementNamed(context,RoutesName.parentScreen);
                        },),
                        SizedBox(height: 8.h),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10.h),
                Row(
                  children: [
                    Expanded(
                      child: Image.asset(
                        ImageManager.vertical,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
            
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Text(
                        "Or SignUp With",
                        style: getMedium500Style14(
                          color: ColorManager.subtextColor,
                        ),
                      ),
                    ),
            
                    Expanded(
                      child: Image.asset(
                        ImageManager.vertical,
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 12.h,),
                Customebutton(
                  image: IconManager.google,
                  text:"SignUp With Google" ,
                  color: Colors.white,
                  borderColor: const Color.fromARGB(255, 235, 235, 235),
                  border: 1.2.w,
                ),  SizedBox(height: 8.h,),
                Customebutton(
                  image: IconManager.facebook,
                  text:"SignUP With Facebook" ,
                  color: Colors.white,
                  borderColor: const Color.fromARGB(255, 235, 235, 235),
                  border: 1.5.w,
                ),
                SizedBox(height: 12.h,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center
                  ,
                  children: [
                    Text("Didn't have an account ?",style: getMedium500Style16(color: ColorManager.subtextColor,fontSize: 16.sp),),
                    InkWell(
                      onTap: () {
                        Navigator.pushReplacementNamed(context, RoutesName.signInScreen);
                      },
                      child: Text(" LogIn",style: getMedium500Style16(color: ColorManager.subtextColor,fontSize: 17.sp)))
                  ],
                ),
                SizedBox(height: 30.h,)
              ],
            ),
          ),
        ),
      ),
    );
  }
}
