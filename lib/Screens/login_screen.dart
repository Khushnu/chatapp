import 'package:chatapp/Constants/helperfunctions.dart';
import 'package:chatapp/Screens/homepage_screen.dart';
import 'package:chatapp/Screens/signup_screen.dart';
import 'package:chatapp/Widgets/labeltext_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Widgets/buttonlogin_widget.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

double screenHeight = 0;
double screenWidth = 0;

class _LoginScreenState extends State<LoginScreen> {
  final formkey = GlobalKey<FormState>();
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  bool islogin = true;
  String emails = '';
  String pass = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkprogressbar();
  }

  checkprogressbar() {
    if (email.text.isEmpty && password.text.isEmpty) {
      setState(() {
        islogin = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const LabelTextWidget(
                text: 'ChitChat',
                fontsize: 3,
                bold: FontWeight.bold,
              ),
              const LabelTextWidget(text: 'Login to Start Chat', fontsize: 2),
              SizedBox(
                  height: screenHeight < 400
                      ? screenHeight * 0.3
                      : screenHeight * 0.5 - 20,
                  child: Image.asset(
                    'images/login.png',
                  )),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 1),
                child: Form(
                  key: formkey,
                  child: Column(
                    children: [
                      TextFormField(
                        controller: email,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter Email';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            emails = val;
                          }
                        );
                      },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.email),
                          prefixIconColor: Colors.red,
                          labelText: 'Email ',
                          labelStyle: TextStyle(color: Colors.red),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5)),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextFormField(
                        controller: password,
                        validator: (value) {
                          if (value!.isEmpty) {
                            return 'Please Enter  correct password';
                          }
                          return null;
                        },
                        onChanged: (val) {
                          setState(() {
                            pass = val;
                          });
                        },
                        decoration: const InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          prefixIconColor: Colors.red,
                          labelText: 'Password ',
                          labelStyle: TextStyle(color: Colors.red),
                          enabledBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5)),
                          errorBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5)),
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1.5)),
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      ButtonWidget(
                          ontap: () async {
                            SharedPreferences sp = await SharedPreferences.getInstance();
                            if (formkey.currentState!.validate()) {
                              if (email.text.isNotEmpty &&
                                  password.text.isNotEmpty) {
                                setState(() {
                                  islogin = true;
                                });
                              }

                              HelperFunction.login(email.text, password.text)
                                  .then((value) {
                                if (value != null) {
                                  setState(() {
                                    islogin = false;
                                    var e = sp.setString('email', email.text);

                                    print(e);
                                  });
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              const HomePageScreen()));
                                }
                              });
                            }
                          },
                          widget: islogin
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  'Login',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white),
                                )),
                      const SizedBox(
                        height: 10,
                      ),
                      RichText(
                          text: TextSpan(
                              text: "Don't have an account? ",
                              style: TextStyle(
                                  fontSize: 15, color: Colors.grey.shade700),
                              children: [
                            TextSpan(
                              text: 'Create an Account',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (_) {
                                    return const SignUpScreen();
                                  }));
                                },
                            )
                          ]))
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
