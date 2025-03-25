/*
import 'package:visionaryhome/screens/register/authentication/AuthenticationRepositry.dart';
import 'package:visionaryhome/screens/register/authentication/otp_controller.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:visionaryhome/screens/register/register_controller.dart';

import '../../data/data.dart';
import '../home/home_screen.dart';
import '../register/Register_screen.dart';
class OTPScreen extends StatelessWidget {
  OTPScreen({Key? key}) : super(key: key);
  String otp='1234';
  final  auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {

    return Scaffold(

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            OTPTextField(
              length: 6,
              width: MediaQuery.of(context).size.width,
              fieldWidth: 30,
              style: TextStyle(
                  fontSize: 17
              ),
              textFieldAlignment: MainAxisAlignment.spaceAround,
              fieldStyle: FieldStyle.underline,
              onChanged: (value){
                otp=value;
                print(value);
              },
              onCompleted: (pin) {

                otp=pin;


              },
            ),

            ElevatedButton(onPressed: ()
            async{
              // OTPController.instance.verifyOTP(otp);
              try {
                verifyOTP(otp);
                final NewUser = await auth
                    .createUserWithEmailAndPassword(
                    email: email.text,
                     password: password.text);
                    print("created new user");
                Navigator.pushNamedAndRemoveUntil(context, "home", (route) => false);
              }
              catch(e){
                print("wrong otp");
              }


            }, child: Text('Next')),
          ],
        ),
      ),
    );
  }
Future verifyOTP (String otp) async{
  PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: RegisterScreen.verificationID, smsCode: otp);
  await auth.signInWithCredential(credential);

}
}
*/
