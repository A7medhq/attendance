import 'package:attendance/components/head_text.dart';
import 'package:attendance/components/main_button_custom.dart';
import 'package:attendance/components/date_picker_custom.dart';
import 'package:attendance/components/text_field_custom.dart';
import 'package:attendance/helpers/constants.dart';
import 'package:attendance/models/active_leave_types_model.dart';
import 'package:attendance/providers/leave_types_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../components/text_field_custom.dart';
import '../helpers/constants.dart';

class LeavePermissionRequestScreen extends StatefulWidget {
  static const id = '/leavePermissionRequestScreen';
  const LeavePermissionRequestScreen({super.key});

  @override
  State<LeavePermissionRequestScreen> createState() =>
      _LeavePermissionRequestScreenState();
}

class _LeavePermissionRequestScreenState
    extends State<LeavePermissionRequestScreen> {
  bool selectedValue = false;
  Color leaveTypeBackgroundColor = kDarkColor;
  TextEditingController numOfDaysCont = TextEditingController(text: '');
  TextEditingController balanceCont = TextEditingController();
  TextEditingController endDateCont = TextEditingController();
  TextEditingController startDateTextFieldController = TextEditingController();

  @override
  void initState() {
    startDateTextFieldController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());

    super.initState();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: const Color.fromRGBO(0, 0, 0, 0.001),
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: 0.4,
                minChildSize: 0.2,
                maxChildSize: 0.75,
                builder: (_, controller) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(25.0),
                        topRight: Radius.circular(25.0),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.minus,
                          color: Colors.grey[600],
                        ),
                        Expanded(
                          child: Consumer<LeaveTypesProvider>(
                              builder: (context, value, child) {
                            if (value.state ==
                                LeaveTypesProviderState.Loading) {
                              return const Center(
                                child: CircularProgressIndicator(),
                              );
                            }
                            if (value.state == LeaveTypesProviderState.Error) {
                              return const Center(
                                child: Text('Error'),
                              );
                            }
                            final List<LeaveTypes>? leaveTypes =
                                value.leaveTypes;

                            if (leaveTypes != null) {
                              return ListView.builder(
                                controller: controller,
                                itemCount: leaveTypes.length,
                                itemBuilder: (_, index) {
                                  return InkWell(
                                    onTap: () {
                                      print(leaveTypes[index].description);
                                    },
                                    child: Card(
                                      child: Padding(
                                        padding: const EdgeInsets.all(12),
                                        child:
                                            Text(leaveTypes[index].description),
                                      ),
                                    ),
                                  );
                                },
                              );
                            } else {
                              return const CircularProgressIndicator();
                            }
                          }),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    String addedDays = numOfDaysCont.text == '' ? '0' : numOfDaysCont.text;
    endDateCont.text = DateFormat('yyyy-MM-dd').format(
        DateTime.parse(startDateTextFieldController.text)
            .add(Duration(days: int.parse(addedDays))));

    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.only(
            top: 24.0, right: 16.0, left: 16.0, bottom: 4),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: Text(
                  'Permission leave type',
                  style: kHeadText,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: InkWell(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.grey.shade400, width: 1),
                        borderRadius: BorderRadius.circular(8)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              'Choose yours permission leave type',
                              style: TextStyle(fontSize: 17),
                              maxLines: 1,
                            ),
                          ),
                        ),
                        Icon(
                          FontAwesomeIcons.angleDown,
                        ),
                      ],
                    ),
                  ),
                  onTap: () {
                    _showBottomSheet(context);
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextWidget(
                  text: 'Enter number of days',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFieldCustom(
                  controller: numOfDaysCont,
                  hintText: '0',
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        endDateCont.text = DateFormat('yyyy-MM-dd').format(
                            DateTime.parse(startDateTextFieldController.text)
                                .add(Duration(days: int.parse(value))));
                      });
                    } else {
                      endDateCont.text = DateFormat('yyyy-MM-dd').format(
                          DateTime.parse(startDateTextFieldController.text));
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextWidget(
                  text: 'Your permission balance',
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10.0),
                child: TextFieldCustom(
                  controller: balanceCont,
                  hintText: '7',
                  isEnabled: false,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextWidget(
                  text: 'Enter start date',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              DatePickerCustom(
                controller: startDateTextFieldController,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: TextWidget(
                  text: 'End date',
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              TextFieldCustom(
                controller: endDateCont,
                hintText: endDateCont.text,
                isEnabled: false,
              ),
              const SizedBox(
                height: 30,
              ),
              MainButtonCustom(
                onTap: () {},
                text: 'Send request',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
