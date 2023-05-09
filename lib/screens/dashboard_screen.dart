import 'package:attendance/providers/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/dashboard_cards.dart';
import '../services/get_user_information_service.dart';

class DashboardScreen extends StatefulWidget {
  static const id = '/dashboardScreen';
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final GetUserInfo _usersData = GetUserInfo();
  dynamic data;

  void getUsers() async {
    data = await _usersData.getUserInfo();
    setState(() {});
  }

  @override
  void initState() {
    getUsers();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (data != null) {
      return Padding(
        padding:
            const EdgeInsets.only(top: 0, right: 24.0, left: 24.0, bottom: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 12.0),
                child: Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18)),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                CircleAvatar(
                                  radius: 50,
                                  backgroundColor: kPrimaryColor,
                                  backgroundImage:
                                      NetworkImage(data['data']['image']),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(8, 32, 8, 8),
                                  child: Text(data['data']['name'],
                                      style: kHeadText),
                                )
                              ],
                            ),
                            const Divider(
                              color: Colors.grey,
                            ),
                            Column(
                              children: [
                                ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.at,
                                    color: kPrimaryColor,
                                  ),
                                  title: Text(data['data']['notify_email']),
                                ),
                                ListTile(
                                  leading: Icon(
                                    FontAwesomeIcons.mobileScreen,
                                    color: kPrimaryColor,
                                  ),
                                  title: Text(data['data']['notify_mobile']),
                                )
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 6),
                child: Row(
                  children: [
                    MyCard(
                      title: 'Attendees',
                      icon: FontAwesomeIcons.personCircleCheck,
                      number: '15',
                      date: '1 - 20 January',
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    MyCard(
                      title: 'Absent',
                      icon: FontAwesomeIcons.personCircleXmark,
                      number: '15',
                      date: '1 - 20 January',
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 12.0, 0, 6),
                child: Row(
                  children: [
                    MyCard(
                      title: 'Late',
                      icon: FontAwesomeIcons.stopwatch,
                      number: '15',
                      date: '1 - 20 January',
                    ),
                    const SizedBox(
                      width: 12,
                    ),
                    MyCard(
                      title: 'Location',
                      icon: FontAwesomeIcons.locationCrosshairs,
                      number: '15',
                      date: '1 - 20 January',
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      return Center(
        child: SpinKitRotatingCircle(
          color: kPrimaryColor,
          size: 50.0,
        ),
      );
    }
  }
}
