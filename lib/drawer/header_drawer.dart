import 'package:attendance/helpers/constants.dart';
import 'package:attendance/models/get_user_data_model.dart';
import 'package:attendance/providers/user_data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../helpers/manager_color.dart';

class HeaderDrawer extends StatelessWidget {
  HeaderDrawer({Key? key}) : super(key: key);

  Widget drawerHeaderShimmer = Shimmer.fromColors(
      baseColor: const Color(0xff4865c2),
      highlightColor: const Color(0xff223c8f),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: const EdgeInsets.only(bottom: 10),
            height: 70,
            decoration: const BoxDecoration(
              color: Colors.grey,
              shape: BoxShape.circle,
            ),
          ),
          Container(
            height: 14,
            width: 80,
            color: Colors.grey,
          ),
          const SizedBox(
            height: 8,
          ),
          Container(
            height: 14,
            width: 130,
            color: Colors.grey,
          ),
        ],
      ));

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
        gradient: const LinearGradient(
          colors: [
            ManagerColor.kPrimaryColor,
            Color.fromARGB(255, 72, 104, 210)
          ],
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
              return Center(
                child: drawerHeaderShimmer,
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
              return drawerHeaderShimmer;
            }
          }),
        ),
      ),
    );
  }
}
