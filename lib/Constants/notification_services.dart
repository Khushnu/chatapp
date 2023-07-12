
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class NotificationServiices { 

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance; 
  FlutterLocalNotificationsPlugin localNotificationsPlugin = FlutterLocalNotificationsPlugin();



  void initLotification(BuildContext buildContext , RemoteMessage message) async {
    var androidInitizalionSettings = AndroidInitializationSettings('@mipmap/ic_launcher'); 
    var iosInitializationSettings = DarwinInitializationSettings(); 

    var initLocalNotificationSettings = InitializationSettings(
      android:  androidInitizalionSettings, 
      iOS: iosInitializationSettings
    ); 

    await localNotificationsPlugin.initialize(initLocalNotificationSettings, 
    onDidReceiveBackgroundNotificationResponse: (payload){

    }); 
  } 


    Future<void> showNotification(RemoteMessage message) async{

        AndroidNotificationChannel channel = AndroidNotificationChannel(
          Random.secure().nextInt(1000).toString(), 
          'High Importance Notification');

        AndroidNotificationDetails androidNotificationDetails = AndroidNotificationDetails(
          channel.id.toString(), channel.name.toString(), 
          channelDescription: ' your channel discriptoon ', 
          importance: Importance.high, 
          priority: Priority.high, 
          ticker: 'ticker'); 

          DarwinNotificationDetails darwinNotificationDetails = DarwinNotificationDetails(
            presentAlert: true, 
            presentBadge: true, 
            presentSound: true
          ); 


        NotificationDetails notificationDetails = NotificationDetails(
          android: androidNotificationDetails, 
          iOS: darwinNotificationDetails
        );

      Future.delayed(Duration.zero,(){
        localNotificationsPlugin.show(
        0, 
        message.notification!.title.toString(),
        message.notification!.body.toString(),
         notificationDetails);
      } );
    }

    void firebaseInit(){
      FirebaseMessaging.onMessage.listen((event) { 
        print(event.notification!.title.toString());

        showNotification(event);
      });
    }

  Future<void>  requestNotificationPermissions() async {
  NotificationSettings settingsnoti = await  firebaseMessaging.requestPermission(
      alert: true, 
      announcement: true, 
      sound: true, 
      carPlay: true, 
      provisional: true, 
      badge: true, 
    );
    if(settingsnoti.authorizationStatus == AuthorizationStatus.authorized){
          print('user granted permission');
    } else if(settingsnoti.authorizationStatus == AuthorizationStatus.provisional) {
      print('user grandted provisional permssion');
    } else {
      print('user  permission denied');
    }
  }
      Future<String> getDeviceToken() async { 
        String? token = await firebaseMessaging.getToken(); 
        return token!;
      }
      void refreshToken() async {
         firebaseMessaging.onTokenRefresh.listen((event) {
          print('token refresh $event');
        });
      }
}