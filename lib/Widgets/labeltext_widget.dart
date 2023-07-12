import 'package:chatapp/Screens/login_screen.dart';
import 'package:flutter/cupertino.dart';

class LabelTextWidget extends StatelessWidget {
  const LabelTextWidget({super.key, required this.text, required this.fontsize,  this.bold, });
  final String text;
  final double fontsize;
  final FontWeight? bold;
  @override
  Widget build(BuildContext context) {
   
    return Text(text, style: TextStyle(fontSize: screenHeight < 500 && screenWidth < 400 ? fontsize * screenHeight * 0.1 - 150 : fontsize * screenHeight * 0.1 - 145, fontWeight: bold),);
  }
}