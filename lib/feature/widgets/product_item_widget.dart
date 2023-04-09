import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';

import '../../core/ui/style/app_style.dart';

class ProductItemWidget extends StatelessWidget {
  final KoloboxFundEnum fundEnum;

  const ProductItemWidget({
    Key? key,
    required this.fundEnum,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: fundEnum.getFundBackColorValue,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              fundEnum.getFundValue,
              style: AppStyle.b3Bold
                  .copyWith(color: fundEnum.getFundTextColorValue),
            ),
          ),
          fundEnum.isPhotoEnabledAsIcon
              ? Icon(
                  fundEnum.getFundIconValue,
                  size: 48,
                  color: fundEnum.getFundIconColorValue.withOpacity(0.4),
                )
              : Image.asset(
                  fundEnum.getFundImageValue,
                  width: 48,
                  height: 48,
                ),
        ],
      ),
    );
  }
}
