import 'dart:io';

import 'package:attendance/components/text_button.dart';
import 'package:attendance/screens/loading_screen.dart';
import 'package:attendance/services/login_service.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../components/show_snack_bar_custom.dart';
import '../helpers/manager_color.dart';
import '../services/auth.dart';

class LogInScreen extends StatefulWidget {
  static const id = '/logInScreen';
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isPassword = true;
  final GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final _myBox = Hive.box('myBox');
  bool? isBiometricsEnabled;
  bool? rememberMeCheck = false;
  String message = '';
  bool isValidate = true;

  bool isLoading = false;

  Map? credentials;

  @override
  void initState() {
    if (_myBox.get('isBiometricsEnabled') != null) {
      isBiometricsEnabled = _myBox.get('isBiometricsEnabled');
    }
    if (_myBox.get('credentials') != null) {
      credentials = _myBox.get('credentials');
    }

    if (_myBox.get('rememberMeCheck') != null) {
      if (_myBox.get('rememberMeCheck') == true) {
        if (credentials != null) {
          emailController = TextEditingController(text: credentials!['email']);
          passwordController =
              TextEditingController(text: credentials!['password']);
        }

        rememberMeCheck = true;
      } else {
        rememberMeCheck = false;
      }
    }

    super.initState();
  }

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  Future<bool> loginMethod(
      {required String email, required String password}) async {
    var res =
        await AuthServiceAPI.sendLoginData(email: email, password: password);

    // if (form!.validate()) {
    //   final email = emailController.text;
    // }
    if (res != null) {
      if (res['status'] == 'success') {
        if (mounted) {
          showSnackBar("${res['message']}", context,
              color: ManagerColor.kPrimaryColor);
          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const LoadingScreen()));
        }
        _myBox.put('token', 'Bearer ${res['data']['token']}');

        _myBox.put('userId', '${res['data']['user']['id']}');
        _myBox.put('credentials', {'email': email, 'password': password});
        if (rememberMeCheck == true) {
          _myBox.put('rememberMeCheck', true);
        } else {
          _myBox.put('rememberMeCheck', false);
        }
        return true;
      } else if (res['status'] == 'fail') {
        if (mounted) {
          showSnackBar(
            "${res['message']}",
            context,
            margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).size.height - 100,
                right: 20,
                left: 20),
            color: Colors.red,
          );
        }

        setState(() {
          isValidate = false;
        });
      }
    } else {
      if (mounted) {
        showSnackBar(
          'An Error Occurred',
          context,
          margin: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height - 100,
              right: 20,
              left: 20),
          color: Colors.red,
        );
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: isLoading,
      child: Scaffold(
        backgroundColor: ManagerColor.kScaffoldColor,
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
                      'assets/images/login.png',
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
                      style: const TextStyle(color: Colors.red),
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
                      autofillHints: const [AutofillHints.email],
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
                            activeColor: ManagerColor.kPrimaryColor,
                            value: rememberMeCheck,
                            onChanged: (v) {
                              setState(() {
                                rememberMeCheck = v;
                              });
                            }),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text(
                          'Remember me',
                        ),
                        const SizedBox(
                          width: 10,
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
                            color: ManagerColor.kPrimaryColor,
                            child: InkWell(
                              customBorder: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50),
                              ),
                              onTap: () async {
                                final connectivityResult =
                                    await (Connectivity().checkConnectivity());

                                if (connectivityResult !=
                                    ConnectivityResult.none) {
                                  FocusScope.of(context).unfocus();
                                  isLoading = true;
                                  setState(() {});
                                  // final form = formkey.currentState;
                                  loginMethod(
                                      email: emailController.text,
                                      password: passwordController.text);
                                  isLoading = false;
                                  setState(() {});
                                } else {
                                  if (mounted) {
                                    showSnackBar(
                                        'No Internet Connection', context,
                                        color: Colors.black);
                                  }
                                }
                              },
                              child: Container(
                                clipBehavior: Clip.hardEdge,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                ),
                                height: 60,
                                width: 250,
                                child: const Center(
                                    child: Text(
                                  'LOGIN',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 18,
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
                              final connectivityResult =
                                  await (Connectivity().checkConnectivity());

                              if (connectivityResult !=
                                  ConnectivityResult.none) {
                                bool isAuthenticated =
                                    await AuthService().authenticateUser();
                                if (credentials != null) {
                                  if (isAuthenticated) {
                                    loginMethod(
                                            email: credentials!['email'],
                                            password: credentials!['password'])
                                        .then((value) {});
                                  } else {
                                    if (mounted) {
                                      showSnackBar(
                                          'Authentication failed.', context,
                                          color: Colors.red);
                                    }
                                  }
                                }
                              } else {
                                if (mounted) {
                                  showSnackBar(
                                      'No Internet Connection', context,
                                      color: Colors.black);
                                }
                              }
                            },
                            child: Container(
                              height: 60,
                              width: 60,
                              padding: const EdgeInsets.all(10),
                              decoration: const BoxDecoration(
                                shape: BoxShape.circle,
                                color: ManagerColor.kPrimaryColor,
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
      ),
    );
  }
}
