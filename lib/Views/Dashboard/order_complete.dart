import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:whisky_driver/Utils/AppColor/app_color.dart';

class OrderComplete extends StatelessWidget {
  const OrderComplete({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        backgroundColor: AppColors.red,
        title: Text(
          'Order Complete',
          style: TextStyle(
            fontSize: 24.sp,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                SizedBox(
                  height: 50.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.w, right: 10.w, top: 20.h),
                  child: Column(
                    children: [
                      Text(
                        'Code has been sent to phone',
                        style: TextStyle(
                          fontSize: 18.sp,
                          fontWeight: FontWeight.w500,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 10.h),
                      Text(
                        'Verify Your PIN',
                        style: TextStyle(
                          fontSize: 20.sp,
                          color: Colors.black,
                        ),
                      ),
                      SizedBox(height: 20.h),
                      Pinput(
                        length: 5,
                        pinAnimationType: PinAnimationType.fade,
                        defaultPinTheme: PinTheme(
                          width: 63.w,
                          height: 61.h,
                          textStyle: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.black,
                          ),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 202, 198, 198),
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        focusedPinTheme: PinTheme(
                          width: 63.w,
                          height: 61.h,
                          textStyle: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.black,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: AppColors.red),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        submittedPinTheme: PinTheme(
                          width: 63.w,
                          height: 61.h,
                          textStyle: TextStyle(
                            fontSize: 24.sp,
                            color: Colors.black,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                      ),
                      SizedBox(height: 200.h),
                      ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.red,
                          minimumSize: Size(350.w, 50.r),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r),
                          ),
                        ),
                        child: Text(
                          'Complete',
                          style: TextStyle(
                            fontSize: 17.sp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
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
