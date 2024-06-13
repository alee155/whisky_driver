import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:whisky_driver/Utils/AppColor/app_color.dart';
class textField extends StatelessWidget {
  const textField({super.key,  required this.hinttext, required this.controller, required this.obscure, required this.allowtoright});


  final String hinttext;
  final TextEditingController controller;
  final  bool obscure ;
  final  bool allowtoright;

  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child:  Padding(
        padding:  EdgeInsets.only(left: 20.w,right: 20.w),
        child: TextFormField(
          controller: controller,
          obscureText: obscure,
            readOnly:allowtoright ,
          scrollPadding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom),
          decoration: InputDecoration(
            border: InputBorder.none,
            enabledBorder: OutlineInputBorder(
              borderSide:  BorderSide(
                  width: 1, color: AppColors.black
              ),
              borderRadius: BorderRadius.circular(50.r),//<-- SEE HERE
            ),
            focusedBorder:OutlineInputBorder(
              borderSide:  BorderSide(
                  width: 1, color: AppColors.black), //<-- SEE HERE
              borderRadius: BorderRadius.circular(50.r),
            ),



            hintStyle:  TextStyle(fontSize: 15.sp,color: Colors.grey),
            hintText: hinttext,
          ),

        ),
      ),

    );
  }
}
