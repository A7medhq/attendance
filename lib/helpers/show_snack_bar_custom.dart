import 'package:flutter/material.dart';

void showSnackBar(String message, BuildContext context,
    {EdgeInsetsGeometry? margin, Color? color}) {
  final snackBar = SnackBar(
    content: Container(
        padding: const EdgeInsets.all(16),
        height: 50,
        decoration: BoxDecoration(
            color: color,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Text(message)),
    behavior: SnackBarBehavior.floating,
    backgroundColor: Colors.transparent,
    elevation: 0,
    margin: margin,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
