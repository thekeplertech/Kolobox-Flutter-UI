import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/feature/widgets/deposit_summary_widget.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../core/base/base_screen.dart';
import '../../../../core/colors/color_list.dart';

class DepositYourKoloboxWidget extends BaseScreen {
  final KoloboxFundEnum koloboxFundEnum;

  const DepositYourKoloboxWidget({
    Key? key,
    required this.koloboxFundEnum,
  }) : super(key: key);

  @override
  State<DepositYourKoloboxWidget> createState() =>
      _DepositYourKoloboxWidgetState();
}

class _DepositYourKoloboxWidgetState
    extends BaseScreenState<DepositYourKoloboxWidget> {
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
              'Deposit',
              style:
                  AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              'Deposit into your Kolotarget',
              style:
                  AppStyle.b8Regular.copyWith(color: ColorList.blackThirdColor),
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
              height: 12,
            ),
            getOptionWidget(),
            const SizedBox(
              height: 20,
            ),
            Text(
              'Select a kolotarget to make this deposit to',
              style:
                  AppStyle.b8Medium.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 4,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorList.greyLightColor, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.maxFinite,
              padding: const EdgeInsets.all(10),
              child: Text(
                'Select a kolotarget',
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackThirdColor),
              ),
            ),
            const SizedBox(
              height: 12,
            ),
            Text(
              'Enter Amount',
              style:
                  AppStyle.b8Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 7,
            ),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: ColorList.greyLightColor, width: 1),
                borderRadius: BorderRadius.circular(12),
              ),
              width: double.maxFinite,
              padding: const EdgeInsets.all(27),
              child: Center(
                child: Text(
                  '₦ 0.00',
                  style: AppStyle.b3Bold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
              ),
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
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 15, bottom: 10),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Paystack',
                            style: AppStyle.b7Regular
                                .copyWith(color: ColorList.blackSecondColor),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: Stack(
                            children: [
                              Image.asset(imageCheckedIcon),
                              Center(
                                child: Icon(
                                  KoloBoxIcons.check,
                                  color: ColorList.white,
                                  size: 20,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Divider(
                      color: ColorList.lightBlue5Color,
                      height: 1,
                      thickness: 1),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 15, right: 15, top: 10, bottom: 15),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Text(
                            'Flutterwave',
                            style: AppStyle.b7Regular
                                .copyWith(color: ColorList.blackSecondColor),
                          ),
                        ),
                        SizedBox(
                          width: 25,
                          height: 25,
                          child: Stack(
                            children: [
                              Image.asset(imageUncheckedIcon),
                            ],
                          ),
                        ),
                      ],
                    ),
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
                showCustomBottomSheet(DepositSummaryWidget(
                  koloboxFundEnum: widget.koloboxFundEnum,
                ));
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
