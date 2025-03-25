import 'package:visionaryhome/screens/home/home_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'AuthenticationRepositry.dart';

class OTPController {
  // static OTPController get instance => Get.find();
  final auth = FirebaseAuth.instance;
  void verifyOTP(String otp) async {
    var isVerified = await Get.put(AuthenticationRepositry().verifyOTP(otp));
    isVerified ? Get.offAll(HomeScreen()) : Get.back();
  }
}
