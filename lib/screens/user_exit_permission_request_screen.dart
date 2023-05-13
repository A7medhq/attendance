import 'package:attendance/components/date_picker_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/main_button_custom.dart';
import '../components/my_time_picker.dart';
import '../helpers/constants.dart';

class UserPermessionRequestScreen extends StatefulWidget {
  static const id = '/userPermessionRequestScreen';
  const UserPermessionRequestScreen({Key? key}) : super(key: key);

  @override
  State<UserPermessionRequestScreen> createState() =>
      _UserPermessionRequestScreenState();
}

class _UserPermessionRequestScreenState
    extends State<UserPermessionRequestScreen> {
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
      backgroundColor: Colors.grey.shade200,
      body: Padding(
        padding: const EdgeInsets.only(
          top: 24.0,
          bottom: 4.0,
          right: 24.0,
          left: 24.0,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Exit Permission Type', style: kHeadText),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Emergency'),
                  value: '1',
                  groupValue: groupValue,
                  onChanged: (val) {
                    setState(() {
                      groupValue = val;
                      isTextFieldEnabled = false;
                    });
                  }),
              RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Appointment'),
                  value: '2',
                  groupValue: groupValue,
                  onChanged: (val) {
                    setState(() {
                      groupValue = val;
                      isTextFieldEnabled = false;
                    });
                  }),
              RadioListTile(
                  contentPadding: EdgeInsets.zero,
                  title: const Text('Other'),
                  value: '3',
                  groupValue: groupValue,
                  onChanged: (val) {
                    setState(() {
                      groupValue = val;
                      isTextFieldEnabled = true;
                    });
                  }),
              if (isTextFieldEnabled)
                TextField(
                    controller: otherTextFieldController,
                    enabled: isTextFieldEnabled,
                    decoration: InputDecoration(
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: kPrimaryColor),
                      ),
                    )),
              if (!isTextFieldEnabled)
                const Divider(
                  color: Colors.grey,
                ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Permission Date',
                style: kHeadText,
              ),
              const SizedBox(
                height: 30,
              ),
              DatePickerCustom(controller: dateTextFieldController),
              const SizedBox(
                height: 20,
              ),
              const Divider(
                color: Colors.grey,
              ),
              const SizedBox(
                height: 40,
              ),
              Text(
                'Permission time',
                style: kHeadText,
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                children: [
                  TimePickerCustom(
                    controller: inTimeTextFieldController,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TimePickerCustom(
                    addedHours: 2,
                    controller: outTimeTextFieldController,
                  ),
                ],
              ),
              const SizedBox(
                height: 40,
              ),
              MainButtonCustom(
                text: 'Send Request',
                onTap: () {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
