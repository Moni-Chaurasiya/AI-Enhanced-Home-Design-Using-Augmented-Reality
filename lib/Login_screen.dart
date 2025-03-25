import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:email_validator/email_validator.dart';
import 'package:visionaryhome/forget_password_screen.dart';
import 'package:visionaryhome/screens/home/home_screen.dart';
import 'Register_screen.dart';
import 'default_textformfield.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController email = TextEditingController();
  final TextEditingController password = TextEditingController();
  final auth = FirebaseAuth.instance;
  final formKey = GlobalKey<FormState>();

  bool isEmailorPasswordWrong = false; // Added this variable

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
                padding: EdgeInsets.only(top: 50),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 20),
                  child: Form(
                    key: formKey,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'Please login with your personal information.',
                          style: TextStyle(
                              color: Color.fromARGB(255, 124, 123, 123)),
                        ),
                        const SizedBox(height: 40),
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
                        SizedBox(height: 20),
                        defaultTextFormField(
                          hintText: 'Password',
                          icon: Icons.lock,
                          obscureText: true,
                          type: TextInputType.visiblePassword,
                          controller: password,
                          fieldOnChange: (value) {
                            if (formKey.currentState != null) {
                              formKey.currentState!.validate();
                            }
                            return null;
                          },
                          fieldValidator: (password) {
                            if (password == null || password.isEmpty) {
                              return 'Enter a Password';
                            } else if (password.length < 6) {
                              return 'Password must be at least 6 characters';
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: 10),

                        // Showing the error message if email or password are wrong
                        Visibility(
                          visible: isEmailorPasswordWrong,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Either Email or Password are wrong',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                        ),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => ForgetPasswordScreen(),
                                ),
                              );
                            },
                            child: Text('Forgot Password?',
                                style: TextStyle(color: Colors.blueAccent)),
                          ),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () async {
                            if (formKey.currentState!.validate()) {
                              try {
                                final user =
                                    await auth.signInWithEmailAndPassword(
                                  email: email.text,
                                  password: password.text,
                                );
                                if (user.user != null) {
                                  setState(() {
                                    isEmailorPasswordWrong = false;
                                  });
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => HomeScreen(),
                                    ),
                                  );
                                }
                              } catch (e) {
                                print('Login Failed: $e');
                                setState(() {
                                  isEmailorPasswordWrong = true;
                                });
                              }
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
                          child: Text(
                            'Login',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Don\'t have an account?',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 236, 1, 1))),
                            TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => RegisterScreen(),
                                  ),
                                );
                              },
                              child: Text(
                                'Sign Up',
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
}
