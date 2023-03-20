import 'package:flutter/material.dart';

import '../../../../core/colors/color_list.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/ui/style/app_style.dart';
import '../../../../core/ui/widgets/range_custom_painter.dart';

class AccountItemWidget extends StatelessWidget {
  final Function() onWithdrawal;

  const AccountItemWidget({
    Key? key,
    required this.onWithdrawal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 12,
        ),
        Row(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: ColorList.lightBlue6Color, shape: BoxShape.circle),
              padding: const EdgeInsets.all(15),
              child: Image.asset(imageDepositRecentIcon),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Investment',
                    style: AppStyle.b8SemiBold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  if (false) ...[
                    Text(
                      'Aug 02, 2022',
                      style: AppStyle.b10SemiBold
                          .copyWith(color: ColorList.greyLight2Color),
                    ),
                  ] else ...[
                    Text(
                      'View Details',
                      style: AppStyle.b10SemiBold
                          .copyWith(color: ColorList.primaryColor),
                    ),
                  ],
                ],
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  '₦1,500,000.00',
                  style: AppStyle.b8SemiBold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '+ ₦ 100,000.00',
                  style: AppStyle.b10SemiBold
                      .copyWith(color: ColorList.koloFamilyTextColor),
                ),
              ],
            ),
            const SizedBox(
              width: 8,
            ),
            Container(
              width: 1,
              color: ColorList.greyLight7Color,
              height: 45,
            ),
            const SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: () {
                onWithdrawal();
              },
              child: SizedBox(
                width: 50,
                height: 50,
                child: CustomPaint(
                  painter: RangeCustomPainter(
                      selectedColor: ColorList.redDark2Color,
                      backColor: ColorList.greyLight8Color),
                  child: false
                      ? Padding(
                          padding: const EdgeInsets.all(5),
                          child: Center(
                            child: Text(
                              '22 Days Left',
                              style: AppStyle.b9SemiBold
                                  .copyWith(color: ColorList.greyLight9Color),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              textAlign: TextAlign.center,
                            ),
                          ),
                        )
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(imageWithdrawalIcon),
                            const SizedBox(
                              height: 2,
                            ),
                            Text(
                              'Withdraw',
                              style: AppStyle.b10SemiBold
                                  .copyWith(color: ColorList.koloFlexTextColor),
                            ),
                          ],
                        ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 10,
        ),
        Divider(
            thickness: 1, height: 1, color: ColorList.greyDisableCircleColor),
      ],
    );
  }
}
