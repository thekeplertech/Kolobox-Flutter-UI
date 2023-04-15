import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolobox_new_app/core/constants/app_constants.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/core/ui/widgets/currency_text_input_formatter.dart';
import 'package:kolobox_new_app/feature/widgets/deposit/deposit_summary_widget.dart';
import 'package:kolobox_new_app/feature/widgets/inherited_state_container.dart';
import 'package:kolobox_new_app/feature/widgets/product_item_widget.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../../core/base/base_screen.dart';
import '../../../../../core/colors/color_list.dart';
import '../../../core/ui/widgets/custom_text_field.dart';
import '../../../core/ui/widgets/toast_widget.dart';
import '../../../core/utils/utils.dart';

class DepositYourKoloboxWidget extends BaseScreen {
  const DepositYourKoloboxWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DepositYourKoloboxWidget> createState() =>
      _DepositYourKoloboxWidgetState();
}

class _DepositYourKoloboxWidgetState
    extends BaseScreenState<DepositYourKoloboxWidget> {
  TextEditingController amountEditingController = TextEditingController();

  @override
  Widget body(BuildContext context) => Padding(
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
              getDepositMessage(),
              style:
                  AppStyle.b8Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 13,
            ),
            if (StateContainer.of(context).isFundYourKoloBox()) ...[
              Button(
                'Edit',
                backgroundColor: ColorList.lightBlue3Color,
                textColor: ColorList.primaryColor,
                overlayColor: ColorList.blueColor,
                borderRadius: 32,
                onPressed: () => goBack(context),
              ),
              const SizedBox(
                height: 12,
              ),
            ],
            getOptionWidget(),
            const SizedBox(
              height: 20,
            ),
            // if (koloboxFundEnum != KoloboxFundEnum.koloFlex) ...[
            //   Text(
            //     'Select a kolotarget to make this deposit to',
            //     style:
            //         AppStyle.b8Medium.copyWith(color: ColorList.blackSecondColor),
            //   ),
            //   const SizedBox(
            //     height: 4,
            //   ),
            //   Container(
            //     decoration: BoxDecoration(
            //       border: Border.all(color: ColorList.greyLightColor, width: 1),
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     width: double.maxFinite,
            //     padding: const EdgeInsets.only(
            //         left: 12, right: 16, top: 12, bottom: 12),
            //     child: Row(
            //       children: [
            //         Expanded(
            //           child: Text(
            //             'Select a ${koloboxFundEnum.getFundValue}',
            //             style: AppStyle.b8Regular
            //                 .copyWith(color: ColorList.blackThirdColor),
            //           ),
            //         ),
            //         const Icon(KoloBoxIcons.dropDownArrow, size: 8),
            //       ],
            //     ),
            //   ),
            //   const SizedBox(
            //     height: 12,
            //   ),
            // ],
            Text(
              'Enter Amount',
              style:
                  AppStyle.b8Regular.copyWith(color: ColorList.blackThirdColor),
            ),
            const SizedBox(
              height: 7,
            ),
            CustomTextField(
              '₦ 0.00',
              keyboardType: TextInputType.number,
              textInputAction: TextInputAction.done,
              textCapitalization: TextCapitalization.none,
              inputFormatter: [
                CurrencyTextInputFormatter(
                  name: '₦ ',
                )
              ],
              textStyle:
                  AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
              hintStyle:
                  AppStyle.b3Bold.copyWith(color: ColorList.primaryColor),
              textAlign: TextAlign.center,
              contentPadding: const EdgeInsets.symmetric(vertical: 25),
              controller: amountEditingController,
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
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 15),
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
              height: 18,
            ),
            Button(
              'Next',
              backgroundColor: ColorList.primaryColor,
              textColor: ColorList.white,
              overlayColor: ColorList.blueColor,
              borderRadius: 32,
              onPressed: () {
                onClickNext();
              },
            ),
          ],
        ),
      );

  String getDepositMessage() {
    String message = 'Deposit into your ';
    if (StateContainer.of(context).isWallet() ?? false) {
      message += 'wallet balance';
    } else if (StateContainer.of(context).getKoloBoxEnum() != null) {
      message += StateContainer.of(context).getKoloBoxEnum()!.getFundValue;
    }
    return message;
  }

  Widget getOptionWidget() {
    KoloboxFundEnum? fundEnum = StateContainer.of(context).getKoloBoxEnum();
    if (fundEnum == null) return const SizedBox();
    return ProductItemWidget(fundEnum: fundEnum);
  }

  onClickNext() {
    if (amountEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter amount',
            borderColor: ColorList.redDarkColor,
            backgroundColor: ColorList.white,
            textColor: ColorList.black,
            messageIcon: imageCloseRed,
            closeWidget: Image.asset(
              imageClose,
              color: ColorList.black,
            ),
          ));
      return;
    } else if (double.parse(getOnlyAmount(amountEditingController.text)) <
        double.parse(StateContainer.of(context)
            .getKoloBoxEnum()!
            .getMinimumAmountValue())) {
      Utils.showToast(
          context,
          ToastWidget(
            'Amount is less than minimum amount required for this product',
            borderColor: ColorList.redDarkColor,
            backgroundColor: ColorList.white,
            textColor: ColorList.black,
            messageIcon: imageCloseRed,
            closeWidget: Image.asset(
              imageClose,
              color: ColorList.black,
            ),
          ));
      return;
    }
    StateContainer.of(context).openFundMyKoloBox(
        fundEnum: StateContainer.of(context).getKoloBoxEnum(),
        amount: amountEditingController.text);
    showCustomBottomSheet(const DepositSummaryWidget());
  }

  @override
  void dispose() {
    super.dispose();
    amountEditingController.dispose();
  }
}
