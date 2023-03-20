import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/feature/widgets/deposit_summary_widget.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../core/base/base_screen.dart';
import '../../../../core/colors/color_list.dart';

class DepositYourKoloboxWidget extends BaseScreen {
  const DepositYourKoloboxWidget({Key? key}) : super(key: key);

  @override
  State<DepositYourKoloboxWidget> createState() =>
      _DepositYourKoloboxWidgetState();
}

class _DepositYourKoloboxWidgetState
    extends BaseScreenState<DepositYourKoloboxWidget> {
  @override
  Widget body(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        goBack(context);
        return false;
      },
      child: SingleChildScrollView(
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
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackThirdColor),
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
              getOptionWidget(ColorList.koloFlexColor, "Koloflex",
                  ColorList.koloFlexTextColor, imageFlexIcon),
              const SizedBox(
                height: 20,
              ),
              Text(
                'Select a kolotarget to make this deposit to',
                style: AppStyle.b8Medium
                    .copyWith(color: ColorList.blackSecondColor),
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
                style: AppStyle.b8Regular
                    .copyWith(color: ColorList.blackThirdColor),
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
                          left: 14.5, right: 23, top: 12, bottom: 9),
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
                    Divider(
                        color: ColorList.lightBlue5Color,
                        height: 1,
                        thickness: 1),
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 14.5, right: 23, top: 12, bottom: 13),
                      child: Row(
                        children: [
                          Text(
                            'Flutterwave',
                            style: AppStyle.b7Regular
                                .copyWith(color: ColorList.blackSecondColor),
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
                  showCustomBottomSheet(const DepositSummaryWidget());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget getOptionWidget(
      Color backColor, String title, Color titleColor, String icon) {
    return Container(
      decoration: BoxDecoration(
        color: backColor,
        borderRadius: BorderRadius.circular(14),
      ),
      padding: const EdgeInsets.all(24),
      child: Row(
        children: [
          Expanded(
            child: Text(
              title,
              style: AppStyle.b3Bold.copyWith(color: titleColor),
            ),
          ),
          Image.asset(
            icon,
            width: 48,
            height: 48,
          ),
        ],
      ),
    );
  }
}
