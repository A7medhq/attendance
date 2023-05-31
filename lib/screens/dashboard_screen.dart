import 'package:attendance/helpers/constants.dart';
import 'package:attendance/models/get_user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../components/dashboard_cards.dart';
import '../providers/user_data_provider.dart';

class DashboardScreen extends StatelessWidget {
  static const id = '/dashboardScreen';
  const DashboardScreen({Key? key}) : super(key: key);

  static Widget dashboardShimmer = Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade100,
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
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(8, 32, 8, 8),
                    child: Container(
                      color: Colors.grey,
                      width: 130,
                      height: 16,
                    ),
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
                    title: Container(
                      color: Colors.grey,
                      height: 16,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.mobileScreen,
                      color: kPrimaryColor,
                    ),
                    title: Container(
                      color: Colors.grey,
                      height: 16,
                    ),
                  )
                ],
              )
            ],
          ),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          const EdgeInsets.only(top: 0, right: 24.0, left: 24.0, bottom: 8),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 12.0),
              child: Card(
                color: Colors.white,
                elevation: 2,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(18)),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Consumer<UserInformationProvider>(
                      builder: (context, value, child) {
                    if (value.state == UserInformationState.Loading) {
                      return Center(
                        child: dashboardShimmer,
                      );
                    }
                    if (value.state == UserInformationState.Error) {
                      return const Center(
                        child: Text('Error'),
                      );
                    }
                    final Data? userInfo = value.userInformation;
                    if (userInfo != null) {
                      return Stack(
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
                                        NetworkImage(userInfo.image!),
                                  ),
                                  Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(8, 32, 8, 8),
                                    child:
                                        Text(userInfo.name!, style: kHeadText),
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
                                    title: Text(userInfo.notifyEmail!),
                                  ),
                                  ListTile(
                                    leading: Icon(
                                      FontAwesomeIcons.mobileScreen,
                                      color: kPrimaryColor,
                                    ),
                                    title: Text(userInfo.notifyMobile!),
                                  )
                                ],
                              )
                            ],
                          ),
                        ],
                      );
                    } else {
                      return dashboardShimmer;
                    }
                  }),
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
                    number: 'soon',
                    date: '1 - 20 January',
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  MyCard(
                    title: 'Absent',
                    icon: FontAwesomeIcons.personCircleXmark,
                    number: 'soon',
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
                    number: 'soon',
                    date: '1 - 20 January',
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  MyCard(
                    title: 'Location',
                    icon: FontAwesomeIcons.locationCrosshairs,
                    number: 'soon',
                    date: '1 - 20 January',
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
