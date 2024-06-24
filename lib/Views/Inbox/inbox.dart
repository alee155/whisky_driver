import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:whisky_driver/Views/ChatScreen/chatscreen.dart';

import '../../Components/textfields/Text.dart';
import '../../Utils/AppColor/app_color.dart';
import '../../Utils/AppImage/app_images.dart';

class Inbox extends StatefulWidget {
  const Inbox({super.key});

  @override
  State<Inbox> createState() => _InboxState();
}

class _InboxState extends State<Inbox> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Row(
            children: [
              Padding(
                padding: EdgeInsets.only(right: 20.w),
                child: SvgPicture.asset(
                  AppImage.plus,
                  height: 18.h,
                  width: 18.w,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: SvgPicture.asset(
                  AppImage.ques,
                  height: 18.h,
                  width: 18.w,
                ),
              ),
            ],
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(left: 10.w, right: 10.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 10.w),
                child:
                    text(tex: "Inbox", colorOT: AppColors.black, Size: 30.sp),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.w, right: 15.w, top: 10.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    text(tex: "Tasks", colorOT: AppColors.black, Size: 21.sp),
                    text(tex: "View all", colorOT: AppColors.tex3, Size: 14.sp)
                  ],
                ),
              ),
              SizedBox(
                height: 10.h,
              ),
              Center(
                child: Container(
                  height: MediaQuery.of(context).size.height / 3.7,
                  width: MediaQuery.of(context).size.width / 1.06,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.r),
                    color: Colors.white,
                    boxShadow: const [
                      // BoxShadow(
                      //   color: Colors.grey,
                      //   spreadRadius: 1,
                      //   blurRadius: 0,
                      //   offset: const Offset(2, 0), // Shadow position
                      // ),
                      BoxShadow(
                        color: Colors.grey,
                        spreadRadius: 1,
                        blurRadius: 10,
                        offset: Offset(-2, 0), // Shadow position
                      ),
                      // BoxShadow(
                      //   color: Colors.grey,
                      //   spreadRadius: 1,
                      //   blurRadius: 10,
                      //   offset: const Offset(0, -2), // Shadow position
                      // ),
                    ],
                  ),
                  child: Padding(
                    padding: EdgeInsets.only(
                        top: 8.h, left: 8.w, right: 8.w, bottom: 8.h),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 15.h,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                text(
                                    tex: "Update shopper paperwork",
                                    colorOT: AppColors.black,
                                    Size: 14.sp),
                                text(
                                    tex: "We've update the shopper",
                                    colorOT: AppColors.greyt,
                                    Size: 14.sp),
                                text(
                                    tex: "paperwork",
                                    colorOT: AppColors.greyt,
                                    Size: 14.sp),
                                text(
                                    tex: "Due 3/23/24",
                                    colorOT: AppColors.greyt,
                                    Size: 14.sp),
                              ],
                            ),
                            //Image.asset(AppImage.letter),

                            Container(
                              height: MediaQuery.of(context).size.height / 10,
                              width: MediaQuery.of(context).size.width / 3.1,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: AssetImage(AppImage.letter),
                                  fit: BoxFit.cover,
                                ),
                              ),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 40.h,
                        ),
                        Divider(
                          color:
                              AppColors.greyc, // Set the color of the divider
                          thickness: 2.h, // Set the thickness of the divider
                          height:
                              20.h, // Set the vertical space above the divider
                          indent: 0,
                          endIndent: 0, // Set the left indent of the divider
                          // Set the right indent of the divider
                        ),
                        text(
                            tex: "Review and sign documents",
                            colorOT: AppColors.redc,
                            Size: 14.sp)
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
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
                padding: EdgeInsets.only(left: 10.w),
                child: text(
                    tex: "Messages", colorOT: AppColors.black, Size: 23.sp),
              ),
              SizedBox(
                height: 10.h,
              ),
              SizedBox(
                height: 200.h,
                child: ListView.builder(
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.vertical,
                  itemCount: 25,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ChatScreen(),
                          ),
                        );
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: text(
                                tex: "Correction: Manhattan ptomotion email",
                                colorOT: AppColors.black,
                                Size: 15.sp),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 10.w),
                            child: text(
                                tex: "Oct 01, 1:43am",
                                colorOT: AppColors.greyt,
                                Size: 15.sp),
                          ),
                          SizedBox(
                            height: 5.h,
                          ),
                          Divider(
                            color:
                                AppColors.greyc, // Set the color of the divider
                            thickness: 2.h, // Set the thickness of the divider
                            height: 20
                                .h, // Set the vertical space above the divider
                            indent: 0,
                            endIndent: 0, // Set the left indent of the divider
                            // Set the right indent of the divider
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
