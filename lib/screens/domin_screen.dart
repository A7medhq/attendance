import 'package:attendance/helpers/manager_fonts.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../helpers/manager_color.dart';
import '../helpers/manager_sizes.dart';
import '../helpers/manager_strings.dart';

class DomainScreen extends StatefulWidget {
  static const id = '/domainScreen';
  const DomainScreen({Key? key}) : super(key: key);

  @override
  State<DomainScreen> createState() => _DomainScreenState();
}

class _DomainScreenState extends State<DomainScreen> {
  TextEditingController domainController = TextEditingController();
  final _myBox = Hive.box(ManagerStrings.myBox);
  String message = ManagerStrings.empty;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ManagerColor.kScaffoldColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: ManagerHeight.h16,
            horizontal: ManagerWidth.w25,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(ManagerStrings.welcome,
                  style: TextStyle(
                    fontSize: ManagerFontSize.s40,
                    fontWeight: FontWeight.bold,
                  )),
              TextFormField(
                controller: domainController,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                  labelText: ManagerStrings.enterYourCompanyCode,
                  prefixIcon: const Icon(
                    Icons.domain,
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(ManagerRadius.r50),
                  ),
                ),
              ),
              Text(
                message,
                style: const TextStyle(color: ManagerColor.red),
              ),
              Material(
                borderRadius: BorderRadius.circular(ManagerRadius.r50),
                color: ManagerColor.kPrimaryColor,
                child: InkWell(
                  customBorder: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(ManagerRadius.r50),
                  ),
                  onTap: () {},
                  child: Container(
                    clipBehavior: Clip.hardEdge,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(ManagerRadius.r50),
                    ),
                    height: ManagerHeight.h60,
                    width: double.infinity,
                    child: Center(
                        child: Text(
                      ManagerStrings.next,
                      style: TextStyle(
                          color: ManagerColor.white,
                          fontSize: ManagerFontSize.s17,
                          fontWeight: FontWeight.bold),
                    )),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
