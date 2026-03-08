import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';

class CustomTextField extends StatefulWidget {

  final TextEditingController? controller;
  final bool obscureText;
  final String? hintText;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Color? borderColor;

  const CustomTextField({
    super.key,
    this.controller,
    this.obscureText = false, 
    this.hintText,
    this.suffixIcon,
    this.onTap,
    this.borderColor,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      obscureText: widget.obscureText,
      
      decoration: InputDecoration(
        hintText: widget.hintText ?? "Enter text...", 
        hintStyle: getMedium500Style14(color: ColorManager.hintTextColor,fontSize: 14.sp,fontWeight: FontWeight.w400),
       
        suffixIcon: widget.suffixIcon != null 
            ? InkWell(
                onTap: widget.onTap,
                child: Padding(
                  padding: const EdgeInsets.all(12.0), //
                  child: widget.suffixIcon!,
                ),
              ) 
            : null,
        
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          
          borderSide: BorderSide(
           width: 2,
            color: widget.borderColor ?? ColorManager.borderColor
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(
            color: widget.borderColor ?? ColorManager.borderColor, 
            width: 2,
          ),
        ),
      ),
    );
  }
}