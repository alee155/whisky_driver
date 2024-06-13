import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:provider/provider.dart';
import 'package:whisky_driver/Views/BottomW/bottom_w.dart';
import 'package:whisky_driver/Views/SplashScreen/splash_screen.dart';

import 'Models/providers/providerChangeColor.dart';
import 'Models/providers/setiing_text.dart';

import 'Views/SignIn/signIn.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      builder: (_, child) {
        return MultiProvider(providers: [
          ChangeNotifierProvider(create: (_)=>colorProvider() ),
          ChangeNotifierProvider(create: (_)=>textSetting() )

        ] ,
         child:  GetMaterialApp(
          debugShowCheckedModeBanner: false,
          builder: EasyLoading.init(),
          theme: ThemeData(
            fontFamily: 'Montserrat-Bold', // Set default font family here
          ),
          home: StreamBuilder<User?>(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return signIn(); // Show loading screen while waiting for auth state  signIn
              } else {
                if (snapshot.hasData) {
                  return bottomW(); // User is signed in, show home screen  bottomW
                } else {
                  return signIn(); // No user is signed in, show login screen signIn
                }
              }
            },
          ),
        ));
      },
    );
  }
}
