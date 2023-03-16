import 'package:flutter/material.dart';

import '../../../../core/colors/color_list.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/ui/style/app_style.dart';

class AccountItemWidget extends StatelessWidget {
  const AccountItemWidget({Key? key}) : super(key: key);

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
                  color: true
                      ? ColorList.redLightColor
                      : ColorList.lightBlue6Color,
                  shape: BoxShape.circle),
              padding: const EdgeInsets.all(15),
              child: Image.asset(true
                  ? imageWithdrawSecondRecentIcon
                  : imageDepositRecentIcon),
            ),
            const SizedBox(
              width: 8,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Deposit',
                    style: AppStyle.b8SemiBold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    'Aug 02, 2022',
                    style: AppStyle.b10SemiBold
                        .copyWith(color: ColorList.greyLight2Color),
                  ),
                ],
              ),
            ),
            Text(
              '₦ 14,200.00',
              style: AppStyle.b8SemiBold
                  .copyWith(color: ColorList.blackSecondColor),
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
