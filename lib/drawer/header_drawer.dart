import 'package:attendance/helpers/constants.dart';
import 'package:attendance/models/get_user_data_model.dart';
import 'package:attendance/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeaderDrawer extends StatefulWidget {
  const HeaderDrawer({Key? key}) : super(key: key);

  @override
  State<HeaderDrawer> createState() => _HeaderDrawerState();
}

class _HeaderDrawerState extends State<HeaderDrawer> {
  @override
  Widget build(BuildContext context) {
    return Ink(
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: const Color.fromARGB(255, 180, 180, 180).withOpacity(0.8),
            blurRadius: 20,
            offset: const Offset(0, 7),
          ),
        ],
        gradient: LinearGradient(
          colors: [kPrimaryColor, const Color.fromARGB(255, 72, 104, 210)],
        ),
      ),
      child: InkWell(
        onTap: () {},
        child: Container(
          width: double.infinity,
          height: 200,
          padding: const EdgeInsets.only(top: 20),
          child: Consumer<UserInformationProvider>(
              builder: (context, value, child) {
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    height: 70,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(userInfo.image!),
                        )),
                  ),
                  Text(
                    userInfo.name!,
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                  Text(
                    userInfo.notifyEmail!,
                    style: TextStyle(
                      color: Colors.grey.shade200,
                      fontSize: 14,
                    ),
                  ),
                ],
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
        ),
      ),
    );
  }
}
