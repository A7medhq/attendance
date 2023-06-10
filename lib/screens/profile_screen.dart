import 'package:attendance/models/get_user_data_model.dart';
import 'package:attendance/screens/update_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../components/text_button.dart';
import '../helpers/manager_color.dart';
import '../providers/user_data_provider.dart';

class ProfileScreen extends StatelessWidget {
  static const id = '/profileScreen';

  ProfileScreen({super.key});

  Widget headCardShimmer = Shimmer.fromColors(
      baseColor: const Color(0xff506ed2),
      highlightColor: const Color(0xff203781),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              TextButtonWidget(
                text: 'Edit profile',
                textColor: Colors.white,
                onPressed: () async {},
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
                    decoration: const BoxDecoration(
                      color: Colors.grey,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    height: 18,
                    width: 80,
                    color: Colors.grey,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 16,
                    width: 100,
                    color: Colors.grey,
                  ),
                ],
              )
            ],
          ),
        ],
      ));
  Widget listViewShimmer = Shimmer.fromColors(
      baseColor: Colors.grey.shade300,
      highlightColor: Colors.grey.shade400,
      child: ListView(
        padding: const EdgeInsets.only(left: 34.0, right: 34.0, bottom: 12),
        shrinkWrap: true,
        children: [
          ListTile(
            selectedTileColor: ManagerColor.kLightColor,
            leading: const Icon(
              FontAwesomeIcons.mobileScreen,
              color: ManagerColor.kPrimaryColor,
            ),
            title: const Text(
              'Mobile',
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Container(
              height: 18,
              width: 80,
              color: Colors.grey,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              FontAwesomeIcons.at,
              color: ManagerColor.kPrimaryColor,
            ),
            title: const Text(
              'Email',
            ),
            subtitle: Container(
              height: 18,
              width: 80,
              color: Colors.grey,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.buildingColumns,
              color: ManagerColor.kPrimaryColor,
            ),
            title: const Text(
              'Bank account',
            ),
            subtitle: Container(
              height: 18,
              width: 80,
              color: Colors.grey,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const FaIcon(
              FontAwesomeIcons.buildingUser,
              color: ManagerColor.kPrimaryColor,
            ),
            title: const Text(
              'Bank adress',
            ),
            subtitle: Container(
              height: 18,
              width: 80,
              color: Colors.grey,
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(
              Icons.file_present,
              color: ManagerColor.kPrimaryColor,
            ),
            title: const Text(
              'Employee identifier',
            ),
            subtitle: Container(
              height: 18,
              width: 80,
              color: Colors.grey,
            ),
          ),
        ],
      ));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey.shade200,
        body: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(right: 8),
              height: 200,
              margin: const EdgeInsets.only(
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
                gradient: const LinearGradient(
                  colors: [
                    ManagerColor.kPrimaryColor,
                    Color.fromARGB(255, 72, 104, 210)
                  ],
                ),
              ),
              child: Consumer<UserInformationProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                if (value.state == UserInformationState.Loading) {
                  return Center(
                    child: headCardShimmer,
                  );
                }
                if (value.state == UserInformationState.Error) {
                  return const Center(
                    child: Text('Error'),
                  );
                }
                final Data? userInfo = value.userInformation;
                if (userInfo != null) {
                  return Column(
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
                  );
                } else {
                  return headCardShimmer;
                }
              }),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ShaderMask(
                shaderCallback: (Rect rect) {
                  return const LinearGradient(
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
                child: Consumer<UserInformationProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                  if (value.state == UserInformationState.Loading) {
                    return Center(
                      child: listViewShimmer,
                    );
                  }
                  if (value.state == UserInformationState.Error) {
                    return const Center(
                      child: Text('Error'),
                    );
                  }
                  final Data? userInfo = value.userInformation;

                  if (userInfo != null) {
                    return ListView(
                      padding: const EdgeInsets.only(
                          left: 34.0, right: 34.0, bottom: 12),
                      shrinkWrap: true,
                      children: [
                        ListTile(
                          selectedTileColor: ManagerColor.kLightColor,
                          leading: const Icon(
                            FontAwesomeIcons.mobileScreen,
                            color: ManagerColor.kPrimaryColor,
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
                          leading: const Icon(
                            FontAwesomeIcons.at,
                            color: ManagerColor.kPrimaryColor,
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
                          leading: const FaIcon(
                            FontAwesomeIcons.buildingColumns,
                            color: ManagerColor.kPrimaryColor,
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
                          leading: const FaIcon(
                            FontAwesomeIcons.buildingUser,
                            color: ManagerColor.kPrimaryColor,
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
                          leading: const Icon(
                            Icons.file_present,
                            color: ManagerColor.kPrimaryColor,
                          ),
                          title: const Text(
                            'Employee identifier',
                          ),
                          subtitle: Text(
                            userInfo.employmentType!,
                          ),
                        ),
                      ],
                    );
                  } else {
                    return listViewShimmer;
                  }
                }),
              ),
            ),
          ],
        ));
  }
}
