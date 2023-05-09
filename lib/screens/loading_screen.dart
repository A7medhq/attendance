import 'package:attendance/main.dart';
import 'package:attendance/providers/constants.dart';
import 'package:attendance/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../services/get_user_information_service.dart';

class LoadingScreen extends StatefulWidget {
  static const id = '/';
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  final _myBox = Hive.box('myBox');
  String? _token;

  final GetUserInfo _usersData = GetUserInfo();
  dynamic data;

  @override
  void initState() {
    _token = _myBox.get('token');

    getUsers();
    super.initState();
  }

  void getUsers() async {
    data = await _usersData.getUserInfo();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    if (_token != null) {
      if (data != null) {
        if (data['status'] == 'success') {
          return const MyHomePage();
        } else {
          return const LogInScreen();
        }
      } else {
        return Container(
          color: Colors.white,
          child: Center(
            child: SpinKitRotatingCircle(
              color: kPrimaryColor,
              size: 50.0,
            ),
          ),
        );
      }
    } else {
      return const LogInScreen();
    }
  }
}
