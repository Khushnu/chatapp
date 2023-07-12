import 'package:flutter/material.dart';

import '../Screens/login_screen.dart';

class ButtonWidget extends StatefulWidget {
  const ButtonWidget({super.key, required this.ontap, required this.widget});
  final Function() ontap;
  final Widget widget;

  @override
  State<ButtonWidget> createState() => _ButtonWidgetState();
}

class _ButtonWidgetState extends State<ButtonWidget> {
  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    print(screenHeight);
    return  GestureDetector(
                onTap: widget.ontap,
               child: Container(
                height: screenWidth < 400 ? screenHeight * 0.1 - 30 : screenHeight * 0.1 - 24,
                width: screenHeight < 500 ? screenWidth * 0.9 + 21 : screenWidth * 0.9 + 21,
                decoration: BoxDecoration(
                  color: Colors.red.shade300, 
                  borderRadius: BorderRadius.circular(20)
                ),
                child: Center(child: widget.widget),
               ),
             );
  }
}