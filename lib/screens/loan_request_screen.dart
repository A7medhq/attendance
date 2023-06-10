import 'package:attendance/components/head_text.dart';
import 'package:attendance/components/main_button_custom.dart';
import 'package:attendance/components/text_field_custom.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../components/date_picker_custom.dart';
import '../helpers/constants.dart';
import '../helpers/manager_color.dart';

class LoanRequestScreen extends StatefulWidget {
  static const id = '/loanRequestScreen';
  const LoanRequestScreen({super.key});

  @override
  State<LoanRequestScreen> createState() => _LoanRequestScreenState();
}

class _LoanRequestScreenState extends State<LoanRequestScreen> {
  TextEditingController startDateTextFieldController = TextEditingController();
  bool isVisible = false;

  List<String> choices = [
    'Cars',
    'Housing',
    'Renewal id ',
    'Others',
  ];
  String? selectedItem = 'Cars';

  @override
  void initState() {
    isVisible;
    print(isVisible);
    startDateTextFieldController.text =
        DateFormat('yyyy-MM-dd').format(DateTime.now());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ManagerColor.kScaffoldColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(
                top: 16.0, bottom: 4.0, right: 16.0, left: 16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextWidget(
                    text: 'Enter the loan',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFieldCustom(
                      hintText: 'amount', controller: TextEditingController()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextWidget(
                    text: 'Loans reason',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: SizedBox(
                    width: double.infinity,
                    child: DropdownButtonFormField<String>(
                      decoration: InputDecoration(
                        fillColor: Colors.white,
                        filled: true,
                        enabledBorder: kOutlineBorder,
                        focusedBorder: kOutlineBorder,
                      ),
                      isExpanded: true,
                      value: selectedItem,
                      items: choices
                          .map(
                            (item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ),
                          )
                          .toList(),
                      onChanged: (item) {
                        if (item == 'Others') {
                          setState(
                            () {
                              isVisible = true;
                              selectedItem = item!;
                            },
                          );
                        } else {
                          setState(() {
                            isVisible = false;
                          });
                        }
                      },
                    ),
                  ),
                ),
                Visibility(
                  visible: isVisible,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 16.0),
                    child: TextFieldCustom(
                      controller: TextEditingController(),
                      hintText: 'enter your reason',
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextWidget(
                    text: 'Numbers of installments',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFieldCustom(
                      hintText: 'for example: 3',
                      controller: TextEditingController()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextWidget(
                    text: 'Single installment amount',
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0),
                  child: TextFieldCustom(
                      hintText: 'for example: 50\$',
                      controller: TextEditingController()),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextWidget(
                    text: 'First date installment',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                DatePickerCustom(
                  controller: startDateTextFieldController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 16.0),
                  child: TextWidget(
                    text: 'Start date',
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                DatePickerCustom(
                  controller: startDateTextFieldController,
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 24.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      MainButtonCustom(
                        text: 'Send',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
