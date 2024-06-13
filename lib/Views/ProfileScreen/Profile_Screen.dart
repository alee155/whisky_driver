import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';

import 'package:whisky_driver/Components/containers/containers.dart';
import 'package:whisky_driver/Components/textfields/textField.dart';
import 'package:whisky_driver/Views/SignIn/signIn.dart';

import '../../Components/textfields/Text.dart';
import '../../Models/AuthModel.dart';
import '../../Utils/AppColor/app_color.dart';
import '../../Utils/AppImage/app_images.dart';

class Profile_screen extends StatefulWidget {
  const Profile_screen({super.key});

  @override
  State<Profile_screen> createState() => _Profile_screenState();
}

class _Profile_screenState extends State<Profile_screen> {
  File? _image;
  String email = "a";
  String name = "b";
  String url = "https://picsum.photos/200/300";
  TextEditingController NameTextController = TextEditingController();
  TextEditingController EmailTextController = TextEditingController();

  Future<void> deleteUserAndData() async {
    try {
      // Get the current user
      User? user = FirebaseAuth.instance.currentUser;

      // Delete user from Firebase Authentication
      await user?.delete();

      // Access the Firestore collection where user data is stored
      CollectionReference usersCollection =
          FirebaseFirestore.instance.collection('authData');

      // Query for the user's document
      QuerySnapshot querySnapshot =
          await usersCollection.where('userId', isEqualTo: user!.uid).get();

      // Delete the user's document from the collection
      querySnapshot.docs.forEach((doc) async {
        await doc.reference.delete();
      });

      print('User deleted successfully.');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const signIn()));
    } catch (e) {
      print('Error deleting user: $e');
    }
  }

  Future<void> updateDocument(File? imageFile, String name) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null && imageFile != null) {
      String userId = user.uid;
      // Get a reference to the document
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('authData').doc(userId);

      try {
        print('Starting image upload...');
        // Upload the image to Firebase Storage
        Reference storageRef = FirebaseStorage.instance
            .ref()
            .child(userId)
            .child("profile_image.jpg");

        // Upload the image file
        UploadTask uploadTask = storageRef.putFile(imageFile);

        // Listen for state changes, errors, and completion of the upload task
        uploadTask.snapshotEvents.listen((event) {
          double progress = (event.bytesTransferred / event.totalBytes) * 100;
          print('Upload progress: $progress%');
        });

        TaskSnapshot task = await uploadTask; // Wait for the upload to complete

        print('Image upload completed.');

        // Get the download URL of the uploaded image
        print('Getting download URL...');
        String imageUrl = await task.ref.getDownloadURL();

        print('Download URL obtained: $imageUrl');

        // Update the document with the image URL
        print('Updating document...');
        await documentReference.update({
          'image': imageUrl,
          'name': name
          // Add more fields as needed
        });

        print('Document updated successfully: $userId');
      } catch (e, stackTrace) {
        print('Error updating document: $e');
        print('StackTrace: $stackTrace');

        // Simulate a slower exception handling process
        print('Slowing down exception handling...');
        await Future.delayed(const Duration(seconds: 3));
        print('Exception handling complete.');
      }
    }
  }

  Future<void> update(String name) async {
    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String userId = user.uid;
      // Get a reference to the document
      DocumentReference documentReference =
          FirebaseFirestore.instance.collection('authData').doc(userId);

      try {
        // Update the document with the image URL
        print('Updating document...');
        await documentReference.update({
          'name': name
          // Add more fields as needed
        });

        print('Document updated successfully: $userId');
      } catch (e, stackTrace) {
        print('Error updating document: $e');
        print('StackTrace: $stackTrace');

        // Simulate a slower exception handling process
        print('Slowing down exception handling...');
        await Future.delayed(const Duration(seconds: 3));
        print('Exception handling complete.');
      }
    }
  }

  final ImagePicker picker = ImagePicker();
  Future pickImageFromGallery() async {
    print("starting get image");
    // final File? pickedFile = await picker.pickImage(source: ImageSource.gallery);
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    //final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    print("getting image.....");
    setState(() {
      if (pickedFile != null) {
        print("file not null");
        _image = File(pickedFile.path);
      } else {
        print('No image selected.');
      }
    });
  }

  List<AuthModel> list = [];
  Future<void> getData() async {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String UserId = user.uid;
      print(UserId);
      DocumentReference docreference =
          FirebaseFirestore.instance.collection("authData").doc(UserId);
      DocumentSnapshot docsnapshot = await docreference.get();

      if (docsnapshot.exists) {
        Map<String, dynamic>? data =
            docsnapshot.data() as Map<String, dynamic>?;

        if (data != null) {
          var email = data['email'] as String?;
          var name = data['name'] as String?;
          var image = data['image'] as String?;

          if (image == null) {
            image = "https://upload.wikimedia.org/wikipedia/commons/3/36/Hopetoun_falls.jpg";
          }

          var info = AuthModel(email: email!, name: name!, image: image);

          list.add(info);

          print(info);
        }

        setState(() {
          NameTextController.text = list[0].name;
          EmailTextController.text = list[0].email;
          url = list[0].image;
        });
      }
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    getData();
  }

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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 10.h,
            ),
            Stack(children: [
              _image != null
                  ? Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        minRadius: 40.r,
                        maxRadius: 60.r,
                        backgroundImage: FileImage(_image!),
                      ),
                    )
                  : Center(
                      child: CircleAvatar(
                        backgroundColor: Colors.grey,
                        minRadius: 40.r,
                        maxRadius: 60.r,
                        backgroundImage: NetworkImage(url),
                      ),
                    ),
              Positioned(
                child: IconButton(
                  onPressed: () async {
                    await pickImageFromGallery();

                    await updateDocument(_image, NameTextController.text);
                  },
                  icon: const Icon(
                    Icons.add,
                    color: AppColors.greyp,
                  ),
                ),
                bottom: -10.h,
                right: 120.w,
              )
            ]),
            SizedBox(height: 5.h),

            SizedBox(
              height: 30.h,
            ),
            textField(
                hinttext: "",
                controller: EmailTextController,
                obscure: false,
                allowtoright: true),
            SizedBox(
              height: 30.h,
            ),
            textField(
                hinttext: "",
                controller: NameTextController,
                obscure: false,
                allowtoright: false),

            SizedBox(
              height: 40.h,
            ),
            GestureDetector(
              onTap: () {
                // signOutUser();
                deleteUserAndData();
              },
              child: Padding(
                padding: EdgeInsets.only(left: 20.w),
                child: text(
                    tex: "Delete Account", colorOT: AppColors.red, Size: 21.sp),
              ),
            ),
            SizedBox(
              height: 80.h,
            ),
            GestureDetector(
                onTap: () async {
                  await update(NameTextController.text);
                },
                child: Center(
                    child: container(
                        colors: AppColors.red,
                        textColor: Colors.white,
                        text: "Save",
                        h: 14,
                        w: 3,
                        r: 20)))
          ],
        ),
      ),
    );
  }
}
