import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../core/colors/color_list.dart';
import '../../../../core/constants/image_constants.dart';

class DepositAmountWidget extends StatelessWidget {
  final double width;
  final String text;
  final Color textColor;
  final Color backColor;
  final Function()? onPressed;

  const DepositAmountWidget({
    Key? key,
    this.width = double.maxFinite,
    this.text = 'Deposit',
    this.textColor = ColorList.primaryColor,
    this.backColor = ColorList.lightBlue3Color,
    this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTap: onPressed,
        child: Container(
          width: width,
          decoration: BoxDecoration(
              color: backColor, borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(
            vertical: 12,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                text,
                style: AppStyle.b7SemiBold.copyWith(color: textColor),
              ),
              const SizedBox(
                width: 12,
              ),
              Image.asset(imageDownload),
            ],
          ),
        ),
      );
}
