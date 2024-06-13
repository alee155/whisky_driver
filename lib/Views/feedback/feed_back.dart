import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../../Components/textfields/Text.dart';
import '../../Utils/AppColor/app_color.dart';
import '../../Utils/AppImage/app_images.dart';
import '../Comments/commentScreen.dart';

class feed_back extends StatefulWidget {
  const feed_back({super.key});

  @override
  State<feed_back> createState() => _feed_backState();
}

class _feed_backState extends State<feed_back> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(left: 10.w, right: 10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 80.h,
            ),
            Center(
              child: Container(
                height: MediaQuery.of(context).size.height / 4,
                width: MediaQuery.of(context).size.width / 1.1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    color: AppColors.redc),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: 10.h, top: 1.h, right: 12.h),
                          child: SvgPicture.asset(
                            AppImage.user,
                            width: 50.w,
                            height: 50.h,
                          ),
                        ),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 15.h,
                            ),
                            text(
                              tex: 'Doh Tonane',
                              colorOT: Colors.white,
                              Size: 23.sp,
                            ),
                            // const Text("Doh Tonane",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold, color: Colors.white),)
                            SizedBox(
                              height: 4.h,
                            ),
                            Container(
                              height: MediaQuery.of(context).size.width / 10,
                              width: MediaQuery.of(context).size.width / 3,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1,
                                  ),
                                  color: AppColors.redc,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: 15.w, top: 4.h, right: 8.w,bottom: 5.h),
                                      child:  Align(
                                        alignment: Alignment.center,
                                        child: text(
                                          tex: 'Car Star',
                                          colorOT: Colors.white,
                                          Size: 12.sp,
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          right: 1.w,
                                          top: 1.h,
                                          bottom: 2.h,
                                          left: 8.w),
                                      child:  Icon(
                                        Icons.arrow_forward_ios,
                                        color: Colors.white,
                                        size: 14.sp,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 15, left: 10),
                      child: text(
                        tex: 'Whisky Shope since Jan 2021',
                        colorOT: Colors.white,
                        Size: 12.sp,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 10),
                      child: text(
                        tex: 'Order Completed: 3,935',
                        colorOT: Colors.white,
                        Size: 12.sp,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5, left: 10),
                      child: text(
                        tex: 'Batches Completed: 7899',
                        colorOT: Colors.white,
                        Size: 12.sp,
                      ),
                    )
                  ],
                ),
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                    padding: EdgeInsets.only(left: 8.w, top: 8.h),
                    child: Align(
                      alignment: Alignment.topLeft,
                      child: text(
                        tex: 'Feedback',
                        colorOT: AppColors.black,
                        Size: 21.sp,
                      ),
                    )),
                Padding(
                  padding: EdgeInsets.only(right: 8.w, top: 10.h, bottom: 8.h),
                  child: SvgPicture.asset(AppImage.ques),
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 8.w, top: 30.h),
                      child: SvgPicture.asset(AppImage.user),
                    ),
                    SizedBox(
                      height: 25.h,
                    )
                  ],
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8.h),
                      child: Align(
                        alignment: Alignment.topLeft,
                        child: text(
                          tex: 'Customer Rating',
                          colorOT: AppColors.black,
                          Size: 17.sp,
                        ),
                      ),
                    ),
                    text(
                      tex: 'Standard',
                      colorOT: AppColors.greyt,
                      Size: 17.sp,
                    ),
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(right: 8.w, top: 10.h, bottom: 8.h),
                  child: Icon(Icons.arrow_forward_ios,
                      color: AppColors.greyt, size: 22.sp),
                )
              ],
            ),
            Padding(
                padding: EdgeInsets.only(top: 10.h, left: 10, bottom: 4),
                child: Align(
                  alignment: Alignment.topLeft,
                  child: text(
                    tex: 'How to improve',
                    colorOT: AppColors.tex3,
                    Size: 18.sp,
                  ),
                )),
            Divider(
              color: AppColors.greyc, // Set the color of the divider
              thickness: 2.h, // Set the thickness of the divider
              height: 20.h, // Set the vertical space above the divider
              indent: 0,
              endIndent: 0, // Set the left indent of the divider
              // Set the right indent of the divider
            ),
            Padding(
              padding: EdgeInsets.only(top: 10.h, left: 10, bottom: 8),
              child: Align(
                alignment: Alignment.topLeft,
                child: text(
                  tex: 'Compliments',
                  colorOT: AppColors.black,
                  Size: 18.sp,
                ),
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
              padding: EdgeInsets.only(top: 10.h, left: 10, bottom: 8),
              child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => comments_Screen(),
                      ),
                    );
                  },
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: text(
                      tex: 'Comments',
                      colorOT: AppColors.black,
                      Size: 18.sp,
                    ),
                  )),
            ),
            SizedBox(
              height: 5.h,
            ),
            Row(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: 10.h, left: 10.h, bottom: 8.h, right: 6.h),
                  child: SvgPicture.asset(
                    AppImage.message,
                    color: AppColors.greyt,
                    height: 20.h,
                    width: 20.w,
                  ),
                ),
                text(
                  tex: 'September 27, 2023',
                  colorOT: AppColors.greyt,
                  Size: 16.sp,
                ),
              ],
            ),
            Padding(
              padding: EdgeInsets.only(
                  top: 10.h, left: 15.h, bottom: 8.h, right: 6.h),
              child: text(
                tex: 'View all',
                colorOT: AppColors.tex3,
                Size: 17.sp,
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
