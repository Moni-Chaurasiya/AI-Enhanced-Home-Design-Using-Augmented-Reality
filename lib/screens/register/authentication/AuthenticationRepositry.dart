


import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/state_manager.dart';

import '../Register_screen.dart';
class AuthenticationRepositry extends GetxController{
  final auth =FirebaseAuth.instance;
  String   verificationId = "";
//static AuthenticationRepositry get instance => Get.find();
void phoneAuthentication (String phone){
auth.verifyPhoneNumber(
  phoneNumber: phone,
    verificationCompleted: (credential)async{
await auth.signInWithCredential(credential).then((value) => print("logged succfully"));
    },
    verificationFailed: (e) {
if(e.code=='invalid-phone-number'){
Get.snackbar('Error', 'the provided phone number is not valid');
}
else{
  Get.snackbar('Error', 'something went wrong try again ');

}
    },
    codeSent: (verficationId,token){
    this.verificationId=verficationId;
    print("verIDcodesent"+verificationId);
    },
    codeAutoRetrievalTimeout: (verficatioId){
      this.verificationId=verficatioId;
    }
);
}
Future verifyOTP(String otp) async{
  print("verID"+verificationId);

  PhoneAuthCredential credential = PhoneAuthProvider.credential(
      verificationId: RegisterScreen.verificationID, smsCode: otp);
  await auth.signInWithCredential(credential);
  // return credential.user!=null?true:false;
}
}
