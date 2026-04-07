import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:riverpod/legacy.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customTextField.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/get_in_touch/viewModel/get_in_touch_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/home_screen/viewModel/getMe_provider.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';


final currentPasswordVisibilityProvider = StateProvider<bool>((ref) => true);
final newPasswordVisibilityProvider = StateProvider<bool>((ref) => true);

class SecurityScreen extends ConsumerStatefulWidget {
  const SecurityScreen({super.key});

  @override
  ConsumerState<SecurityScreen> createState() => _SecurityScreenState();
}

class _SecurityScreenState extends ConsumerState<SecurityScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _currentPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  
  @override
  void initState() {
    // TODO: implement initState
    Future.microtask((){
      ref.read(getMeProvider.notifier).getMe();
    });
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _currentPasswordController.dispose();
    _newPasswordController.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    final email = _emailController.text.trim();
    final currentPass = _currentPasswordController.text.trim();
    final newPass = _newPasswordController.text.trim();

    if (email.isEmpty || currentPass.isEmpty || newPass.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }



    final errorMessage = ref.read(getInTouchProvider).errormessage;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage ?? 'Successfully updated (Demo)')),
    );
  }

  @override
  Widget build(BuildContext context) {
    final getInTouchState = ref.watch(getInTouchProvider);
    final isCurrentPassObscure = ref.watch(currentPasswordVisibilityProvider);
    final isNewPassObscure = ref.watch(newPasswordVisibilityProvider);
    ref.listen(getMeProvider, (previous, next) {
      if (next.me?.data?.email != null) {
        _emailController.text = next.me!.data!.email.toString();
      }
    });


    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(
              text: "Security",
              ontap: () {
                Navigator.pop(context);
              },
            ),
          ),
        ),
      ),
      body: Container(
        height: double.infinity,
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [ColorManager.primary, ColorManager.whiteColor],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.r),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: ColorManager.whiteColor,
                    border: Border.all(
                      color: ColorManager.borderColor,
                      width: 1.5.w,
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 10.h),
                        // Email Field
                        Text(
                          "Your Email",
                          style: getMedium500Style12(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          controller: _emailController,
                          hintText: "Email Address",
                          readonly: true,
                           
                        ),
                        SizedBox(height: 15.h),

                        // Current Password Field
                        Text(
                          "Current Password",
                          style: getMedium500Style12(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          controller: _currentPasswordController,
                          hintText: "Enter current password",
                          obscureText: isCurrentPassObscure,
                          suffixIcon: IconButton(
                            onPressed: () => ref.read(currentPasswordVisibilityProvider.notifier).state = !isCurrentPassObscure,
                            icon: Icon(isCurrentPassObscure ? Icons.visibility_off : Icons.visibility),
                          ),
                        ),
                        SizedBox(height: 15.h),

                        // New Password Field
                        Text(
                          "Enter New Password",
                          style: getMedium500Style12(
                            color: ColorManager.textPrimary,
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 8.h),
                        CustomTextField(
                          controller: _newPasswordController,
                          hintText: "Enter new password",
                          obscureText: isNewPassObscure,
                          suffixIcon: IconButton(
                            onPressed: () => ref.read(newPasswordVisibilityProvider.notifier).state = !isNewPassObscure,
                            icon: Icon(isNewPassObscure ? Icons.visibility_off : Icons.visibility),
                          ),
                        ),
                        SizedBox(height: 25.h),

                        // Submit Button
                        Customebutton(
                          onTap: getInTouchState.isloading ? null : _submit,
                          text: getInTouchState.isloading ? "Updated..." : "Update",
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}