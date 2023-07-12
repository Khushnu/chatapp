
import 'package:firebase_messaging/firebase_messaging.dart';

class NotificationServiices { 

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance; 


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

}