import 'package:chatapp/Constants/notification_services.dart';
import 'package:chatapp/Screens/homepage_screen.dart';
import 'package:chatapp/Screens/login_screen.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); 
  if(kIsWeb){
     await Firebase.initializeApp(
      options: FirebaseOptions(
        apiKey: DefaultFirebaseOptions.web.apiKey,
         appId: DefaultFirebaseOptions.web.appId, 
         messagingSenderId: DefaultFirebaseOptions.web.messagingSenderId,
          projectId: DefaultFirebaseOptions.web.projectId)
     );
  } else  {

    await Firebase.initializeApp();
   }
   FirebaseMessaging.onBackgroundMessage(_firebasemessagingbackgroundHandler);
  runApp(const MyApp()); 
}
@pragma('vm:entry-point')
Future<void> _firebasemessagingbackgroundHandler(RemoteMessage remoteMessage) async {
await Firebase.initializeApp(); 
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> { 
  bool _isSingedint = false;
 NotificationServiices notificationServiices  = NotificationServiices();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userLogedin();
    notificationServiices.requestNotificationPermission();
    notificationServiices.setupInteractMessage(context);
    notificationServiices.forgroundMessage();
    notificationServiices.getDeviceToken().then((value) {
      print('device Token: $value');
    }); 
    notificationServiices.firebaseInit(context);
  }

  userLogedin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    var token = sp.getString('email')?? "";
     print(token);
     if(token.isNotEmpty){
      setState(() {
        _isSingedint = true;
      });
     }

  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isSingedint ? const HomePageScreen() : const LoginScreen(),
    );
  }
}