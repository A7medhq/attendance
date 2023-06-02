import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/main_button_custom.dart';
import '../components/list_tile_custom.dart';
import '../helpers/constants.dart';
import '../helpers/manager_fonts.dart';
import '../helpers/manager_strings.dart';
import '../helpers/util/size_util.dart';

class AdminPermessionRequestScreen extends StatefulWidget {
  static const id = '/adminPermessionRequestScreen';
  const AdminPermessionRequestScreen({Key? key}) : super(key: key);

  @override
  State<AdminPermessionRequestScreen> createState() =>
      _AdminPermessionRequestScreenState();
}

class _AdminPermessionRequestScreenState
    extends State<AdminPermessionRequestScreen> {
  String? groupValue = ManagerStrings.groupValue;
  bool isTextFieldEnabled = false;
  TextEditingController otherTextFieldController = TextEditingController();
  TextEditingController dateTextFieldController = TextEditingController();
  TextEditingController inTimeTextFieldController = TextEditingController();
  TextEditingController outTimeTextFieldController = TextEditingController();

  @override
  void initState() {
    dateTextFieldController.text =
        DateFormat(ManagerStrings.dateFormatYMD).format(DateTime.now());

    inTimeTextFieldController.text =
        DateFormat(ManagerStrings.dateFormatHMA).format(DateTime.now());

    outTimeTextFieldController.text = DateFormat(ManagerStrings.dateFormatHMA)
        .format(DateTime.now()
            .add(const Duration(hours: Constants.dateTimeDuration)));

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          ManagerStrings.permissionRequest,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: ManagerHeight.h24, horizontal: ManagerWidth.w24),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTileCustom(
                title: ManagerStrings.requestID,
                subtitle: ManagerStrings.subTitleP000012,
              ),
              SizedBox(
                height: ManagerHeight.h40,
              ),
              const ListTileCustom(
                title: ManagerStrings.employeeName,
                subtitle: ManagerStrings.employeeName,
              ),
              SizedBox(
                height: ManagerHeight.h40,
              ),
              const ListTileCustom(
                title: ManagerStrings.permissionType,
                subtitle: ManagerStrings.emergency,
              ),
              SizedBox(
                height: ManagerHeight.h40,
              ),
              const ListTileCustom(
                title: ManagerStrings.permissionDate,
                subtitle: ManagerStrings.permissionDateNum,
              ),
              SizedBox(
                height: ManagerHeight.h40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    ManagerStrings.permissionTime,
                    style: TextStyle(
                        fontSize: ManagerFontSize.s18,
                        color: Colors.grey.shade500),
                  ),
                  SizedBox(
                    height: ManagerHeight.h10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        TextSpan(
                          text: ManagerStrings.time12,
                          style: TextStyle(
                              fontSize: ManagerFontSize.s15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: ManagerStrings.to,
                          style: TextStyle(
                              fontSize: ManagerFontSize.s19,
                              color: Colors.grey.shade500),
                        ),
                        TextSpan(
                          text: ManagerStrings.time12,
                          style: TextStyle(
                              fontSize: ManagerFontSize.s15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              SizedBox(
                height: ManagerHeight.h40,
              ),
              Row(
                children: [
                  MainButtonCustom(text: ManagerStrings.approve, onTap: () {}),
                  SizedBox(
                    width: ManagerWidth.w10,
                  ),
                  MainButtonCustom(
                      isOutlined: true,
                      text: ManagerStrings.reject,
                      backgroudColor: Colors.white,
                      textColor: kPrimaryColor,
                      onTap: () {}),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
