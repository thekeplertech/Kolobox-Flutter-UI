import 'package:flutter/material.dart';

import '../../core/colors/color_list.dart';
import '../../core/constants/image_constants.dart';
import '../../core/ui/style/app_style.dart';

class WalletItemWidget extends StatelessWidget {
  const WalletItemWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) => Container(
        width: double.maxFinite,
        decoration: BoxDecoration(
          color: ColorList.blueLight2Color,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Wallet',
              style:
                  AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            Image.asset(imageWalletSuccessIconSelected, width: 48, height: 48),
          ],
        ),
      );
}
