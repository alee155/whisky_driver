

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../../Components/textfields/Text.dart';
import '../../Utils/AppColor/app_color.dart';
import '../../Utils/AppImage/app_images.dart';
import '../ProfileScreen/Profile_Screen.dart';
import '../SignIn/signIn.dart';

class Account extends StatefulWidget {
  const Account({super.key});

  @override
  State<Account> createState() => _AccountState();
}
void signOutUser(BuildContext context) async {
  try {
    User? user;
    user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      print(user.uid);
    }
    //fire base signout
    FirebaseAuth Auth = FirebaseAuth.instance;
    await Auth.signOut();
    // google signout
    GoogleSignIn googleSignIn = GoogleSignIn();
    await googleSignIn.signOut(); // Sign out from Google

    print('User signed out successfully');
    Navigator.push(
        context , MaterialPageRoute(builder: (context) => const signIn()));
    // showDialog(context: context, builder: (context){
    //   return AlertDialog( content: text(tex: "wrong", colorOT: AppColors.black, Size: 15),);
    // });


  } catch (e) {
    print('Error signing out: $e');
  }
}

class _AccountState extends State<Account> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
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
                padding: EdgeInsets.only(
                  left: 10.w,
                  bottom: 10.h,
                ),
                child:   text(tex: "Account", colorOT: AppColors.black, Size: 27.sp),
              ),
              Container(
                height: MediaQuery.of(context).size.height / 6,
                width: MediaQuery.of(context).size.width / 1,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20.r),
                    image: DecorationImage(
                        image: AssetImage(AppImage.Dictator),
                        fit: BoxFit.cover)),
              ),
              SizedBox(height: 10.h),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, top: 8.h),
                    child:  Align(
                        alignment: Alignment.topLeft,
                        child: text(
                            tex: "Profile",
                            colorOT: AppColors.black,
                            Size: 17.sp)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 8.w, top: 10.h, bottom: 8.h),
                    child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const Profile_screen(),
                            ),
                          );
                        },
                        child: Icon(Icons.arrow_forward_ios,
                            color: AppColors.greyt, size: 22.sp)),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, top: 8.h),
                    child: const Align(
                        alignment: Alignment.topLeft,
                        child: text(
                            tex: "payout accounts",
                            colorOT: AppColors.black,
                            Size: 17)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 8.w, top: 10.h, bottom: 8.h),
                    child: Icon(Icons.arrow_forward_ios,
                        color: AppColors.greyt, size: 22.sp),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, top: 8.h),
                    child:  Align(
                        alignment: Alignment.topLeft,
                        child: text(
                            tex: "Whisky Payment card",
                            colorOT: AppColors.black,
                            Size: 17.sp)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 8.w, top: 10.h, bottom: 8.h),
                    child: Icon(Icons.arrow_forward_ios,
                        color: AppColors.greyt, size: 22.sp),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, top: 8.h),
                    child:  Align(
                        alignment: Alignment.topLeft,
                        child: text(
                            tex: "Reeimbursementt requests",
                            colorOT: AppColors.black,
                            Size: 17.sp)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 8.w, top: 10.h, bottom: 8.h),
                    child: Icon(Icons.arrow_forward_ios,
                        color: AppColors.greyt, size: 22.sp),
                  )
                ],
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, top: 8.h),
                    child:  Align(
                        alignment: Alignment.topLeft,
                        child: text(
                            tex: "Batch eligibility",
                            colorOT: AppColors.black,
                            Size: 17.sp)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 8.w, top: 10.h, bottom: 8.h),
                    child: Icon(Icons.arrow_forward_ios,
                        color: AppColors.greyt, size: 22.sp),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, top: 8.h),
                    child:  Align(
                        alignment: Alignment.topLeft,
                        child: text(
                            tex: "Safety trainings",
                            colorOT: AppColors.black,
                            Size: 17.sp)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 8.w, top: 10.h, bottom: 8.h),
                    child: Icon(Icons.arrow_forward_ios,
                        color: AppColors.greyt, size: 22.sp),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, top: 8.h),
                    child:  Align(
                        alignment: Alignment.topLeft,
                        child: text(
                            tex: "Shopping tips",
                            colorOT: AppColors.black,
                            Size: 17.sp)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 8.w, top: 10.h, bottom: 8.h),
                    child: Icon(Icons.arrow_forward_ios,
                        color: AppColors.greyt, size: 22.sp),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left: 8.w, top: 8.h),
                    child:  Align(
                        alignment: Alignment.topLeft,
                        child: text(
                            tex: "Demo orders",
                            colorOT: AppColors.black,
                            Size: 17.sp)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 8.w, top: 10.h, bottom: 8.h),
                    child: Icon(Icons.arrow_forward_ios,
                        color: AppColors.greyt, size: 22.sp),
                  )
                ],
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
                    child:  Align(
                        alignment: Alignment.topLeft,
                        child: text(
                            tex: "Settings",
                            colorOT: AppColors.black,
                            Size: 17.sp)),
                  ),
                  Padding(
                    padding:
                        EdgeInsets.only(right: 8.w, top: 10.h, bottom: 8.h),
                    child: Icon(Icons.arrow_forward_ios,
                        color: AppColors.greyt, size: 22.sp),
                  )
                ],
              ),
              GestureDetector(
                onTap:(){
                  signOutUser(context);

                },

                child: Padding(

                  padding:  EdgeInsets.only(left: 8.w, top: 8.h ,bottom: 20),
                  child:  text(tex: "Sign out", colorOT: AppColors.black, Size: 17.sp),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
