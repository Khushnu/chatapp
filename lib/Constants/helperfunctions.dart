import 'package:chatapp/Screens/login_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HelperFunction {

static String userLogginedKey = '';
static String userNameKey = "userNameKey"; 
static String userEmailKey = "userEmailKey";



Future getData() async { 
CollectionReference _collectionRef =
    FirebaseFirestore.instance.collection('user');
QuerySnapshot snap = await _collectionRef.get(); 
final alldata = snap.docs.map((e) => e.data()).toList(); 
print(alldata);


}
// static getuserLogin() async {
//   SharedPreferences sp = await SharedPreferences.getInstance();
//   print(userLogginedKey); 
//   return sp.getString(userLogginedKey);
// }

static Future<User?> createAccount(String name, String userLogginedKey, String password) async { 
  FirebaseAuth firebaseAuth = FirebaseAuth.instance; 
  FirebaseFirestore firestore = FirebaseFirestore.instance;
   
try {
  User? user = (await firebaseAuth.createUserWithEmailAndPassword(
    email: userLogginedKey, 
    password: password)).user;  

    if(user != null){
      user.updateDisplayName(name);
      print('Acocunt Succesful'); 
   
    await firestore.collection('user').doc(firebaseAuth.currentUser!.uid).set({
      "name" : name, 
      "email" : userLogginedKey,
      "status" : "Unavailable",
      "uid" : firebaseAuth.currentUser!.uid

    });
  
      return user;
    } else {
      print('Account Creation Failed'); 
      return user;
    }

} catch(e) {
  print(e);
}
return null;

}


static Future<User?> login(userLogginedKey , String password) async{ 
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;  
  // FirebaseFirestore firestore = FirebaseFirestore.instance;
  SharedPreferences sp = await SharedPreferences.getInstance(); 

  try {
    User? user = (await firebaseAuth.signInWithEmailAndPassword(email: userLogginedKey, password: password)).user; 
    if(user != null){ 
      print('login succesful');  
       sp.setString('email', userLogginedKey ); 
       
      return user;
    } else { 
      print('failed login');  
      return user; 
    }
  } catch (e) {
    print(e); 
  }
  return null;
}

  static Future logOut(BuildContext context) async {
    FirebaseAuth firebaseAuth = FirebaseAuth.instance; 
    SharedPreferences sp = await SharedPreferences.getInstance();

    try {
      await firebaseAuth.signOut().then((value) {
        sp.clear();
        Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
      });
    } catch (e) {
      print(e);
    }
  }

}