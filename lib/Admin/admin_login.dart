import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import '../components/default_textformfield.dart';
import '../screens/home/home_screen.dart';
//import '../screens/login/Login_screen.dart';

class AdminSignIScreen extends StatefulWidget {
  const AdminSignIScreen({Key? key}) : super(key: key);

  @override
  _AdminSignIScreenState createState() => _AdminSignIScreenState();
}

class _AdminSignIScreenState extends State<AdminSignIScreen> {
  bool isEmailorPasswordWrong = false;

  final TextEditingController adminEmail = TextEditingController();

  final TextEditingController adminPassword = TextEditingController();

  final TextEditingController adminUserName = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black,
            child: Opacity(
              opacity: 0.3,
              child: Image.network(
                'https://cdn.decoist.com/wp-content/uploads/2020/04/Gorgeous-black-and-white-striped-accent-chairs-make-a-big-splash-in-this-traditional-living-room-of-home-in-Austin-19553.jpg',
                fit: BoxFit.cover,
              ),
            ),
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Form(
                      key: formKey,
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 35,
                          ),
                          defaultTextFormField(
                            hintText: 'Email',
                            fieldonChange: (value) {
                              formKey.currentState!.validate();
                              return null;
                            },
                            icon: Icons.email_outlined,
                            color: Colors.orangeAccent,
                            Type: TextInputType.emailAddress,
                            controller: adminEmail,
                            fieldValidator: (Email) {
                              if (Email.isEmpty) {
                                return 'Enter a Email';
                              } else if (Email != null &&
                                  !EmailValidator.validate(Email)) {
                                return 'Enter a Valid Email';
                              } else {
                                isEmailorPasswordWrong = false;
                                setState(() {});
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 35,
                          ),
                          defaultTextFormField(
                            hintText: 'Password',
                            fieldonChange: (value) {
                              formKey.currentState!.validate();
                              return null;
                            },
                            icon: Icons.lock,
                            color: Colors.orangeAccent,
                            obscureText: true,
                            Type: TextInputType.visiblePassword,
                            controller: adminPassword,
                            fieldValidator: (Password) {
                              if (Password.isEmpty) {
                                return 'Enter a Password';
                              } else if (Password != null &&
                                  Password.length < 6) {
                                return 'Enter a Valid Password';
                              } else {
                                isEmailorPasswordWrong = false;
                                setState(() {});
                                return null;
                              }
                            },
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Visibility(
                              visible: isEmailorPasswordWrong,
                              child: Text(
                                'Either Email or Password are wrong',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, 'forget');
                            },
                            child: const Text(
                              'Forget Password?',
                              style: TextStyle(
                                color: Colors.orangeAccent,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Container(
                            width: 200,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                gradient: const LinearGradient(
                                  begin: Alignment.centerLeft,
                                  colors: <Color>[
                                    Color(0xffff5983),
                                    Colors.orangeAccent,
                                  ],
                                )),
                            child: MaterialButton(
                              onPressed: () async {
                                try {
                                  loginAdmin();
                                  final validForm =
                                      formKey.currentState!.validate();
                                  if (validForm) {
                                    // final User = await auth
                                    //     .signInWithEmailAndPassword(
                                    //     email: email.text,
                                    //     password: password.text);
                                    //  print(email.text.toString());
                                    print("logged successfuly");
                                    // username=userName.text;
                                    isEmailorPasswordWrong = false;
                                    setState(() {});

                                    // if (User != null) {

                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                HomeScreen()));
                                    //  }
                                  }
                                } catch (e) {
                                  print(e);
                                  print("error in login");
                                  isEmailorPasswordWrong = true;
                                  setState(() {});
                                }
                              },
                              child: const Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white, fontSize: 20),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              //
                              // TextButton(onPressed: () {
                              //   Navigator.push(context, MaterialPageRoute(
                              //       builder: (context) => LoginScreen()));
                              // },
                              //     child: const Text(
                              //       'Login as a user ', style: TextStyle(
                              //       fontSize: 20,
                              //       color: Colors.orangeAccent,),)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> loginAdmin() async {
    CollectionReference _collectionRef =
        FirebaseFirestore.instance.collection('Admins');

    // Get docs from collection reference
    QuerySnapshot querySnapshot = await _collectionRef.get();

    // Get data from docs and convert map to List
    final allData = querySnapshot.docs.map((doc) => doc.data()).toList();
    // print("admin data");
    // print(allData);
    // print(allData.indexOf(0));
    if (allData.indexOf(0) != adminPassword.text.trim()) {
      print("your password is not correct");
    } else if (allData.indexOf(1) != adminEmail.text.trim()) {
      print("your email is not correct");
    } else {
      print("admin logged succefully");
      setState(() {
        adminEmail.text = "";
        adminPassword.text = "";
      });
    }
//     final db = FirebaseFirestore.instance ;
//   db.collection("Admins").get().then((snapshots){
// snapshots.docs.forEach((element) {
//
//   if (element.data["email"]!=adminEmail.text.trim()){
//
//   }
// });
//
//
//  });
  }
}
