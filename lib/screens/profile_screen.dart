import 'package:attendance/components/text_button.dart';
import 'package:attendance/components/text_field_custom.dart';
import 'package:attendance/models/get_user_data_model.dart';
import 'package:attendance/helpers/constants.dart';
import 'package:attendance/screens/update_image_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../components/read_only_text_field.dart';
import '../services/get_user_data_service.dart';
import '../services/update_user_information.dart';

class ProfileScreen extends StatefulWidget {
  static const id = '/profileScreen';
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  UserData? data;
  bool isNameVisible = true;
  bool isEditNameVisible = false;
  bool isEditMobileVisible = false;

  late TextEditingController _name;
  late TextEditingController _employeeCode;
  late TextEditingController _notify_email;
  late TextEditingController _notify_mobile;
  late TextEditingController _identifier_no;
  late TextEditingController _identifier_type;
  late TextEditingController _bank_id;
  late TextEditingController _bank_address;

  void getUserData() async {
    data = await GetUserProfile.getUserProfile();

    if (data != null) {
      _name = TextEditingController(text: data!.data!.name!);
      _employeeCode = TextEditingController(text: data!.data!.employeeCode!);
      _notify_email = TextEditingController(text: data!.data!.notifyEmail!);
      _notify_mobile = TextEditingController(text: data!.data!.notifyMobile!);
      _identifier_no = TextEditingController(text: data!.data!.identifierNo!);
      _identifier_type = TextEditingController(text: '4');
      _bank_id = TextEditingController(text: '5');
      _bank_address = TextEditingController(text: data!.data!.bankIBAN!);
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    isNameVisible;
    isEditNameVisible;
    isEditMobileVisible;
    getUserData();
  }

  @override
  Widget build(BuildContext context) {
    if (data != null && data!.data != null) {
      return Scaffold(
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              if (_notify_mobile.text.isNotEmpty) {
                UpdateUserData
                    .updateUserData(
                  _notify_mobile.text,
                )
                    .then((message) {
                  setState(() {
                    isEditNameVisible = false;
                    isEditMobileVisible = false;
                  });

                  ScaffoldMessenger.of(context)
                      .showSnackBar(SnackBar(content: Text(message)));
                });
              } else {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text('You have to write a phone number')));
              }
            },
            backgroundColor: kPrimaryColor,
            child: const Icon(
              FontAwesomeIcons.solidFloppyDisk,
            ),
          ),
          backgroundColor: Colors.white,
          body: Column(
            children: [
              Container(
                height: 300,
                decoration: BoxDecoration(
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
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: 120,
                        width: 110,
                        child: Stack(children: [
                          Center(
                            child: Container(
                              decoration: BoxDecoration(
                                boxShadow: [
                                  BoxShadow(
                                      spreadRadius: 2,
                                      blurRadius: 10,
                                      color: Colors.black.withOpacity(0.2),
                                      offset: const Offset(0, 10))
                                ],
                                border: Border.all(
                                  width: 4,
                                  color: kPrimaryColor,
                                ),
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(
                                    data!.data!.image!,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Positioned(
                            bottom: 0,
                            right: 0,
                            child: Container(
                              height: 40,
                              width: 40,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    width: 4,
                                    color: kPrimaryColor,
                                  ),
                                  shape: BoxShape.circle),
                              child: IconButton(
                                padding: const EdgeInsets.all(0),
                                onPressed: () async {
                                  bool refresh = await Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => UpdateImageScreen(
                                        image: data!.data!.image!,
                                      ),
                                    ),
                                  );

                                  if (refresh) {
                                    getUserData();
                                  }
                                },
                                icon: Icon(
                                  FontAwesomeIcons.pen,
                                  size: 15,
                                  color: kPrimaryColor,
                                ),
                              ),
                            ),
                          ),
                        ]),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Visibility(
                            visible: isNameVisible,
                            child: Text(data!.data!.name!,
                                style: kHeadText.copyWith(color: Colors.white)),
                          ),
                          Visibility(
                            visible: isEditNameVisible,
                            child: Padding(
                              padding: const EdgeInsets.all(8),
                              child: TextFieldCustom(
                                width: 200,
                                height: 50,
                                controller: _name,
                                hintText: data!.data!.name!,
                              ),
                            ),
                          ),
                          // Visibility(
                          //   visible: isNameVisible,
                          //   child: IconButton(
                          //     onPressed: () {
                          //       setState(() {
                          //         isEditNameVisible = true;
                          //         isNameVisible = false;
                          //       });
                          //     },
                          //     icon: const Icon(
                          //       Icons.edit,
                          //       color: Colors.white,
                          //       size: 20,
                          //     ),
                          //   ),
                          // ),
                        ],
                      ),
                      ReadOnlyTextField(
                        controller: _employeeCode,
                        hintText: _employeeCode.text,
                        textColor: Colors.white,
                        textAlign: TextAlign.center,
                        width: 200,
                        height: 60,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    ListTile(
                      selectedTileColor: kLightColor,
                      tileColor: Colors.white,
                      isThreeLine: true,
                      leading: Icon(
                        FontAwesomeIcons.mobileScreen,
                        color: kPrimaryColor,
                      ),
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'Mobile',
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          TextButtonWidget(
                            onPressed: () {
                              setState(() {
                                isEditMobileVisible = !isEditMobileVisible;
                              });
                            },
                            text: 'Edit',
                          ),
                        ],
                      ),
                      subtitle: ReadOnlyTextField(
                        controller: _notify_mobile,
                        hintText: _notify_mobile.text,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start,
                        height: 20,
                      ),
                    ),
                    Visibility(
                      visible: isEditMobileVisible,
                      child: Padding(
                        padding: const EdgeInsets.all(8),
                        child: TextFieldCustom(
                          controller: _notify_mobile,
                          hintText: 'Enter your mobile number',
                        ),
                      ),
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
                      subtitle: ReadOnlyTextField(
                        controller: _notify_email,
                        hintText: _notify_email.text,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start,
                        height: 20,
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
                      subtitle: ReadOnlyTextField(
                        controller: _bank_id,
                        hintText: _bank_id.text,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start,
                        height: 20,
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
                      subtitle: ReadOnlyTextField(
                        controller: _bank_address,
                        hintText: _bank_address.text,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start,
                        height: 20,
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
                      subtitle: ReadOnlyTextField(
                        controller: _identifier_type,
                        hintText: _identifier_type.text,
                        textColor: Colors.grey,
                        textAlign: TextAlign.start,
                        height: 20,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ));
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
