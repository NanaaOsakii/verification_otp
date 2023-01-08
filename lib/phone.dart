import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class MyPhone extends StatefulWidget {
  const MyPhone({Key? key}) : super(key: key);
  static String verify= "";

  @override
  State<MyPhone> createState() => _MyPhoneState();
}

class _MyPhoneState extends State<MyPhone> {
  TextEditingController countrycode = TextEditingController();
  var phone="";

  @override
  void initState() {
    // TODO: implement initState
    countrycode.text = "+212";
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          leading: IconButton(
            onPressed: () {
    Navigator.pushNamedAndRemoveUntil(
      context,
      'verify',
          (route) => false,
    );
  },
            icon: Icon(
              Icons.arrow_back_ios_rounded,
              color: Colors.black,
            ),
          ),
          elevation: 0,
        ),

        body: Container(
        margin: EdgeInsets.only(left: 25, right: 25),
        alignment: Alignment.center,

          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "images/ot.png",
                  width: 250,
                  height: 250,
                ),
                SizedBox(
                  height: 25,
                ),
                Text(
                  "Phone Verification",
                  style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.blueAccent[200]),
                ),
                SizedBox(
                  height: 10,
                ),
                Text(
                  "We will send you an One Time Password on this mobile number!",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 30,
                ),
                Container(
                  height: 55,
                  decoration: BoxDecoration(
                      border: Border.all(width: 1, color: Colors.grey),
                      borderRadius: BorderRadius.circular(10)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 40,
                        child: TextField(
                          controller: countrycode,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      Text(
                        "|",
                        style: TextStyle(fontSize: 33, color: Colors.grey),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Expanded(
                          child: TextField(
                            onChanged: (value){
                              phone=value;
                            },
                            keyboardType: TextInputType.phone,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: "Phone",
                            ),
                          ))
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                SizedBox(
                  width: double.infinity,
                  height: 45,
                  child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          primary: Colors.blueAccent[200],
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10))),
                      onPressed: () async{
                        await FirebaseAuth.instance.verifyPhoneNumber(
                          phoneNumber: '${countrycode.text+phone}',
                          verificationCompleted: (PhoneAuthCredential credential) {},
                          verificationFailed: (FirebaseAuthException e) {},
                          codeSent: (String verificationId, int? resendToken) {
                            MyPhone.verify=verificationId;
                          },
                          codeAutoRetrievalTimeout: (String verificationId) {},
                        );
                        Navigator.pushNamed(context, 'verify');
                      },

                      child: Text("GET OTP")),
                )
              ],

            ),


          ),


      ),

      ),
    );
  }
}