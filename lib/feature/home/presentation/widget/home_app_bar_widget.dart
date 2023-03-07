import 'package:flutter/material.dart';

import '../../../../core/colors/color_list.dart';
import '../../../../core/constants/image_constants.dart';

class HomeAppBarWidget extends StatelessWidget {
  const HomeAppBarWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          'Wallet balance',
          style: TextStyle(
            color: ColorList.blackThirdColor,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(
          width: 10,
        ),
        Container(
          decoration: BoxDecoration(
              color: ColorList.lightBlue2Color,
              borderRadius: BorderRadius.circular(24)),
          padding: const EdgeInsets.symmetric(
            horizontal: 12,
            vertical: 7,
          ),
          child: Row(
            children: [
              Image.asset(imageWalletBalance),
              const SizedBox(
                width: 10,
              ),
              Text(
                '0.00',
                style: TextStyle(
                  color: ColorList.primaryColor,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
