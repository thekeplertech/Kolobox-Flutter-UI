import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../../core/base/base_screen.dart';
import '../../../../../core/colors/color_list.dart';

class DepositedWithdrawalInfoKoloboxWidget extends BaseScreen {
  final KoloboxFundEnum koloboxFundEnum;

  const DepositedWithdrawalInfoKoloboxWidget({
    Key? key,
    required this.koloboxFundEnum,
  }) : super(key: key);

  @override
  State<DepositedWithdrawalInfoKoloboxWidget> createState() =>
      _DepositedWithdrawalInfoKoloboxWidgetState();
}

class _DepositedWithdrawalInfoKoloboxWidgetState
    extends BaseScreenState<DepositedWithdrawalInfoKoloboxWidget> {
  @override
  Widget body(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 25, left: 28, right: 28, bottom: 31),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              color: ColorList.lightBlue6Color,
              shape: BoxShape.circle,
            ),
            padding: const EdgeInsets.all(25),
            child: Icon(
              KoloBoxIcons.deposit,
              size: 20,
              color: ColorList.primaryColor,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Deposited',
            style: AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            '₦ 14,200.00',
            style: AppStyle.b5SemiBold.copyWith(color: ColorList.primaryColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Aug 02, 2022 - 11:34 PM',
            style:
                AppStyle.b9SemiBold.copyWith(color: ColorList.greyLight2Color),
          ),
          const SizedBox(
            height: 18,
          ),
          Text(
            'Ref',
            style:
                AppStyle.b9SemiBold.copyWith(color: ColorList.greyLight2Color),
          ),
          const SizedBox(
            height: 3,
          ),
          Text(
            '092829-20991090009w0220',
            style: AppStyle.b8Medium.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            'Deposit destination',
            style:
                AppStyle.b8SemiBold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 8,
          ),
          getOptionWidget(),
          const SizedBox(
            height: 20,
          ),
          Button(
            'Share',
            backgroundColor: ColorList.lightBlue3Color,
            textColor: ColorList.primaryColor,
            overlayColor: ColorList.blueColor,
            borderRadius: 32,
            onPressed: () {
              goBack(context);
            },
          ),
          const SizedBox(
            height: 20,
          ),
          Button(
            'Ok',
            backgroundColor: ColorList.primaryColor,
            textColor: ColorList.white,
            overlayColor: ColorList.blueColor,
            borderRadius: 32,
            onPressed: () {
              goBack(context);
            },
          ),
        ],
      ),
    );
  }

  Widget getOptionWidget() {
    return GestureDetector(
      onTap: () async {
        // switch (fundEnum) {
        //   case KoloboxFundEnum.koloFlex:
        //   case KoloboxFundEnum.koloTarget:
        //   case KoloboxFundEnum.koloFamily:
        //   case KoloboxFundEnum.koloGroup:
        //     showCustomBottomSheet(
        //         DepositYourKoloboxWidget(
        //           koloboxFundEnum: fundEnum,
        //         ),
        //         height: 0.9);
        //     break;
        //   case KoloboxFundEnum.koloTargetPlus:
        //     comingSoon();
        //     break;
        // }
      },
      child: Container(
        decoration: BoxDecoration(
          color: widget.koloboxFundEnum.getFundBackColorValue,
          borderRadius: BorderRadius.circular(14),
        ),
        padding: const EdgeInsets.all(24),
        child: Row(
          children: [
            Expanded(
              child: Text(
                widget.koloboxFundEnum.getFundValue,
                style: AppStyle.b3Bold.copyWith(
                    color: widget.koloboxFundEnum.getFundTextColorValue),
              ),
            ),
            widget.koloboxFundEnum.isPhotoEnabledAsIcon
                ? Icon(
                    widget.koloboxFundEnum.getFundIconValue,
                    size: 48,
                    color: widget.koloboxFundEnum.getFundIconColorValue
                        .withOpacity(0.4),
                  )
                : Image.asset(
                    widget.koloboxFundEnum.getFundImageValue,
                    width: 48,
                    height: 48,
                  ),
          ],
        ),
      ),
    );
  }
}
