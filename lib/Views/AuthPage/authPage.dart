import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sign_in_button/sign_in_button.dart';

import '../../Components/containers/containers.dart';
import '../../Components/textfields/Text.dart';
import '../../Components/textfields/textField.dart';
import '../../Utils/AppColor/app_color.dart';
import '../BottomW/bottom_w.dart';

class authPage extends StatefulWidget {
  const authPage({super.key});

  @override
  State<authPage> createState() => _authPageState();
}

class _authPageState extends State<authPage> {
  var emailtextcontroller = TextEditingController();

  var passtextcontroller = TextEditingController();
  bool _isloading = false;

  bool isEmailValid(String email) {
    // Regular expression to match a basic email format
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  static Future<User?> signInUsingEmailPassword({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided.');
      }
    }

    return user;
  }

  void showToast() {
    Fluttertoast.showToast(
      msg: 'Wrong Email or Password',
      toastLength:
          Toast.LENGTH_SHORT, // Duration for which the toast will be visible
      gravity: ToastGravity.BOTTOM, // Position of the toast on the screen
      timeInSecForIosWeb:
          1, // Duration for which the toast will be visible on iOS
      backgroundColor: Colors.grey, // Background color of the toast
      textColor: Colors.white, // Text color of the toast
      fontSize: 16.0, // Font size of the toast message
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 100.h,
            ),
            Center(child: text(tex: "Login", colorOT: AppColors.red, Size: 22.sp)),
            SizedBox(
              height: 80.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 22.h),
              child: text(
                  tex: "Email address", colorOT: AppColors.greyt, Size: 15.sp),
            ),
            textField(
              hinttext: 'Enter your email ',
              controller: emailtextcontroller,
              obscure: false,
              allowtoright: false,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 22.h),
              child: text(tex: "Password", colorOT: AppColors.greyt, Size: 15.sp),
            ),
            textField(
              hinttext: 'Enter your Password ',
              controller: passtextcontroller,
              obscure: true,
              allowtoright: false,
            ),
            SizedBox(
              height: 10.h,
            ),
            SizedBox(
              height: 30.h,
            ),
            GestureDetector(
                onTap: () async {
                  if (isEmailValid(emailtextcontroller.text) &&
                      emailtextcontroller.text.isNotEmpty &&
                      passtextcontroller.text.isNotEmpty) {
                    setState(() {
                      _isloading = true;
                    });

                    // Register user
                    User? user = await signInUsingEmailPassword(
                      email: emailtextcontroller.text,
                      password: passtextcontroller.text,
                      context: context,
                    );

                    if (user != null) {
                      // Update state to indicate data upload success
                      setState(() {
                        _isloading = false;
                      });
                      // Upload data if registration is successful

                      // Navigate to home page if data upload is successful

                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const bottomW()));
                    }
                  } else {
                    // Handle registration failure
                    showToast();
                  }
                },
                child: Center(
                    child: container(
                  colors: AppColors.red,
                  text: 'Registration',
                  textColor: Colors.white,
                  h: 16.5,
                  r: 10,
                  w: 1.55,
                ))),
            SizedBox(
              height: 10.h,
            ),
            Center(
              child: Container(
                width: 235.w, // Adjust width as needed
                height: 40.h, // Adjust height as needed
                child: SignInButton(
                  Buttons.google,
                  text: "Sign in with google",
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  onPressed: () {
                    signInUsingEmailPassword(
                      email: emailtextcontroller.text,
                      password: passtextcontroller.text,
                      context: context,
                    );

                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const bottomW()));
                    // onPressed logic
                  },
                ),
              ),
            ),
            if (_isloading)
              const SpinKitThreeBounce(
                color: Colors.black,
              ),
          ],
        ),
      ),
    );
  }
}
