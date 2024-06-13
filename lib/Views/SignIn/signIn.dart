import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sign_in_button/sign_in_button.dart';
import 'package:whisky_driver/Components/textfields/Text.dart';
import 'package:whisky_driver/Notifications/NotificationService.dart';
import 'package:whisky_driver/Utils/AppColor/app_color.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:whisky_driver/Views/AuthPage/authPage.dart';

import '../../Components/containers/containers.dart';
import '../../Components/textfields/textField.dart';
import '../BottomW/bottom_w.dart';

class signIn extends StatefulWidget {
  const signIn({super.key});

  @override
  State<signIn> createState() => _signInState();
}

class _signInState extends State<signIn> {
  var emailtextcontroller = TextEditingController();
  var nametextcontroller = TextEditingController();
  var passtextcontroller = TextEditingController();
  bool _isloading = false;
  bool _isDataUploaded = false;
  String? User_name;
  String? User_email;
  Future<void> uploadData(String email, String password, String name) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      try {
        // Get a reference to the document
        DocumentReference documentReference = FirebaseFirestore.instance
            .collection('authData')
            .doc(user.uid); // Use user ID as the document ID

        // Get the current data in the document (if any)
        DocumentSnapshot snapshot = await documentReference.get();
        Map<String, dynamic> data =
            snapshot.exists ? snapshot.data() as Map<String, dynamic> : {};

        // Update the data with the new fields
        data['userId'] = user.uid;
        data['email'] = email;
        data['password'] = password;
        data['name'] = name;
        // Add more fields as needed

        // Set the updated data in the document
        await documentReference.set(data);

        print('Data uploaded successfully.');

        _isDataUploaded = true;

        // Consider how you handle navigation since context is not available here
        //  Navigator.push(context, MaterialPageRoute (builder: (context) => const HomePage()));
      } catch (e) {
        print('Error uploading data: $e');
      }
    }
  }

  static Future<User?> registerUsingEmailPassword({
    required String name,
    required String email,
    required String password,
  }) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      user = userCredential.user;

      await user!.updateDisplayName(name);
      await user.reload();
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }

    return user;
  }

  Future<User?> RegisterWithGoogle() async {
    try {
      setState(() {
        _isloading = true;
      });

      GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      if (googleUser == null) {
        setState(() {
          _isloading = false;
        });
        return null; // Return null if sign-in is cancelled
      }

      GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);

      setState(() {
        _isloading = false;
      });
      User_email = userCredential.user!.displayName;
      User_name = userCredential.user!.email;
      return userCredential.user; // Return the signed-in user
    } catch (e) {
      print('Error signing in with Google: $e');
      return null; // Return null if an error occurs during sign-in
    }
  }

  bool isEmailValid(String email) {
    // Regular expression to match a basic email format
    RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
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
      fontSize: 16.sp, // Font size of the toast message
    );
  }

  NotificationService notificationService = NotificationService();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
   // notificationService.isTokenRefresh();
    notificationService.requestNotificationPermision();
    notificationService.firebaseInit();
    notificationService.getDeviceToken().then((value) {
      print("device token");
      print(value);
    });
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
             Center(
                child: text(
                    tex: "Create Account", colorOT: AppColors.red, Size: 22.sp)),
            SizedBox(
              height: 80.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 22.h),
              child:
                   text(tex: "Name", colorOT: AppColors.greyt, Size: 15.sp),
            ),
            textField(
              hinttext: 'Enter your   name',
              controller: nametextcontroller,
              obscure: false,
              allowtoright: false,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 22.h),
              child:  text(
                  tex: "Email address", colorOT: AppColors.greyt, Size: 15.sp),
            ),
            textField(
              allowtoright: false,
              hinttext: 'Enter your email ',
              controller: emailtextcontroller,
              obscure: false,
            ),
            SizedBox(
              height: 10.h,
            ),
            Padding(
              padding: EdgeInsets.only(left: 22.h),
              child:  text(
                  tex: "Password", colorOT: AppColors.greyt, Size: 15.sp),
            ),
            textField(
              allowtoright: false,
              hinttext: 'Enter your Password ',
              controller: passtextcontroller,
              obscure: true,
            ),
            SizedBox(
              height: 30.h,
            ),
            GestureDetector(
                onTap: () async {
                  if (isEmailValid(emailtextcontroller.text) &&
                      emailtextcontroller.text.isNotEmpty &&
                      passtextcontroller.text.isNotEmpty &&
                      nametextcontroller.text.isNotEmpty) {
                    setState(() {
                      _isloading = true;
                    });

                    // Register user
                    User? user = await registerUsingEmailPassword(
                      email: emailtextcontroller.text,
                      password: passtextcontroller.text,
                      name: nametextcontroller.text,
                    );

                    await uploadData(emailtextcontroller.text,
                        passtextcontroller.text, nametextcontroller.text);

                    if (user != null) {
                      // Update state to indicate data upload success

                      if (_isDataUploaded = true) {
                        setState(() {
                          _isloading = false;
                        });
                      }
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
                child: const Center(
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
                  text: "Sign up with google",
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.r)),
                  onPressed: () async {
                    await RegisterWithGoogle();
                    await uploadData(User_name!, "no password", User_email!);
                    if (User != null) {
                      setState(() {
                        _isloading = false;
                      });
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => const bottomW()));
                    }

                    // onPressed logic
                  },
                ),
              ),
            ),
            if (_isloading)
              const SpinKitThreeBounce(
                color: Colors.black,
              ),
            Padding(
              padding: EdgeInsets.only(left: 20.w, top: 10.h),
              child: Row(
                children: [
                  Text(
                    "Already have an account?",
                    style: GoogleFonts.inter(fontSize: 12.sp),
                  ),
                  GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const authPage()));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(left: 5.w),
                        child:  text(
                            tex: "Sign In", colorOT: AppColors.red, Size: 13.sp),
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
