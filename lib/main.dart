import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:phone_otp_ui/phone.dart';
import 'package:phone_otp_ui/succes.dart';
import 'package:phone_otp_ui/verify.dart';
import 'location.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    initialRoute: 'phone',
    debugShowCheckedModeBanner: false,
    routes: {
      'phone': (context) => MyPhone(),
      'verify': (context) => MyVerify(),
      'location': (context) => MyLocation(),
      'succes': (context) => MySucces(),


    },

  ));
}