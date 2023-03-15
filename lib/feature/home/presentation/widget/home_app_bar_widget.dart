import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../core/colors/color_list.dart';
import '../../../../core/constants/image_constants.dart';

class HomeAppBarWidget extends StatelessWidget {
  final String amount;
  final StreamController<bool> walletBalanceStreamController;

  const HomeAppBarWidget({
    Key? key,
    required this.amount,
    required this.walletBalanceStreamController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding:
                const EdgeInsets.only(left: 30, right: 15, top: 11, bottom: 11),
            child: Image.asset(imageDashboardIcon),
          ),
        ),
        const Spacer(),
        Text(
          'Wallet balance',
          style: AppStyle.b8Medium.copyWith(color: ColorList.blackThirdColor),
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
            vertical: 4,
          ),
          child: Row(
            children: [
              Image.asset(imageWalletBalance),
              const SizedBox(
                width: 10,
              ),
              Text(
                amount,
                style: AppStyle.b8Bold.copyWith(color: ColorList.primaryColor),
              ),
            ],
          ),
        ),
        const SizedBox(
          width: 12,
        ),
        GestureDetector(
          onTap: () {},
          child: Padding(
            padding:
                const EdgeInsets.only(left: 20, right: 30, top: 11, bottom: 11),
            child: Image.asset(imageNotification),
          ),
        ),
      ],
    );
  }
}
