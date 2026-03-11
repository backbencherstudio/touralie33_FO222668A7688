import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/image_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/forget_password/view/widget/customeApp.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customTextField.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/successfull_screen/view/widget/dialog_widget.dart';

final eyeSecure = StateProvider<bool>((ref) => false);
final eyeSecure1 = StateProvider<bool>((ref) => false);
final checkIcon = StateProvider<bool>((ref) => false);

class NewPasswordScreen extends ConsumerStatefulWidget {
  const NewPasswordScreen({super.key});

  @override
  ConsumerState<NewPasswordScreen> createState() => _NewPasswordScreenState();
}

class _NewPasswordScreenState extends ConsumerState<NewPasswordScreen> {
  @override
  Widget build(BuildContext context) {
    final isEyeon = ref.watch(eyeSecure);
    final isEyeon1 = ref.watch(eyeSecure1);
    final isCheck = ref.watch(checkIcon);
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
                        CustomTextField(hintText: "enter your password", obscureText: !isEyeon1,
                          suffixIcon: IconButton(
                            onPressed: () {
                              ref.read(eyeSecure1.notifier).state = !isEyeon1;
                            },
                            icon: Icon(
                              isEyeon1 ? Icons.visibility_off : Icons.visibility,
                            ),
                          ),),
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
                        Customebutton(text: "Login",onTap: () {
                          showDialog(
  context: context,
  barrierDismissible: true, 
  
  builder: (BuildContext context) {
    return DialogWidget();
  },
);
                        },),
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
