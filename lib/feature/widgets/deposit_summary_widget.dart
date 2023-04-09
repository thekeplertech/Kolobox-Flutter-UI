import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/payment_gateway_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/core/ui/widgets/currency_text_input_formatter.dart';
import 'package:kolobox_new_app/feature/widgets/confirm_with_pin_widget.dart';
import 'package:kolobox_new_app/feature/widgets/inherited_state_container.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../core/base/base_screen.dart';
import '../../core/colors/color_list.dart';
import '../../core/enums/kolobox_fund_enum.dart';
import 'product_item_widget.dart';

class DepositSummaryWidget extends BaseScreen {
  const DepositSummaryWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DepositSummaryWidget> createState() => _DepositSummaryWidgetState();
}

class _DepositSummaryWidgetState extends BaseScreenState<DepositSummaryWidget> {
  @override
  Widget body(BuildContext context) => SingleChildScrollView(
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
                        CurrencyTextInputFormatter.formatAmount(
                            StateContainer.of(context).getAmount()),
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
                style: AppStyle.b9Regular
                    .copyWith(color: ColorList.blackThirdColor),
              ),
              const SizedBox(
                height: 5,
              ),
              getOptionWidget(),
              const SizedBox(
                height: 20,
              ),
              // if (koloboxFundEnum != KoloboxFundEnum.koloFlex) ...[
              //   Row(
              //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //     children: [
              //       Text(
              //         'Selected Investing towards',
              //         style: AppStyle.b9Medium
              //             .copyWith(color: ColorList.blackSecondColor),
              //       ),
              //       Text(
              //         'Renting a new home',
              //         style: AppStyle.b8SemiBold
              //             .copyWith(color: ColorList.blackSecondColor),
              //       ),
              //     ],
              //   ),
              //   const SizedBox(
              //     height: 20,
              //   ),
              // ],
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
                    Expanded(
                      child: Text(
                        'Paystack',
                        style: AppStyle.b7Regular
                            .copyWith(color: ColorList.blackSecondColor),
                      ),
                    ),
                    Image.asset(imagePayStackIcon),
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
                  StateContainer.of(context).openFundMyKoloBox(
                    fundEnum: StateContainer.of(context).getKoloBoxEnum(),
                    amount: StateContainer.of(context).getAmount(),
                    paymentEnum: PaymentGatewayEnum.payStack,
                  );
                  showCustomBottomSheet(const ConfirmWithPinWidget());
                },
              ),
            ],
          ),
        ),
      );

  Widget getOptionWidget() {
    KoloboxFundEnum? fundEnum = StateContainer.of(context).getKoloBoxEnum();
    if (fundEnum == null) return const SizedBox();
    return ProductItemWidget(fundEnum: fundEnum);
  }
}
