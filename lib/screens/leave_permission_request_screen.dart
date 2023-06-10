import 'package:attendance/components/date_picker_custom.dart';
import 'package:attendance/components/head_text.dart';
import 'package:attendance/components/main_button_custom.dart';
import 'package:attendance/components/text_field_custom.dart';
import 'package:attendance/helpers/constants.dart';
import 'package:attendance/helpers/manager_fonts.dart';
import 'package:attendance/helpers/manager_sizes.dart';
import 'package:attendance/helpers/manager_strings.dart';
import 'package:attendance/models/active_leave_types_model.dart';
import 'package:attendance/providers/leave_types_provider.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../helpers/manager_color.dart';

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
  Color leaveTypeBackgroundColor = ManagerColor.black;
  TextEditingController numOfDaysCont =
      TextEditingController(text: ManagerStrings.empty);
  TextEditingController balanceCont = TextEditingController();
  TextEditingController endDateCont = TextEditingController();
  TextEditingController startDateTextFieldController = TextEditingController();

  @override
  void initState() {
    startDateTextFieldController.text =
        DateFormat(ManagerStrings.dateFormatYMD).format(DateTime.now());

    super.initState();
  }

  void _showBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: ManagerColor.transparent,
      builder: (context) {
        return GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            color: ManagerColor.containerLeaveScreen,
            child: GestureDetector(
              onTap: () {},
              child: DraggableScrollableSheet(
                initialChildSize: ManagerHeight.h4,
                minChildSize: ManagerHeight.h2,
                maxChildSize: ManagerHeight.h75,
                builder: (_, controller) {
                  return Container(
                    decoration: BoxDecoration(
                      color: ManagerColor.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(ManagerRadius.r25),
                        topRight: Radius.circular(ManagerRadius.r25),
                      ),
                    ),
                    child: Column(
                      children: [
                        Icon(
                          FontAwesomeIcons.minus,
                          color: ManagerColor.grey600,
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
                                child: Text(ManagerStrings.error),
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
                                        padding: EdgeInsets.symmetric(
                                          horizontal: ManagerWidth.w12,
                                          vertical: ManagerHeight.h12,
                                        ),
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
    String addedDays = numOfDaysCont.text == ManagerStrings.empty
        ? ManagerStrings.zero
        : numOfDaysCont.text;
    endDateCont.text = DateFormat(ManagerStrings.dateFormatYMD).format(
        DateTime.parse(startDateTextFieldController.text)
            .add(Duration(days: int.parse(addedDays))));

    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
          top: ManagerHeight.h24,
          right: ManagerWidth.w16,
          left: ManagerWidth.w16,
          bottom: ManagerHeight.h4,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  top: ManagerHeight.h16,
                ),
                child: Text(
                  ManagerStrings.permissionLeaveType,
                  style: kHeadText,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: ManagerHeight.h10,
                ),
                child: InkWell(
                  child: Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: ManagerWidth.w8,
                    ),
                    decoration: BoxDecoration(
                        color: ManagerColor.white,
                        border: Border.all(
                          color: ManagerColor.greyShade400,
                          width: ManagerWidth.w1,
                        ),
                        borderRadius: BorderRadius.circular(
                          ManagerRadius.r8,
                        )),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: FittedBox(
                            fit: BoxFit.contain,
                            child: Text(
                              ManagerStrings.chooseYoursPrmType,
                              style: TextStyle(
                                fontSize: ManagerFontSize.s17,
                              ),
                              maxLines: Constants.maxLines,
                            ),
                          ),
                        ),
                        const Icon(
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
                padding: EdgeInsets.only(
                  top: ManagerHeight.h16,
                ),
                child: TextWidget(
                  text: ManagerStrings.enterNmDays,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: ManagerHeight.h10,
                ),
                child: TextFieldCustom(
                  controller: numOfDaysCont,
                  hintText: ManagerStrings.zero,
                  onChanged: (value) {
                    if (value.isNotEmpty) {
                      setState(() {
                        endDateCont.text =
                            DateFormat(ManagerStrings.dateFormatYMD).format(
                                DateTime.parse(
                                        startDateTextFieldController.text)
                                    .add(Duration(days: int.parse(value))));
                      });
                    } else {
                      endDateCont.text =
                          DateFormat(ManagerStrings.dateFormatYMD).format(
                              DateTime.parse(
                                  startDateTextFieldController.text));
                    }
                  },
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: ManagerHeight.h16,
                ),
                child: TextWidget(
                  text: ManagerStrings.yourPermBalance,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: ManagerHeight.h10),
                child: TextFieldCustom(
                  controller: balanceCont,
                  hintText: ManagerStrings.hintText,
                  isEnabled: false,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: ManagerHeight.h16,
                ),
                child: TextWidget(
                  text: ManagerStrings.enterStartDate,
                ),
              ),
              SizedBox(
                height: ManagerHeight.h16,
              ),
              DatePickerCustom(
                controller: startDateTextFieldController,
              ),
              Padding(
                padding: EdgeInsets.only(
                  top: ManagerHeight.h16,
                ),
                child: TextWidget(
                  text: ManagerStrings.endDate,
                ),
              ),
              SizedBox(
                height: ManagerHeight.h16,
              ),
              TextFieldCustom(
                controller: endDateCont,
                hintText: endDateCont.text,
                isEnabled: false,
              ),
              SizedBox(
                height: ManagerHeight.h30,
              ),
              MainButtonCustom(
                onTap: () {},
                text: ManagerStrings.sendRequest,
              ),
              SizedBox(
                height: ManagerHeight.h30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
