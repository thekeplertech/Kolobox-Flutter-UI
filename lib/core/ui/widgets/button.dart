import 'package:flutter/material.dart';

import '../../colors/color_list.dart';
import '../style/app_style.dart';

class Button extends StatelessWidget {
  const Button(
    this.text, {
    Key? key,
    this.overlayColor,
    this.backgroundColor,
    this.textColor,
    this.borderSide,
    this.borderRadius = 0,
    this.onPressed,
  }) : super(key: key);

  final String text;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderSide? borderSide;
  final double borderRadius;
  final Function()? onPressed;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
            overlayColor: MaterialStateProperty.all(
                overlayColor ?? ColorList.primaryColor),
            backgroundColor: MaterialStateProperty.all(
              backgroundColor ?? ColorList.accentColor,
            ),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                side: borderSide ?? BorderSide.none,
                borderRadius: BorderRadius.all(
                  Radius.circular(borderRadius),
                ),
              ),
            )),
        child: Container(
          width: double.maxFinite,
          padding: const EdgeInsets.only(top: 15, bottom: 13),
          child: Center(
            child: Text(
              text,
              style: AppStyle.b7SemiBold
                  .copyWith(color: textColor ?? ColorList.white),
            ),
          ),
        ),
      );
}
