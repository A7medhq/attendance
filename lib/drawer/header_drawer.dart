import 'package:attendance/providers/constants.dart';
import 'package:attendance/services/get_user_information_service.dart';
import 'package:flutter/material.dart';

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({Key? key}) : super(key: key);

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  final GetUserInfo _usersData = GetUserInfo();
  dynamic data;

  void getUsers() async {
    data = await _usersData.getUserInfo();
    if (this.mounted) {
      setState(() {
        // Your state change code goes here
      });
    }
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return Material(
        color: kPrimaryColor,
        child: InkWell(
          onTap: () {},
          child: Container(
            width: double.infinity,
            height: 200,
            padding: const EdgeInsets.only(top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 10),
                  height: 70,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: DecorationImage(
                        image: NetworkImage(data['data']['image']),
                      )),
                ),
                Text(
                  data['data']['name'],
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 20),
                ),
                Text(
                  data['data']['notify_email'],
                  style: TextStyle(
                    color: Colors.grey.shade200,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      );
    } else {
      return Material(
          color: kPrimaryColor,
          child: Container(
              width: double.infinity,
              height: 200,
              padding: const EdgeInsets.only(top: 20),
              child: Center(child: CircularProgressIndicator())));
    }
  }
}
