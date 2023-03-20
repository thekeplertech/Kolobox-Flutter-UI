import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/feature/widgets/confirm_with_pin_widget.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../core/base/base_screen.dart';
import '../../core/colors/color_list.dart';

class DepositSummaryWidget extends BaseScreen {
  final KoloboxFundEnum koloboxFundEnum;

  const DepositSummaryWidget({
    Key? key,
    required this.koloboxFundEnum,
  }) : super(key: key);

  @override
  State<DepositSummaryWidget> createState() => _DepositSummaryWidgetState();
}

class _DepositSummaryWidgetState extends BaseScreenState<DepositSummaryWidget> {
  @override
  Widget body(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding:
            const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 31),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: () {
                  goBack(context);
                },
                child: Image.asset(imageClose),
              ),
            ),
            Text(
              'Deposit Summary',
              style:
                  AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 13,
            ),
            Button(
              'Edit',
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
            Container(
              decoration: BoxDecoration(
                color: ColorList.primaryColor,
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.maxFinite,
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Column(
                  children: [
                    Text(
                      'Deposit Amount',
                      style:
                          AppStyle.b8Regular.copyWith(color: ColorList.white),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    Text(
                      '₦ 0.00',
                      style: AppStyle.b3Bold.copyWith(color: ColorList.white),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(
              height: 17,
            ),
            Text(
              'Deposit into my',
              style:
                  AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 5,
            ),
            getOptionWidget(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Selected Investing towards',
                  style: AppStyle.b9Medium
                      .copyWith(color: ColorList.blackSecondColor),
                ),
                Text(
                  'Renting a new home',
                  style: AppStyle.b8SemiBold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Select payment option',
              style: AppStyle.b8SemiBold
                  .copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 9,
            ),
            Container(
              decoration: BoxDecoration(
                color: ColorList.greyLight5Color,
                borderRadius: BorderRadius.circular(12),
              ),
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  Text(
                    'Paystack',
                    style: AppStyle.b7Regular
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 18,
            ),
            Button(
              'Next',
              backgroundColor: ColorList.primaryColor,
              textColor: ColorList.white,
              overlayColor: ColorList.blueColor,
              borderRadius: 32,
              onPressed: () {
                showCustomBottomSheet(const ConfirmWithPinWidget());
              },
            ),
          ],
        ),
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
