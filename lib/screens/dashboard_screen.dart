import 'package:attendance/helpers/constants.dart';
import 'package:attendance/helpers/manager_fonts.dart';
import 'package:attendance/helpers/manager_strings.dart';
import 'package:attendance/models/get_user_data_model.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import '../helpers/manager_color.dart';
import '../helpers/manager_sizes.dart';
import '../components/dashboard_cards.dart';
import '../providers/user_data_provider.dart';

class DashboardScreen extends StatelessWidget {
  static const id = '/dashboardScreen';
  const DashboardScreen({Key? key}) : super(key: key);

  static Widget dashboardShimmer = Shimmer.fromColors(
      baseColor: ManagerColor.baseDashboardShimmer,
      highlightColor: ManagerColor.highlightDashboardShimmer,
      child: Stack(
        children: [
          Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: ManagerRadius.r50,
                    backgroundColor: kPrimaryColor,
                  ),
                  Padding(
                    padding: Constants.dashBoardShimmerPadding,
                    child: Container(
                      color: ManagerColor.grey,
                      width: ManagerWidth.w130,
                      height: ManagerHeight.h16,
                    ),
                  )
                ],
              ),
              const Divider(
                color: ManagerColor.grey,
              ),
              Column(
                children: [
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.at,
                      color: kPrimaryColor,
                    ),
                    title: Container(
                      color: ManagerColor.grey,
                      height: ManagerHeight.h16,
                    ),
                  ),
                  ListTile(
                    leading: Icon(
                      FontAwesomeIcons.mobileScreen,
                      color: kPrimaryColor,
                    ),
                    title: Container(
                      color: ManagerColor.grey,
                      height: ManagerHeight.h16,
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
      padding: Constants.dashBoardPadding,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: Constants.cardVerticalPadding),
              child: Card(
                color: ManagerColor.white,
                elevation: Constants.elevationCard,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ManagerRadius.r18)),
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: ManagerWidth.w16,
                    vertical: ManagerHeight.h16,
                  ),
                  child: Consumer<UserInformationProvider>(
                      builder: (context, value, child) {
                    if (value.state == UserInformationState.Loading) {
                      return Center(
                        child: dashboardShimmer,
                      );
                    }
                    if (value.state == UserInformationState.Error) {
                      return const Center(
                        child: Text(ManagerStrings.error),
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
                                    radius: ManagerRadius.r50,
                                    backgroundColor: kPrimaryColor,
                                    backgroundImage:
                                        NetworkImage(userInfo.image!),
                                  ),
                                  Padding(
                                    padding: Constants.dashBoardShimmerPadding,
                                    child:
                                        Text(userInfo.name!, style: kHeadText),
                                  )
                                ],
                              ),
                              const Divider(
                                color: ManagerColor.grey,
                              ),
                              Column(
                                children: [
                                  ListTile(
                                    leading: Icon(
                                      FontAwesomeIcons.at,
                                      color: kPrimaryColor,
                                    ),
                                    title: Text(
                                      userInfo.notifyEmail!,
                                      style: TextStyle(
                                          fontSize: ManagerFontSize.s14),
                                    ),
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
              padding: Constants.cardPadding,
              child: Row(
                children: [
                  MyCard(
                    title: ManagerStrings.attendees,
                    icon: FontAwesomeIcons.personCircleCheck,
                    number: ManagerStrings.soon,
                    date: ManagerStrings.randomDate,
                  ),
                  SizedBox(
                    width: ManagerWidth.w12,
                  ),
                  MyCard(
                    title: ManagerStrings.absent,
                    icon: FontAwesomeIcons.personCircleXmark,
                    number: ManagerStrings.soon,
                    date: ManagerStrings.randomDate,
                  ),
                ],
              ),
            ),
            Padding(
              padding: Constants.cardPadding,
              child: Row(
                children: [
                  MyCard(
                    title: ManagerStrings.late,
                    icon: FontAwesomeIcons.stopwatch,
                    number: ManagerStrings.soon,
                    date: ManagerStrings.randomDate,
                  ),
                  SizedBox(
                    width: ManagerWidth.w12,
                  ),
                  MyCard(
                    title: ManagerStrings.location,
                    icon: FontAwesomeIcons.locationCrosshairs,
                    number: ManagerStrings.soon,
                    date: ManagerStrings.randomDate,
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
