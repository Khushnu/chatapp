import 'package:chatapp/Screens/login_screen.dart';
import 'package:flutter/cupertino.dart';

class SpacerWidget extends StatelessWidget {
  const SpacerWidget({super.key});
 
  @override
  Widget build(BuildContext context) {
     double spacer = 0;
    if(screenHeight < 500 || screenWidth < 400){
      spacer = 5;
    } else { 
      spacer = 10;
    }
    return SizedBox(
      height: spacer * 0.2 + 10,
    );
  }
}