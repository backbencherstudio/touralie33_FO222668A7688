import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customTextField.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/viewmodel/signin_viewmodel.dart';

class SigninScreen extends ConsumerStatefulWidget {
  const SigninScreen({super.key});

  @override
  ConsumerState<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends ConsumerState<SigninScreen> {

  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

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
            child: Column(
              children: [
                SizedBox(height: 100.h), 
                Text("Welcome Back", style: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.bold)),
                Text("Login to your account below", style: TextStyle(fontSize: 14.sp, color: Colors.grey)),
                
                SizedBox(height: 40.h),
                
        
                Container(
                  padding: EdgeInsets.all(16.r),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15.r),
                    boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
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
                          onPressed: () => ref.read(eyeSecure.notifier).state = !isEyeon,
                          icon: Icon(isEyeon ? Icons.visibility_off : Icons.visibility),
                        ),
                      ),

                      SizedBox(height: 15.h),

                  
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          GestureDetector(
                            onTap: () => ref.read(checkIcon.notifier).state = !isCheck,
                            child: Row(
                              children: [
                                Icon(isCheck ? Icons.check_box : Icons.check_box_outline_blank),
                                SizedBox(width: 5),
                                Text("Remember Me"),
                              ],
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, RoutesName.forgotPassword);
                            },
                            child: Text("Forgot Password?", style: TextStyle(color: Colors.green))),
                        ],
                      ),
                      
                      SizedBox(height: 25.h),

        
                      signInState.isLoading 
                      ? const Center(child: CircularProgressIndicator()) 
                      : Customebutton(
                          text: "Login",
                          onTap: () async {
                          
                            if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text("Email and Password are required")),
                              );
                              return;
                            }

                   
                            final success = await ref.read(signInViewModelProvider.notifier).signIn(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );

                            if (success) {
                            
                              Navigator.pushReplacementNamed(context, RoutesName.parentScreen);
                            } else {
                             
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(signInState.errorMessage ?? "Login Failed!")),
                              );
                            }
                          },
                        ),
                    ],
                  ),
                ),
            Customebutton(
                  image: IconManager.google,
                  text: "Login With Google",
                  color: Colors.white,
                  borderColor: const Color.fromARGB(255, 235, 235, 235),
                  border: 1.2.w,
                  onTap: () { },
                ),
                SizedBox(height: 8.h),
                Customebutton(
                  image: IconManager.facebook,
                  text: "Login With Apple",
                  color: Colors.white,
                  borderColor: const Color.fromARGB(255, 235, 235, 235),
                  border: 1.5.w,
                  onTap: () { },
                ),
                SizedBox(height: 12.h),
                
     
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Didn't have an account ?", style: getMedium500Style16(color: ColorManager.subtextColor, fontSize: 15.sp)),
                    InkWell(
                      onTap: () => Navigator.pushReplacementNamed(context, RoutesName.singInUpScreen),
                      child: Text(" SignUp", style: getMedium500Style16(color: ColorManager.drawrColor, fontSize: 16.sp)),
                    )
                  ],
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}