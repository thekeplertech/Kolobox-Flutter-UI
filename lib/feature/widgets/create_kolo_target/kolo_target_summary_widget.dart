import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/base/base_screen.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/constants/kolo_box_icon.dart';
import '../../../core/ui/widgets/button.dart';
import '../confirm_with_pin_widget.dart';

class KoloTargetSummaryWidget extends BaseScreen {
  const KoloTargetSummaryWidget({Key? key}) : super(key: key);

  @override
  State<KoloTargetSummaryWidget> createState() =>
      _KoloTargetSummaryWidgetState();
}

class _KoloTargetSummaryWidgetState
    extends BaseScreenState<KoloTargetSummaryWidget> {
  TextEditingController nameTextEditingController = TextEditingController();

  StreamController<bool> enableRecurringDepositStreamController =
      StreamController<bool>.broadcast();
  bool isEnableRecurringDeposit = false;

  // KoloboxFundEnum koloboxFundEnum = KoloboxFundEnum.koloFlex;

  @override
  Widget body(BuildContext context) {
    // koloboxFundEnum = StateContainer.of(context).koloboxFundEnum;
    return Padding(
      padding: const EdgeInsets.only(top: 17, left: 28, right: 28, bottom: 31),
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
            'Kolotarget Sumary',
            style: AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
          ),
          const SizedBox(
            height: 5,
          ),
          Text(
            'Start investing towards your goal',
            style:
                AppStyle.b9Regular.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 20,
          ),
          // getOptionWidget(),
          const SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Target',
                    style: AppStyle.b9Medium
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  Text(
                    'Buy a Car',
                    style: AppStyle.b7Bold
                        .copyWith(color: ColorList.blackSecondColor),
                  )
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'End date',
                    style: AppStyle.b9Medium
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  Text(
                    '14, Jan 2023',
                    style: AppStyle.b7Bold
                        .copyWith(color: ColorList.blackSecondColor),
                  )
                ],
              ),
            ],
          ),
          const SizedBox(
            height: 20,
          ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                border: Border.all(color: ColorList.greyLight7Color, width: 1),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(25),
            child: Column(
              children: [
                Text(
                  'Target amount',
                  style: AppStyle.b9Regular
                      .copyWith(color: ColorList.blackSecondColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '₦ 2,500,000.00',
                  style: AppStyle.b4Bold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                color: ColorList.primaryColor,
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Text(
                  'Saving now',
                  style: AppStyle.b9Regular.copyWith(color: ColorList.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '₦ 100,000.00',
                  style: AppStyle.b4Bold.copyWith(color: ColorList.white),
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
                border: Border.all(color: ColorList.greyLight7Color, width: 1),
                borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.all(15),
            child: Column(
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                      color: ColorList.lightBlue11Color,
                      borderRadius: BorderRadius.circular(12)),
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    children: [
                      Text(
                        'Recurring deposit',
                        style: AppStyle.b8Medium
                            .copyWith(color: ColorList.blackSecondColor),
                      ),
                      const SizedBox(
                        height: 3,
                      ),
                      Text(
                        '₦ 80,000.00',
                        style: AppStyle.b6Bold
                            .copyWith(color: ColorList.blackSecondColor),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Recurring period',
                          style: AppStyle.b8Medium
                              .copyWith(color: ColorList.blackSecondColor),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          'Monthly',
                          style: AppStyle.b6Bold
                              .copyWith(color: ColorList.blackSecondColor),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          'Recurring date',
                          style: AppStyle.b8Medium
                              .copyWith(color: ColorList.blackSecondColor),
                        ),
                        const SizedBox(
                          height: 3,
                        ),
                        Text(
                          '03',
                          style: AppStyle.b6Bold
                              .copyWith(color: ColorList.blackSecondColor),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Select payment option',
            style:
                AppStyle.b8SemiBold.copyWith(color: ColorList.blackSecondColor),
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
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          'Paystack',
                          style: AppStyle.b7Regular
                              .copyWith(color: ColorList.blackSecondColor),
                        ),
                      ),
                      Image.asset(imagePayStackIcon),
                      const SizedBox(
                        width: 10,
                      ),
                      SizedBox(
                        width: 25,
                        height: 25,
                        child: Stack(
                          children: [
                            Image.asset(imageCheckedIcon),
                            const Center(
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
              ],
            ),
          ),
          const SizedBox(
            height: 25,
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
    );
  }

  // Widget getOptionWidget() {
  //   return GestureDetector(
  //     onTap: () async {
  //       // switch (fundEnum) {
  //       //   case KoloboxFundEnum.koloFlex:
  //       //   case KoloboxFundEnum.koloTarget:
  //       //   case KoloboxFundEnum.koloFamily:
  //       //   case KoloboxFundEnum.koloGroup:
  //       //     showCustomBottomSheet(
  //       //         DepositYourKoloboxWidget(
  //       //           koloboxFundEnum: fundEnum,
  //       //         ),
  //       //         height: 0.9);
  //       //     break;
  //       //   case KoloboxFundEnum.koloTargetPlus:
  //       //     comingSoon();
  //       //     break;
  //       // }
  //     },
  //     child: Container(
  //       decoration: BoxDecoration(
  //         color: koloboxFundEnum.getFundBackColorValue,
  //         borderRadius: BorderRadius.circular(14),
  //       ),
  //       padding: const EdgeInsets.all(24),
  //       child: Row(
  //         children: [
  //           Expanded(
  //             child: Text(
  //               koloboxFundEnum.getFundValue,
  //               style: AppStyle.b3Bold
  //                   .copyWith(color: koloboxFundEnum.getFundTextColorValue),
  //             ),
  //           ),
  //           koloboxFundEnum.isPhotoEnabledAsIcon
  //               ? Icon(
  //                   koloboxFundEnum.getFundIconValue,
  //                   size: 48,
  //                   color:
  //                       koloboxFundEnum.getFundIconColorValue.withOpacity(0.4),
  //                 )
  //               : Image.asset(
  //                   koloboxFundEnum.getFundImageValue,
  //                   width: 48,
  //                   height: 48,
  //                 ),
  //         ],
  //       ),
  //     ),
  //   );
  // }

  @override
  void dispose() {
    super.dispose();
    enableRecurringDepositStreamController.close();
  }
}
