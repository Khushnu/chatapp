
import 'package:chatapp/Constants/helperfunctions.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../Widgets/buttonlogin_widget.dart';
import '../Widgets/labeltext_widget.dart';

import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
   final formkey = GlobalKey<FormState>();
   final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController fullname = TextEditingController();
  bool isSignedUp = false;
  String emails = '';
  String pass = ''; 
  String name = '';


@override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkprogress();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    email.dispose(); 
    password.dispose(); 
    fullname.dispose();
  }

  checkprogress(){
     if(fullname.text.isEmpty && email.text.isEmpty && password.text.isEmpty){
                setState(() {
                  isSignedUp = false;
                });
              }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
             mainAxisAlignment: MainAxisAlignment.start,
              children: [
              const LabelTextWidget(text: 'ChitChat', fontsize: 2, bold: FontWeight.bold,), 
               
              const  LabelTextWidget(text: 'Create Account to Start Chat', fontsize: 2, ),
                Image.asset('images/register.png', height: screenHeight * 0.4 - 20 , ), 
              const SizedBox(), 
               Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
      child: Form(
        key: formkey,
        child: Column(
          children: [
            TextFormField(
              controller: fullname,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter your Name';
                      }
                      return null;
                    }
                    ,
                    onChanged: (val){
                    setState(() {
                      name = val;
                    
                    });
                    },
                        decoration:const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Colors.red,
                          labelText: 'Full Name ', 
                          labelStyle:  TextStyle(color: Colors.red),
                          enabledBorder:  OutlineInputBorder(
                            
                            borderSide: BorderSide(
                              color: Colors.red, 
                              width: 1.5
                            )
                          ), 
                          errorBorder:  OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red, 
                              width: 1.5
                            )
                          ), 
                          focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red, 
                              width: 1.5
                            )
                          ), 
                        ),
                      ), 
                      const SizedBox(
                        height: 10,
                      ),
            TextFormField(
              controller: email,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter Email';
                      }
                      return null;
                    }
                    ,
                    onChanged: (val){
                    setState(() {
                      emails = val;
                    
                    });
                    },
                        decoration:const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Colors.red,
                          labelText: 'Email ', 
                          labelStyle:  TextStyle(color: Colors.red),
                          enabledBorder:  OutlineInputBorder(
                            
                            borderSide: BorderSide(
                              color: Colors.red, 
                              width: 1.5
                            )
                          ), 
                          errorBorder:  OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red, 
                              width: 1.5
                            )
                          ), 
                          focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red, 
                              width: 1.5
                            )
                          ), 
                        ),
                      ), 
                      const SizedBox(
                        height: 10,
                      ),
                      TextFormField(
              controller: password,
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Please Enter  correct password';
                      }
                      return null;
                    }
                    ,
                     onChanged: (val){
                    setState(() {
                      pass = val;
                    });
                    },
                        decoration:const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          prefixIconColor: Colors.red,
                          labelText: 'Password ', 
                          labelStyle:  TextStyle(color: Colors.red),
                          enabledBorder:  OutlineInputBorder(
                            
                            borderSide: BorderSide(
                              color: Colors.red, 
                              width: 1.5
                            )
                          ), 
                          errorBorder:  OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red, 
                              width: 1.5
                            )
                          ), 
                          focusedBorder:  OutlineInputBorder(
                            borderSide: BorderSide(
                              color: Colors.red, 
                              width: 1.5
                            )
                          ), 
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ), 
                    ButtonWidget(ontap: (){
             if(formkey.currentState!.validate()){
              if(fullname.text.isNotEmpty && email.text.isNotEmpty && password.text.isNotEmpty){
                  setState(() {
                    isSignedUp = true;
                  });
              }
             
              HelperFunction.createAccount(fullname.text, email.text, password.text).then((value) {
                if(value != null){
                  setState(() {
                    print('account created successfull');
                    isSignedUp = false;
                      
                  });
                  Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginScreen()));
                } else { 
                  print('Signup Failed');
                }
              });
             }
            }, widget: isSignedUp ? const CircularProgressIndicator(
              color: Colors.white,
            ) : const Text('SignUp', style: TextStyle(fontSize: 16, 
            fontWeight: FontWeight.w500, color: Colors.white))), 
            const SizedBox(
              height: 4,
            ),  
            RichText(text: TextSpan(
              text: "Already have an account? ", 
              style: TextStyle(fontSize: 15, color: Colors.grey.shade700), 
              children: [
                TextSpan(
                  text: 'Log in', 
                  style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600), 
                  recognizer: TapGestureRecognizer()..onTap = (){
                     Navigator.of(context).pop();
                  },
                )
              ]
            ))      
          ],
        ),
      ),
    )
              
              ],
            ),
          ),
        ),
    );
  }
}