import 'package:flutter/material.dart';

import '../helpers/constants.dart';
import '../helpers/manager_color.dart';

class CheckInOutContainer extends StatelessWidget {
  final String title;
  final String date;
  bool isEnabled;
  final IconData icon;

  CheckInOutContainer({
    Key? key,
    required this.title,
    required this.date,
    this.isEnabled = false,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Container(
        padding: const EdgeInsets.all(15),
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(28),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Icon(icon,
                size: 50,
                color: isEnabled ? ManagerColor.kPrimaryColor : Colors.grey),
            const SizedBox(
              height: 10,
            ),
            Text(
              title,
              style: TextStyle(
                  color: isEnabled ? ManagerColor.kPrimaryColor : Colors.grey),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              date,
              style: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
