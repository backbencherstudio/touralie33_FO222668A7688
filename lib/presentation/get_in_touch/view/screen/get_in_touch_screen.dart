import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/color_manger.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/icon_manager.dart';
import 'package:touralie33_fo222668a7688/core/resource/constants/style_manager.dart';
import 'package:touralie33_fo222668a7688/core/route/routes_name.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customTextField.dart';
import 'package:touralie33_fo222668a7688/presentation/auth/signin/view/widget/customeButton.dart';
import 'package:touralie33_fo222668a7688/presentation/get_in_touch/view/widget/success_full_widget.dart';
import 'package:touralie33_fo222668a7688/presentation/widget/customebar/customebar.dart';

class GetInTouchScreen extends StatelessWidget {
  const GetInTouchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.primary,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(60.h),
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
            child: Customebar(text: "Get In Touch",ontap: () {
              Navigator.pushReplacementNamed(context, RoutesName.subscriptionScreen);
            },),
          ),
        ),
      ),
      body: Container(
        decoration: BoxDecoration(

          gradient: LinearGradient(colors: [
            ColorManager.primary,
            ColorManager.whiteColor
          ],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter
          )
        ),
        child: Padding(
          padding:  EdgeInsets.all(16.r),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Container(
                  
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16.r),
                    color: ColorManager.whiteColor,
                    border: Border.all(color: ColorManager.borderColor,width: 1.5.w)
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(12.r),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                              color: ColorManager.backgroundColorgreen1.withValues(alpha: .2),
                          ),
                        
                          child: Padding(
                            padding:  EdgeInsets.all(12.r),
                            child: Column(
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                  
                                  Text("You’ve selected “Platinum” Plan!",style: getMedium500Style12(color: ColorManager.drawrColor,fontSize: 14.sp,fontWeight: FontWeight.w600),)
                                ,Image.asset(IconManager.subtractIcon,fit: BoxFit.cover,height: 24.h,),
                                ],),
                                SizedBox(height: 12.h,),
                                Text("Please Submit a form with your enquire.Our representative will contach you")
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.h,),
                   Text("Name",style: getMedium500Style12(color: ColorManager.textPrimary,fontSize: 14.sp,fontWeight: FontWeight.w400),),
                     SizedBox(height: 10.h,),
                      CustomTextField(
                            hintText: "Your Full Name",
                          
                            
                          ),
                   Text("Email",style: getMedium500Style12(color: ColorManager.textPrimary,fontSize: 14.sp,fontWeight: FontWeight.w400),),
                     SizedBox(height: 10.h,),
                      CustomTextField(
                            hintText: "Email Address",
                          
                            
                          ),
                   Text("Phone Number",style: getMedium500Style12(color: ColorManager.textPrimary,fontSize: 14.sp,fontWeight: FontWeight.w400),),
                     SizedBox(height: 10.h,),
                      CustomTextField(
                            hintText: "Phone number",
                          
                            
                          ),
                          SizedBox(height: 15.h,),
                           Text("What would you like to know more about?",style: getMedium500Style12(color: ColorManager.textPrimary,fontSize: 14.sp,fontWeight: FontWeight.w400),),
                    SizedBox(height: 15.h,),
                    TextFormField(
              
                  maxLines: 6, // This creates the height seen in your image
                  style: getLight300Style12(color: ColorManager.textPrimary, fontSize: 14.sp),
                  decoration: InputDecoration(
                    hintText:"Your Message here....",
                    hintStyle:getMedium500Style12(
            color: ColorManager.hintTextColor, 
            fontSize: 14.sp,
            fontWeight: FontWeight.w400
                    ),
                    fillColor: ColorManager.whiteColor,
                    filled: true,
                    contentPadding: EdgeInsets.all(16.r),
                    // The light border seen in your image
                    enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: Colors.grey.withOpacity(0.2), 
              width: 1
            ),
                    ),
                    focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16.r),
            borderSide: BorderSide(
              color: ColorManager.backgroundColorgreen, 
              width: 1.5
            ),
                    ),
                  ),
                ),SizedBox(height: 15.h,),
                Customebutton(
                  onTap: () {
                           showDialog(
  context: context,
  barrierDismissible: true, 
  
  builder: (BuildContext context) {
    return SuccessfullWidget();
  },
);
                  },
                  text: "Submit",
                )
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