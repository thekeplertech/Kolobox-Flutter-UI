import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../core/colors/color_list.dart';
import '../../../../core/constants/image_constants.dart';

class DepositAmountWidget extends StatelessWidget {
  final String text;

  const DepositAmountWidget({
    Key? key,
    this.text = 'Deposit',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
            color: ColorList.lightBlue3Color,
            borderRadius: BorderRadius.circular(24)),
        padding: const EdgeInsets.symmetric(
          horizontal: 18,
          vertical: 12,
        ),
        child: IntrinsicWidth(
          child: Row(
            children: [
              Text(
                text,
                style:
                    AppStyle.b7SemiBold.copyWith(color: ColorList.primaryColor),
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
