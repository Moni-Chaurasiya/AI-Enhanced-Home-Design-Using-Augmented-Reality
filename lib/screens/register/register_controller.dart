//import 'package:visionaryhome/screens/register/authentication/AuthenticationRepositry.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

import 'Register_screen.dart';

class RegisterController extends GetxController {
  static RegisterController get intance => Get.find();
  final auth = FirebaseAuth.instance;
  String verificationId = "";
  void phoneAuthentication(String phone) async {
    await auth.verifyPhoneNumber(
      phoneNumber: phone,
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Get.snackbar('Error', 'the provided phone number is not valid');
        } else {
          Get.snackbar('Error', 'something went wrong try again ');
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        RegisterScreen.verificationID = verificationId;
        // Navigator.pushNamed(context, "otp");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
