import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../Components/textfields/Text.dart';
import '../../Utils/AppColor/app_color.dart';
import '../../Utils/AppImage/app_images.dart';

class comments_Screen extends StatefulWidget {
  const comments_Screen({super.key});

  @override
  State<comments_Screen> createState() => _comments_ScreenState();
}

class _comments_ScreenState extends State<comments_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: SvgPicture.asset(AppImage.plus),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: SvgPicture.asset(AppImage.ques),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 40.w),
                child: text(
                  tex: 'Comments',
                  colorOT: AppColors.black,
                  Size: 27.sp,
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w, bottom: 10.w),
                child: text(
                  tex: 'Last update Oct 01,1:43am ',
                  colorOT: AppColors.greyt,
                  Size: 17.sp,
                ),
              ),
              Divider(
                color: AppColors.greyc, // Set the color of the divider
                thickness: 2.h, // Set the thickness of the divider
                height: 20.h, // Set the vertical space above the divider
                indent: 0,
                endIndent: 0, // Set the left indent of the divider
                // Set the right indent of the divider
              ),
              Padding(
                padding: EdgeInsets.only(left: 40.w, bottom: 10.w),
                child: SvgPicture.asset(AppImage.star),
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: text(
                  tex: 'September 27 , 2023 ',
                  colorOT: AppColors.greyt,
                  Size: 15.sp,
                ),
              ),
              SizedBox(
                height: 30.h,
              ),
              Padding(
                padding: EdgeInsets.only(left: 30.w),
                child: text(
                  tex:
                      'Doh is a terrifuc shopper who delivered /n the order quickly! thanks!',
                  colorOT: AppColors.greyt,
                  Size: 15.sp,
                ),
              ),
            ]),
      ),
    );
  }
}
