//import 'package:visionaryhome/screens/home/home_screen.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:firebase_auth/firebase_auth.dart';

import 'package:email_validator/email_validator.dart';
//import 'package:get/get.dart';
//import 'package:get/get_core/src/get_main.dart';
import 'package:visionaryhome/user_model.dart';

import 'Login_screen.dart';
//import 'data/data.dart';
import 'data/fetch.dart';
import 'default_textformfield.dart';

class RegisterScreen extends StatefulWidget {
  static String verificationID = "";

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool ValidatePassword(String pass) {
    String _password = pass.trim();
    Future.delayed(Duration.zero, () {
      if (_password.isEmpty) {
        setState(() {
          password_strength = 0;
        });
      } else if (_password.length < 6) {
        setState(() {
          password_strength = 1 / 4;
        });
      } else if (_password.length < 8) {
        setState(() {
          password_strength = 2 / 4;
        });
      } else {
        if (passwordValid.hasMatch(_password)) {
          setState(() {
            password_strength = 4 / 4;
          });
          return true;
        } else {
          setState(() {
            password_strength = 3 / 4;
          });
          return false;
        }
      }
    });
    if (password_strength == 1) {
      return true;
    }

    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 1, 34, 84),
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 70),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/Home/logo.png', height: 80),
                    const SizedBox(width: 10),
                    const Text(
                      'Visionary Home',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                constraints: BoxConstraints(
                  minHeight: MediaQuery.of(context).size.height - 150,
                ),
                width: double.infinity,
                padding: const EdgeInsets.only(top: 50),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Please register with your personal information.',
                          style: TextStyle(
                            color: Color.fromARGB(255, 124, 123, 123),
                          ),
                        ),
                        const SizedBox(height: 40),
                        defaultTextFormField(
                          hintText: 'User Name',
                          icon: Icons.person,
                          type: TextInputType.text,
                          controller: userName,
                          fieldOnChange: (value) {
                            if (formKey.currentState != null) {
                              formKey.currentState!.validate();
                            }
                            return null;
                          },
                          fieldValidator: (username) {
                            if (username == null || username.isEmpty) {
                              return 'Enter a username';
                            } else if (username.length < 7) {
                              return 'User name is too short';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 35),
                        defaultTextFormField(
                          hintText: 'Email',
                          icon: Icons.email_outlined,
                          type: TextInputType.emailAddress,
                          controller: email,
                          fieldOnChange: (value) {
                            if (formKey.currentState != null) {
                              formKey.currentState!.validate();
                            }
                            return null;
                          },
                          fieldValidator: (email) {
                            if (email == null || email.isEmpty) {
                              return 'Enter an Email';
                            } else if (!EmailValidator.validate(email)) {
                              return 'Enter a Valid Email';
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 35),
                        defaultTextFormField(
                          hintText: 'Password',
                          icon: Icons.lock,
                          obscureText: true,
                          controller: password,
                          fieldOnChange: (value) {
                            if (formKey.currentState != null) {
                              formKey.currentState!.validate();
                            }
                            return null;
                          },
                          fieldValidator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a password';
                            } else {
                              // Call function to check password
                              bool result = ValidatePassword(value);
                              if (!result) {
                                return 'Password should contain a capital letter, small letter, number, and special character';
                              }
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 35),
                        defaultTextFormField(
                          hintText: 'Phone Number',
                          icon: Icons.phone,
                          type: TextInputType.phone,
                          controller: PhoneNumber,
                          fieldOnChange: (value) {
                            if (formKey.currentState != null) {
                              formKey.currentState!.validate();
                            }
                            return null;
                          },
                          fieldValidator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter a phone number';
                            } else if (value.length != 10) {
                              // Assuming a 10-digit phone number
                              return 'Phone number is not valid';
                            }
                            return null;
                          },
                        ),
                        password.text.isEmpty
                            ? const SizedBox()
                            : const Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  'Password Strength',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )),
                        const SizedBox(
                          height: 15,
                        ),
                        password.text.isEmpty
                            ? const SizedBox()
                            : LinearProgressIndicator(
                                value: password_strength,
                                minHeight: 5,
                                backgroundColor: Colors.white,
                                color: password_strength <= 1 / 4
                                    ? Colors.red
                                    : password_strength == 2 / 4
                                        ? Colors.yellow
                                        : password_strength == 3 / 4
                                            ? Colors.orange
                                            : Colors.green,
                              ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              final user = UserModel(
                                Name: userName.text.trim(),
                                Email: email.text.trim(),
                                Password: password.text.trim(),
                                Phone: PhoneNumber.text.trim(),
                              );
                              createUser(user);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => LoginScreen(),
                                ),
                              );
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 1, 34, 84),
                            padding: EdgeInsets.symmetric(
                                horizontal: 100, vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          child: const Text(
                            'REGISTER',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Text(
                              'Already have an Account ? ',
                              style: TextStyle(
                                  color: Color.fromARGB(255, 236, 1, 1)),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => LoginScreen(),
                                  ),
                                );
                              },
                              child: const Text(
                                'Sign In',
                                style: TextStyle(color: Colors.blueAccent),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  final db = FirebaseFirestore.instance;
  createUser(UserModel user) async {
    await FirebaseAuth.instance.createUserWithEmailAndPassword(
      email: user.Email,
      password: user.Password,
    );
    /*  await db.collection("Users").add(user.toJason()).whenComplete(() =>
        // Get.snackbar("success", "your account has been created",
        //     snackPosition: SnackPosition.BOTTOM
        // ),
      print("success")

    ).catchError((error,stackTrace){
      // Get.snackbar("error", "somthing went wrong",
      //   snackPosition: SnackPosition.BOTTOM

     // );
      print(error.toString());
    });*/
  }

  void phoneAuthentication(String phone) async {
    await auth.verifyPhoneNumber(
      phoneNumber: PhoneNumber.text,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          // Get.snackbar('Error', 'the provided phone number is not valid');
          print("the provided phone number is not valid");
        }
        // else{
        //   Get.snackbar('Error', 'something went wrong try again ');
        //
        // }
      },
      codeSent: (String verificationId, int? resendToken) {
        RegisterScreen.verificationID = verificationId;
        Navigator.pushNamed(context, "otp");
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
