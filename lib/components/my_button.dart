import 'package:flutter/material.dart';

import '../helpers/constants.dart';

class MyButton extends StatefulWidget {
  final Function()? onTap;
  final String text;
  final Color? backgroudColor;
  Color? textColor;
  final bool isOutlined;
  double? width;
  double? height;

  MyButton(
      {Key? key,
      this.onTap,
      required this.text,
      this.backgroudColor,
      this.textColor,
      this.isOutlined = false,
      this.width,
      this.height})
      : super(key: key);

  @override
  State<MyButton> createState() => _MyButtonState();
}

class _MyButtonState extends State<MyButton> {
  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Center(
        child: Material(
          borderRadius: BorderRadius.circular(50),
          color: widget.backgroudColor == null
              ? kPrimaryColor
              : widget.isOutlined
                  ? Colors.white
                  : widget.backgroudColor,
          child: InkWell(
            customBorder: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50),
            ),
            onTap: widget.onTap,
            child: Container(
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                border: Border.all(
                    color: kPrimaryColor,
                    width: 1.5,
                    style: widget.isOutlined
                        ? BorderStyle.solid
                        : BorderStyle.none),
                borderRadius: BorderRadius.circular(50),
              ),
              height:
                  widget.height == null ? widget.height = 60 : widget.height,
              width: widget.width == null ? double.infinity : widget.width,
              child: Center(
                  child: Text(
                widget.text,
                style: kHeadText.copyWith(
                  color: widget.textColor ?? Colors.white,
                ),
              )),
            ),
          ),
        ),
      ),
    );
  }
}
