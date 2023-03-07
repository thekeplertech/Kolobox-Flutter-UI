import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';

import '../../colors/color_list.dart';

class ToastWidget extends StatelessWidget {
  const ToastWidget(
    this.text, {
    Key? key,
    this.backgroundColor,
    this.messageIcon,
    this.closeWidget,
  }) : super(key: key);

  final String text;
  final Color? backgroundColor;
  final String? messageIcon;
  final Widget? closeWidget;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: backgroundColor ?? ColorList.primaryColor,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
          Image.asset(messageIcon ?? imageRightWhite),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Text(text,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: ColorList.white,
                )),
          ),
          const SizedBox(
            width: 10,
          ),
          closeWidget ?? Image.asset(imageClose)
        ],
      ),
    );
  }
}
