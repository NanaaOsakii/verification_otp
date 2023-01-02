import 'dart:async';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:phone_otp_ui/phone.dart';
class MySucces extends StatefulWidget {
  const MySucces({Key? key}) : super(key: key);

  @override
  State<MySucces> createState() => _MySuccesState();
}

class _MySuccesState extends State<MySucces> {

  @override
  void initState() {
    super.initState();

    Timer(
      Duration(seconds: 3),
          () =>
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => MyPhone(),
            ),
          ),
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text('Welcome to D-ONE'),
        backgroundColor:Colors.cyan,
      ),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedTextKit(
              animatedTexts: [

                ScaleAnimatedText(
                  'Congratulation !',
                  textStyle: TextStyle(fontSize: 32.0, fontFamily: 'Bobbers'),
                ),

              ],
            ),


            Image.asset("images/7.jpg",height: 300,),
            SizedBox(
              height: 10,
            ),
            Text("Your registration was successful!", textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 22,
              ),
            ),

          ],
        ),
      ),
    );
  }

}
