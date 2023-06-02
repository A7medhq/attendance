import 'package:attendance/main.dart';
import 'package:attendance/providers/check_in_out_status_provider.dart';
import 'package:attendance/providers/leave_types_provider.dart';
import 'package:attendance/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../providers/admin_data_provider.dart';
import '../providers/user_data_provider.dart';
import '../services/get_user_information_service.dart';

class LoadingScreen extends StatefulWidget {
  static const id = '/';
  const LoadingScreen({Key? key}) : super(key: key);

  @override
  State<LoadingScreen> createState() => _LoadingScreenState();
}

class _LoadingScreenState extends State<LoadingScreen> {
  bool? status;

  Future<void> getCurrentUser() async {
    status = await GetUserInfo.checkUserLoggedIn();
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    if (status != null) {
      if (status!) {
        Provider.of<UserInformationProvider>(context, listen: false)
            .getUserInformation();
        Provider.of<AdminInformationProvider>(context, listen: false)
            .getAdminInformation();
        Provider.of<LeaveTypesProvider>(context, listen: false).getLeaveTypes();
        Provider.of<CheckStatusProvider>(context, listen: false)
            .getCheckStatus();
        return const MyHomePage();
      } else {
        return const LogInScreen();
      }
    }
    {
      return const Scaffold(
          body: Center(
              child: SpinKitSpinningLines(
        color: Color(0xff4D455D),
        size: 50.0,
      )));
    }
  }
}
