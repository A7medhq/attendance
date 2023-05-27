import 'package:attendance/helpers/constants.dart';
import 'package:attendance/models/get_user_data_model.dart';
import 'package:attendance/screens/update_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../components/text_button.dart';
import '../providers/user_data_provider.dart';

class ProfileScreen extends StatefulWidget {
  static const id = '/profileScreen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    // if () {
    return Consumer<UserInformationProvider>(
      builder: (BuildContext context, value, Widget? child) {
        if (value.state == UserInformationState.Loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        if (value.state == UserInformationState.Error) {
          return const Center(
            child: Text('Error'),
          );
        }
        final Data? userInfo = value.userInformation;
        if (userInfo != null) {
          return Scaffold(
              backgroundColor: Colors.grey.shade200,
              body: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 8),
                    height: 200,
                    margin: EdgeInsets.only(
                        left: 34.0, right: 34.0, top: 34.0, bottom: 12),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: const Color.fromARGB(255, 180, 180, 180)
                              .withOpacity(0.8),
                          blurRadius: 20,
                          offset: const Offset(0, 7),
                        ),
                      ],
                      gradient: LinearGradient(
                        colors: [
                          kPrimaryColor,
                          const Color.fromARGB(255, 72, 104, 210)
                        ],
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            TextButtonWidget(
                              text: 'Edit profile',
                              textColor: Colors.white,
                              onPressed: () async {
                                await Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => UpdateImageScreen(
                                      image: userInfo.image!,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                              height: 120,
                              width: 110,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color:
                                              const Color.fromARGB(255, 0, 0, 0)
                                                  .withOpacity(0.2),
                                          offset: const Offset(0, 10))
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      fit: BoxFit.cover,
                                      image: NetworkImage(
                                        userInfo.image!,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  userInfo.name!,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  userInfo.employeeCode!,
                                  style: const TextStyle(
                                    fontSize: 15,
                                    color: Colors.white,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Expanded(
                    child: ShaderMask(
                      shaderCallback: (Rect rect) {
                        return LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.white,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.transparent,
                            Colors.white
                          ],
                          stops: [
                            0.0,
                            0.1,
                            0.1,
                            0.9,
                            1.0
                          ], // 10% purple, 80% transparent, 10% purple
                        ).createShader(rect);
                      },
                      blendMode: BlendMode.dstOut,
                      child: ListView(
                        padding: EdgeInsets.only(
                            left: 34.0, right: 34.0, bottom: 12),
                        shrinkWrap: true,
                        children: [
                          ListTile(
                            selectedTileColor: kLightColor,
                            leading: Icon(
                              FontAwesomeIcons.mobileScreen,
                              color: kPrimaryColor,
                            ),
                            title: const Text(
                              'Mobile',
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            subtitle: Text(userInfo.notifyMobile!),
                          ),
                          const Divider(),
                          ListTile(
                            leading: Icon(
                              FontAwesomeIcons.at,
                              color: kPrimaryColor,
                            ),
                            title: const Text(
                              'Email',
                            ),
                            subtitle: Text(
                              userInfo.notifyEmail!,
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.buildingColumns,
                              color: kPrimaryColor,
                            ),
                            title: const Text(
                              'Bank account',
                            ),
                            subtitle: Text(
                              userInfo.bankName!,
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: FaIcon(
                              FontAwesomeIcons.buildingUser,
                              color: kPrimaryColor,
                            ),
                            title: const Text(
                              'Bank adress',
                            ),
                            subtitle: Text(
                              userInfo.bankIBAN!,
                            ),
                          ),
                          const Divider(),
                          ListTile(
                            leading: Icon(
                              Icons.file_present,
                              color: kPrimaryColor,
                            ),
                            title: const Text(
                              'Employee identifier',
                            ),
                            subtitle: Text(
                              userInfo.employmentType!,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ));
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}
