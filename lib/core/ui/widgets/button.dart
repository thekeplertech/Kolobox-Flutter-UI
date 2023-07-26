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
    this.verticalPadding = 15,
    this.height = 48,
    this.onPressed,
    this.textStyle,
    this.postIcon,
  }) : super(key: key);

  final String text;
  final Color? overlayColor;
  final Color? backgroundColor;
  final Color? textColor;
  final BorderSide? borderSide;
  final double borderRadius;
  final double verticalPadding;
  final double height;
  final Function()? onPressed;
  final TextStyle? textStyle;
  final String? postIcon;

  @override
  Widget build(BuildContext context) => TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          overlayColor:
              MaterialStateProperty.all(overlayColor ?? ColorList.primaryColor),
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
          ),
          fixedSize: MaterialStateProperty.all(Size.fromHeight(height)),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Container(
          height: height,
          width: double.maxFinite,
          padding:
              EdgeInsets.symmetric(vertical: verticalPadding, horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  text,
                  style: textStyle ??
                      AppStyle.b7SemiBold
                          .copyWith(color: textColor ?? ColorList.white),
                  overflow: TextOverflow.ellipsis,
                  textAlign: TextAlign.center,
                ),
              ),
              if (postIcon != null) ...[
                const SizedBox(width: 12),
                Image.asset(postIcon!),
              ],
            ],
          ),
        ),
      );
}
