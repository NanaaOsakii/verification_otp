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
    return MaterialApp(

      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.white,

        body: Center(

          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,

            children: [
              const SizedBox(height: 120),
              AnimatedTextKit(
                animatedTexts: [
                  ScaleAnimatedText(
                    'Your registration was successful !',
                    textStyle: TextStyle(fontSize: 25.0, fontFamily: 'Bobbers',fontWeight: FontWeight.bold,color: Colors.black),
                  ),

                ],
              ),
              SizedBox(
                height: 80,
              ),

              Image.asset("images/illustration-1.png",width: 230,),
              SizedBox(
                height: 10,
              ),

              Text("", textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent[200],
                ),
              ),

            ],

          ),

        ),
      ),
    );
  }

}
