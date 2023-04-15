import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/enums/payment_gateway_enum.dart';
import 'package:kolobox_new_app/core/enums/period_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/core/ui/widgets/currency_text_input_formatter.dart';
import 'package:kolobox_new_app/feature/widgets/confirm_pin_and_pay/bloc/confirm_pin_and_pay_bloc.dart';
import 'package:kolobox_new_app/feature/widgets/inherited_state_container.dart';
import 'package:kolobox_new_app/feature/widgets/wallet_item_widget.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/base/base_screen.dart';
import '../../../core/colors/color_list.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/pay_stack_payment_gateway/pay_stack_payment.dart';
import '../../../core/ui/widgets/toast_widget.dart';
import '../../../core/utils/utils.dart';
import '../../../di/injection_container.dart';
import '../../dashboard/data/models/select_product_request_model.dart';
import '../../dashboard/data/models/top_up_request_model.dart';
import '../../transaction_successful/presentation/transaction_successful_page.dart';
import '../confirm_pin_and_pay/bloc/confirm_pin_and_pay_event.dart';
import '../confirm_pin_and_pay/bloc/confirm_pin_and_pay_state.dart';
import '../product_item_widget.dart';

class DepositSummaryWidget extends BaseScreen {
  const DepositSummaryWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DepositSummaryWidget> createState() => _DepositSummaryWidgetState();
}

class _DepositSummaryWidgetState extends BaseScreenState<DepositSummaryWidget> {
  @override
  Widget body(BuildContext context) =>
      BlocListener<ConfirmPinAndPayBloc, ConfirmPinAndPayState>(
        listener: (_, state) {
          if (state is SelectProductState) {
            Future.delayed(const Duration(milliseconds: 200), () {
              callPayment(
                  state.requestModel.depositAmount,
                  state.responseModel.data?.accessCode ?? '',
                  state.responseModel.data?.reference ?? '');
            });
          } else if (state is TopUpState) {
            Future.delayed(const Duration(milliseconds: 200), () {
              callPayment(
                  state.requestModel.depositAmount,
                  state.responseModel.topUpData?.accessCode ?? '',
                  state.responseModel.topUpData?.reference ?? '');
            });
          }
        },
        child: getChild(),
      );

  Widget getChild() => SingleChildScrollView(
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
              if (StateContainer.of(context).getKoloBoxEnum() != null) ...[
                ProductItemWidget(
                    fundEnum: StateContainer.of(context).getKoloBoxEnum()!)
              ] else if (StateContainer.of(context).isWallet() ?? false) ...[
                const WalletItemWidget(),
              ],
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
                  onClickNext();
                },
              ),
            ],
          ),
        ),
      );

  onClickNext() {
    StateContainer.of(context).openFundMyKoloBox(
      fundEnum: StateContainer.of(context).getKoloBoxEnum(),
      amount: StateContainer.of(context).getAmount(),
      paymentEnum: PaymentGatewayEnum.payStack,
    );
    initiatePayment();
    // showCustomBottomSheet(const ConfirmPinAndPayPage());
  }

  void initiatePayment() {
    bool isInActive =
        StateContainer.of(context).getKoloBoxEnum()?.isInActiveProduct() ??
            false;
    logger?.d('In Active Product $isInActive');

    PayStackPayment payStackPayment = sl();

    if (!payStackPayment.initialized) {
      Utils.showToast(
          context,
          ToastWidget(
            'Payment gateway is not initialized. Please try after a moment.',
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

    if (isInActive) {
      // Call for top up api
      BlocProvider.of<ConfirmPinAndPayBloc>(context).add(TopUpEvent(
          productId:
              StateContainer.of(context).getKoloBoxEnum()?.getProductId ?? '',
          model: TopUpRequestModel(
            productId:
                StateContainer.of(context).getKoloBoxEnum()?.getProductId ?? '',
            depositAmount:
                getOnlyAmount(StateContainer.of(context).getAmount()),
          )));
    } else {
      // Call for select product api
      BlocProvider.of<ConfirmPinAndPayBloc>(context).add(SelectProductEvent(
          userId: prefHelper?.getLoginResponseModel().id ?? '',
          model: SelectProductRequestModel(
            productId:
                StateContainer.of(context).getKoloBoxEnum()?.getProductId ?? '',
            savingFrequency:
                StateContainer.of(context).getPeriodEnum().getPeriodPassValue,
            depositAmount:
                getOnlyAmount(StateContainer.of(context).getAmount()),
          )));
    }
  }

  void callPayment(
      String amount, String accessCode, String referenceCode) async {
    PayStackPayment payStackPayment = sl();
    await payStackPayment.checkout(
      context,
      amount,
      prefHelper?.getLoginResponseModel().email ?? '',
      referenceCode,
      accessCode,
      (referenceCode) {
        Future.delayed(const Duration(milliseconds: 300), () {
          navigatePush(
              context,
              TransactionSuccessfulPage(
                referenceCode: referenceCode,
                amount: amount,
                isDeposited: true,
                isSuccess: true,
              ));
        });
      },
      (errorMessage) {
        Future.delayed(const Duration(milliseconds: 300), () {
          navigatePush(
              context,
              TransactionSuccessfulPage(
                referenceCode: referenceCode,
                amount: amount,
                isDeposited: true,
                isSuccess: false,
                errorMessage: errorMessage,
              ));
        });
      },
    );
  }
}
