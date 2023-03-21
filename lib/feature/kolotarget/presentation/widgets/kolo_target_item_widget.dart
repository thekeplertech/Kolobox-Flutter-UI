import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../core/enums/kolobox_fund_enum.dart';

class KoloTargetItemWidget extends StatelessWidget {
  final KoloboxFundEnum koloboxFundEnum;
  final bool isPaid;

  const KoloTargetItemWidget({
    Key? key,
    this.isPaid = false,
    this.koloboxFundEnum = KoloboxFundEnum.koloTarget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: ColorList.greyLight11Color, width: 1)),
      padding: const EdgeInsets.only(left: 10, right: 10, top: 12, bottom: 10),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                koloboxFundEnum.getFundIconValue,
                size: 24,
                color: isPaid
                    ? ColorList.greyLight2Color
                    : koloboxFundEnum.getFundIconColorValue,
              ),
              const SizedBox(
                width: 15,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Buy a new car',
                      style: AppStyle.b7Bold
                          .copyWith(color: ColorList.blackSecondColor),
                    ),
                    const SizedBox(
                      height: 2,
                    ),
                    Text(
                      '₦ 500,000.00',
                      style: AppStyle.b8SemiBold
                          .copyWith(color: ColorList.primaryColor),
                    ),
                  ],
                ),
              ),
              const Icon(
                KoloBoxIcons.forwardArrow,
                size: 15,
                color: ColorList.lightBlue8Color,
              ),
            ],
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              color: ColorList.lightBlue9Color,
            ),
            padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
            child: Row(
              children: [
                Text(
                  'End date',
                  style: AppStyle.b9Medium
                      .copyWith(color: ColorList.greyLight12Color),
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  '26 Jan 2023',
                  style: AppStyle.b9SemiBold.copyWith(
                      color: isPaid
                          ? ColorList.redDarkColor
                          : ColorList.blackSecondColor),
                ),
                const Spacer(),
                Text(
                  'Target',
                  style: AppStyle.b9Medium
                      .copyWith(color: ColorList.greyLight12Color),
                ),
                const SizedBox(
                  width: 3,
                ),
                Text(
                  '₦ 2,500,000.00',
                  style: AppStyle.b9SemiBold
                      .copyWith(color: ColorList.primaryColor),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
