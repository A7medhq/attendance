import 'package:attendance/components/list_tile_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/main_button_custom.dart';
import '../helpers/constants.dart';

class AdminPermessionRequestScreen extends StatefulWidget {
  static const id = '/adminPermessionRequestScreen';
  const AdminPermessionRequestScreen({Key? key}) : super(key: key);

  @override
  State<AdminPermessionRequestScreen> createState() =>
      _AdminPermessionRequestScreenState();
}

class _AdminPermessionRequestScreenState
    extends State<AdminPermessionRequestScreen> {
  String? groupValue = '1';
  bool isTextFieldEnabled = false;
  TextEditingController otherTextFieldController = TextEditingController();
  TextEditingController dateTextFieldController = TextEditingController();
  TextEditingController inTimeTextFieldController = TextEditingController();
  TextEditingController outTimeTextFieldController = TextEditingController();

  @override
  void initState() {
    dateTextFieldController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());

    inTimeTextFieldController.text =
        DateFormat('h:mm a').format(DateTime.now());

    outTimeTextFieldController.text = DateFormat('h:mm a')
        .format(DateTime.now().add(const Duration(hours: 2)));

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
          'Permission Request',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const ListTileCustom(
                title: 'Request ID',
                subtitle: 'P000012',
              ),
              const SizedBox(
                height: 40,
              ),
              const ListTileCustom(
                title: 'Employee Name',
                subtitle: 'Employee Name',
              ),
              const SizedBox(
                height: 40,
              ),
              const ListTileCustom(
                title: 'Permission Type',
                subtitle: 'Emergency',
              ),
              const SizedBox(
                height: 40,
              ),
              const ListTileCustom(
                title: 'Permission Date',
                subtitle: '20/01/2023',
              ),
              const SizedBox(
                height: 40,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Permission Time',
                    style: TextStyle(fontSize: 18, color: Colors.grey.shade500),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  RichText(
                    text: TextSpan(
                      children: <TextSpan>[
                        const TextSpan(
                          text: '12:00',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                        TextSpan(
                          text: ' T0 ',
                          style: TextStyle(
                              fontSize: 19, color: Colors.grey.shade500),
                        ),
                        const TextSpan(
                          text: '12:00',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ],
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              Row(
                children: [
                  MainButtonCustom(text: 'Approve', onTap: () {}),
                  const SizedBox(
                    width: 10,
                  ),
                  MainButtonCustom(
                      isOutlined: true,
                      text: 'Reject',
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
