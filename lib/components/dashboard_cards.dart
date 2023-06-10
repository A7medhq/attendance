import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import '../helpers/manager_color.dart';

class MyCard extends StatelessWidget {
  String title;
  IconData? icon;
  String number;
  String date;

  MyCard(
      {Key? key,
      required this.title,
      required this.icon,
      required this.date,
      required this.number})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: SizedBox(
        height: 140,
        child: Card(
          color: Colors.white,
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: ManagerColor.black,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: const TextStyle(
                          color: ManagerColor.black, fontSize: 14),
                    ),
                  ],
                ),
                Text(
                  number,
                  style: kHeadText,
                ),
                Text(
                  date,
                  style: kHintText,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
