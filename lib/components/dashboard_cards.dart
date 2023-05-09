import 'package:flutter/material.dart';

import '../providers/constants.dart';

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
      child: Container(
        height: 140,
        child: Card(
          elevation: 2,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(
                      icon,
                      color: kDarkColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      title,
                      style: TextStyle(color: kDarkColor, fontSize: 14),
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
