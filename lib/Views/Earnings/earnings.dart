import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import '../../Components/containers/containerwithrow.dart';
import '../../Components/textfields/Text.dart';
import '../../Utils/AppColor/app_color.dart';
import '../../Utils/AppImage/app_images.dart';

class Earnings extends StatefulWidget {
  const Earnings({super.key});

  @override
  State<Earnings> createState() => _EarningsState();
}

class _EarningsState extends State<Earnings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.greyc,
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                color: Colors.white,
                height: 70.h,
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 120.w,
                      ),
                      Text(
                        'Earnings',
                        style: TextStyle(
                            fontSize: 20.sp, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: 30.w,
                      ),
                      SvgPicture.asset(
                        AppImage.plus,
                        height: 18.h,
                        width: 18.h,
                      ),
                      SvgPicture.asset(
                        AppImage.ques,
                        height: 18.h,
                        width: 18.h,
                      ),
                      SizedBox(
                        width: 5.w,
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 60.h,
                color: Colors.white,
                child: Column(
                  children: [
                    Center(
                      child: text(
                          tex: "Current balance",
                          colorOT: AppColors.greyt,
                          Size: 16.sp),
                    ),
                    Center(
                        child: text(
                            tex: 'F0.00', colorOT: AppColors.black, Size: 21.sp))
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                color: Colors.white,
                height: 40.h,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 18.w),
                      child: text(
                          tex: 'Total', colorOT: AppColors.black, Size: 16.sp),
                    ),
                    Padding(
                        padding: EdgeInsets.only(right: 18),
                        child: text(
                            tex: 'F0.00', colorOT: AppColors.black, Size: 16.sp)),
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.w),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: text(
                        tex: "Earnings opportunity",
                        colorOT: AppColors.greyt,
                        Size: 16.sp)),
              ),
              SizedBox(
                height: 8.h,
              ),
              Container(
                  color: Colors.white,
                  width: MediaQuery.of(context).size.width / 1,
                  height: MediaQuery.of(context).size.height / 3,
                  child: Padding(
                    padding: EdgeInsets.only(left: 10.w, right: 10.w),
                    child: Column(
                      children: [
                        SizedBox(
                          height: 12.h,
                        ),
                        ConRow(
                          textcolorl1: Colors.black,
                          Image: AppImage.user,
                          containerColor: AppColors.con1,
                          textcolorl2: AppColors.tex1,
                          Textl1: "Shop at times higher pay",
                          Textl2: 'View this weeks  earning hours',
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        ConRow(
                          textcolorl1: Colors.black,
                          Image: AppImage.message,
                          containerColor: AppColors.con2,
                          textcolorl2: AppColors.tex2,
                          Textl1: 'Take advantages of promos in your areas',
                          Textl2: 'view this weeks  earning hours',
                        ),
                        SizedBox(
                          height: 8.h,
                        ),
                        ConRow(
                          textcolorl1: Colors.black,
                          Image: AppImage.signal,
                          containerColor: AppColors.con3,
                          textcolorl2: AppColors.tex3,
                          Textl1: 'Shopes at times higher pay',
                          Textl2: 'View this weeks  earning hours',
                        )
                      ],
                    ),
                  )),

              Padding(
                padding: EdgeInsets.only(
                  left: 18.w,
                  top: 8.h,
                ),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: text(
                        tex: "Transaction History",
                        colorOT: AppColors.greyt,
                        Size: 15.sp)),
              ),

              SizedBox(
                height: 8.h,
              ),
              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 18.w, top: 13.h),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: text(
                              tex: 'September 27 ,2023',
                              colorOT: AppColors.black,
                              Size: 15.sp)),
                    ),
                    Padding(
                      padding: EdgeInsets.only(right: 18.w, top: 13.h),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: text(
                              tex: 'F18.72',
                              colorOT: AppColors.greyt,
                              Size: 16.sp)),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 2.h,
              ),

              Container(
                color: Colors.white,
                height: MediaQuery.of(context).size.height / 16,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 18.w, top: 12.h),
                      child: Align(
                          alignment: Alignment.topLeft,
                          child: text(
                              tex: 'View more',
                              colorOT: AppColors.tex3,
                              Size: 16.sp)),
                    ),
                    Padding(
                      padding:
                          EdgeInsets.only(right: 18.w, top: 10.h, bottom: 8.h),
                      child: Icon(
                        Icons.arrow_forward_ios,
                        color: AppColors.greyt,
                        size: 22.sp,
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 8.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 18.w),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: text(
                        tex: "Weekly earnings",
                        colorOT: AppColors.greyt,
                        Size: 16.sp)),
              ),
              // Text("Weekly earnings",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 22,color: AppColors.greyt),),
              SizedBox(
                height: 8.h,
              ),
              Container(
                color: Colors.white,
                height: 40.h,
              )
            ],
          ),
        ));
  }
}
