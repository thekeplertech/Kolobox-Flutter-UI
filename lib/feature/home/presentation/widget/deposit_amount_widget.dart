import 'package:flutter/material.dart';

import '../../../../core/colors/color_list.dart';
import '../../../../core/constants/image_constants.dart';

class DepositAmountWidget extends StatelessWidget {
  const DepositAmountWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
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
              'Deposit',
              style: TextStyle(
                color: ColorList.primaryColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              width: 14,
            ),
            Image.asset(imageDownload),
          ],
        ),
      ),
    );
  }
}
