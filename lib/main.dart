import 'package:chatapp/Constants/helperfunctions.dart';
import 'package:chatapp/Screens/homepage_screen.dart';
import 'package:chatapp/Screens/login_screen.dart';
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
  runApp(const MyApp()); 
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> { 
  bool _isSingedint = false;
  String email = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userLogedin();
  }

  userLogedin() async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    
     var e =  sp.getString(email);  
     print(e);
     if(sp.getString(email)!.isNotEmpty){
      setState(() {
        _isSingedint = true;
      });
     }
      // HelperFunction.getuserLogin().then((value) {
      //   if(value != null){
      //     setState(() {
      //           _isSingedint = value; 
      //     });
        
      //   }
      // });
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _isSingedint ? const HomePageScreen() : const LoginScreen(),
    );
  }
}