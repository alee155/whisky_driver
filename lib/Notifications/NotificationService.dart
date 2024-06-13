import 'dart:math';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationService {
  FirebaseMessaging messaging = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();


  void initLocalNotifications(
      BuildContext context, RemoteMessage message) async {
    var androidInitializationSettings =
         const AndroidInitializationSettings("@mipmap/launcher_icon");
    var iosInitializationSettings = const DarwinInitializationSettings();

    var initializationSetting = InitializationSettings(
        android: androidInitializationSettings,
        iOS: iosInitializationSettings);
    await _flutterLocalNotificationsPlugin.initialize(initializationSetting,
        onDidReceiveBackgroundNotificationResponse: (payload) {

        });
  }

  void requestNotificationPermision() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        announcement: true,
        badge: true,
        carPlay: true,
        criticalAlert: true,
        provisional: true,
        sound: true);
    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      print("user granted permision");
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      print("user granted  provisional permision");
    } else {
      print("user denied permision");
    }
  }

  void firebaseInit() {
    FirebaseMessaging.onMessage.listen((message) {
     if (kDebugMode)  {
        print(message.notification!.title.toString());
        print(message.notification!.body.toString());
      }
     showNotification(message);

    });
  }


  // Future<void> showNotification(RemoteMessage message) async {
  //   var androidDetails = AndroidNotificationDetails(
  //     'high_importance_channel', // This should be the same as the channel id
  //     'High Importance Channel', // This should be the same as the channel name
  //
  //     importance: Importance.max,
  //     priority: Priority.high,
  //   //  icon: '@mipmap/launcher_icon', // This is where you set the small icon
  //   );
  //
  //   const DarwinNotificationDetails darwinNotificationDetails=DarwinNotificationDetails(
  //   presentAlert: true,
  //   presentBadge: true,
  //   presentSound: true
  // );
  //   var platformChannelSpecifics = NotificationDetails(
  //     android: androidDetails,
  //     iOS: darwinNotificationDetails,
  //   );
  //
  //   await _flutterLocalNotificationsPlugin.show(
  //     0,
  //     message.notification!.title,
  //     message.notification!.body,
  //     platformChannelSpecifics,
  //   );
  // }

  Future<void> showNotification( RemoteMessage message)async{

    AndroidNotificationChannel channel = AndroidNotificationChannel
      (Random.secure().nextInt(100000).toString(),
    "High Importance",
      importance: Importance.max

     );

    await _flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);




    AndroidNotificationDetails androidNotificationDetails=AndroidNotificationDetails(
     channel!.id.toString(),
      channel!.name.toString(),
      channelDescription:  "your channel description "
      ,importance:   Importance.high,
      priority: Priority.high,
    ticker: "ticker",
        icon: '@mipmap/launcher_icon'



  );
   const DarwinNotificationDetails darwinNotificationDetails=DarwinNotificationDetails(
    presentAlert: true,
    presentBadge: true,
    presentSound: true
  );

   NotificationDetails  notificationDetails =NotificationDetails(
     android: androidNotificationDetails,
     iOS: darwinNotificationDetails
   );



Future.delayed(Duration.zero,() {
  _flutterLocalNotificationsPlugin.show(
      0,
      message.notification!.title.toString(),
      message.notification!.body.toString(),
      notificationDetails
  );
});
}


  Future<String> getDeviceToken() async {
    String? token = await messaging.getToken();
    return token!;
  }

  void isTokenRefresh() async {
    messaging.onTokenRefresh.listen((event) {
      event.toString();
      print('Token refreshed: $event');
    });
  }
}
