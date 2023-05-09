import 'dart:io';

import 'package:attendance/components/text_button.dart';
import 'package:attendance/main.dart';
import 'package:attendance/providers/constants.dart';
import 'package:attendance/screens/loading_screen.dart';
import 'package:attendance/services/login_service.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../services/auth.dart';

class LogInScreen extends StatefulWidget {
  static const id = '/logInScreen';
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  var emailController = TextEditingController(text: 'ahmed@digitalorder.net');
  var passwordController = TextEditingController(text: '123456');
  bool isPassword = true;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final _myBox = Hive.box('myBox');
  bool? isBiometricsEnabled;
  String message = '';
  bool isValidate = true;
  AuthServiceAPI authService = AuthServiceAPI();

  @override
  void initState() {
    if (_myBox.get('isBiometricsEnabled') != null) {
      isBiometricsEnabled = _myBox.get('isBiometricsEnabled');
    }

    // get company domain

    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kScaffoldColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButtonWidget(
                        text: 'العربية',
                        textDecoration: TextDecoration.underline,
                      ),
                    ],
                  ),
                  Image.asset(
                    'assets/images/Login.png',
                    height: 150,
                    width: 150,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text('Welcome',
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      )),
                  const SizedBox(
                    height: 70,
                  ),
                  Text(
                    message,
                    style: TextStyle(color: Colors.red),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: isValidate ? Colors.grey : Colors.red),
                      labelText: 'Email Address',
                      prefixIcon: Icon(
                        FontAwesomeIcons.solidEnvelope,
                        color: isValidate ? Colors.grey : Colors.red,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: isValidate ? Colors.grey : Colors.red),
                        borderRadius: BorderRadius.circular(50),
                      ),

                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      // errorBorder: OutlineInputBorder(
                      //     borderSide: BorderSide(color: Colors.red, width: 1))
                      // errorText: getLoginResult().toString(),
                      // res['status']= 'fail'? : null
                    ),
                    validator: (email) {
                      // if (email != null && !EmailValidator.validate(email)) {
                      //   return 'Enter a valid email';
                      // } else if (email != null) {
                      //   setState(() {
                      //     primaryColor = Colors.red;
                      //   });
                      // }
                      return email != null && !EmailValidator.validate(email)
                          ? 'Enter a valid email'
                          : null;
                      //  getLoginResult().then((value) {
                      //     email = value;
                      //   }).toString();
                    },
                    // onSaved: (email) {
                    //   setState(() {
                    //     primaryColor =
                    //         email!.isNotEmpty ? primaryColor : Colors.amber;
                    //   });
                    // },
                    autofillHints: [AutofillHints.email],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  TextFormField(
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    obscureText: isPassword,
                    decoration: InputDecoration(
                      labelStyle: TextStyle(
                          color: isValidate ? Colors.grey : Colors.red),
                      labelText: 'Password',
                      prefixIcon: Icon(
                        FontAwesomeIcons.lock,
                        color: isValidate ? Colors.grey : Colors.red,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: isValidate ? Colors.grey : Colors.red,
                        ),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Checkbox(
                          activeColor: kPrimaryColor,
                          value: true,
                          onChanged: (v) {}),
                      const SizedBox(
                        width: 10,
                      ),
                      const Text(
                        'Remember me',
                      ),
                      const SizedBox(
                        width: 50,
                      ),
                      TextButtonWidget(
                        text: 'Forgot password?',
                      ),
                    ],
                  ),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Center(
                        child: Material(
                          borderRadius: BorderRadius.circular(50),
                          color: kPrimaryColor,
                          child: InkWell(
                            customBorder: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50),
                            ),
                            onTap: () async {
                              var res = await authService.sendLoginData(
                                  email: emailController.text,
                                  password: passwordController.text);
                              if (res != null) {
                                if (res['status'] == 'success') {
                                  final snackBar = SnackBar(
                                    content: Container(
                                        padding: EdgeInsets.all(16),
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: kPrimaryColor,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Text("${res['message']}")),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              LoadingScreen()));
                                  _myBox.put('token',
                                      'Bearer ${res['data']['token']}');
                                } else if (res['status'] == 'fail') {
                                  print('hhhhhhhhhhhhhhhhhhhhhhhh');
                                  final snackBar = SnackBar(
                                    content: Container(
                                        padding: EdgeInsets.all(16),
                                        height: 50,
                                        decoration: BoxDecoration(
                                            color: Colors.red,
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(20))),
                                        child: Text("${res['message']}")),
                                    margin: EdgeInsets.only(
                                        bottom:
                                            MediaQuery.of(context).size.height -
                                                100,
                                        right: 20,
                                        left: 20),
                                    behavior: SnackBarBehavior.floating,
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                  );
                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(snackBar);
                                  setState(() {
                                    isValidate = false;
                                  });
                                }
                              }
                              final form = formkey.currentState;
                              if (form!.validate()) {
                                final email = emailController.text;
                              }
                            },
                            child: Container(
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              height: 60,
                              width: 250,
                              child: Center(
                                  child: Text(
                                'Login',
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 17,
                                    fontWeight: FontWeight.bold),
                              )),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      if (isBiometricsEnabled == true)
                        InkWell(
                          onTap: () async {
                            bool isAuthenticated =
                                await AuthService().authenticateUser();
                            if (isAuthenticated) {
                              Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()));
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Authentication failed.'),
                                ),
                              );
                            }
                          },
                          child: Container(
                            height: 60,
                            width: 60,
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: kPrimaryColor,
                            ),
                            child: Center(
                              child: Icon(
                                  Platform.isAndroid
                                      ? FontAwesomeIcons.fingerprint
                                      : CupertinoIcons.viewfinder,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'New user?',
                      ),
                      TextButtonWidget(text: 'First login'),
                    ],
                  ),
                  // InkWell(
                  //     onTap: () {
                  //       setState(() {
                  //         print(isFingerPrintEnabled);
                  //       });
                  //     },
                  //     child: Text('datall'))
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
