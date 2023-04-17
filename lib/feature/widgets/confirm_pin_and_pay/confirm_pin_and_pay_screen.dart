import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/app_constants.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/pay_stack_payment_gateway/pay_stack_payment.dart';
import 'package:kolobox_new_app/core/ui/extension.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/select_product_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/top_up_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/verify_pin_request_model.dart';
import 'package:kolobox_new_app/feature/widgets/confirm_pin_and_pay/bloc/confirm_pin_and_pay_bloc.dart';
import 'package:kolobox_new_app/feature/widgets/confirm_pin_and_pay/bloc/confirm_pin_and_pay_event.dart';
import 'package:kolobox_new_app/feature/widgets/confirm_pin_and_pay/bloc/confirm_pin_and_pay_state.dart';
import 'package:kolobox_new_app/feature/widgets/inherited_state_container.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../core/ui/widgets/toast_widget.dart';
import '../../../core/utils/utils.dart';
import '../../../di/injection_container.dart';
import '../../../routes/routes.dart';
import '../../transaction_successful/presentation/transaction_successful_page.dart';

class ConfirmPinAndPayScreen extends BaseBlocWidget {
  const ConfirmPinAndPayScreen({
    Key? key,
  }) : super(key: key);

  @override
  ConfirmPinAndPayScreenState createState() => ConfirmPinAndPayScreenState();
}

class ConfirmPinAndPayScreenState
    extends BaseBlocWidgetState<ConfirmPinAndPayScreen> {
  TextEditingController otpTextEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() =>
      BlocListener<ConfirmPinAndPayBloc, ConfirmPinAndPayState>(
        listener: (_, state) {
          if (state is VerifyPinState) {
            Future.delayed(const Duration(milliseconds: 200), () {
              initiatePayment();
            });
          } else if (state is SelectProductState) {
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
              const SizedBox(
                height: 35,
              ),
              Text(
                'Confirm with PIN',
                style:
                    AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 6,
              ),
              Text(
                'Enter your secure 4 digit pin to confirm',
                style: AppStyle.b8Medium
                    .copyWith(color: ColorList.blackThirdColor),
              ),
              const SizedBox(
                height: 30,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 25),
                child: PinCodeTextField(
                  appContext: context,
                  controller: otpTextEditingController,
                  length: 4,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(12),
                    fieldHeight: 45,
                    fieldWidth: 45,
                    borderWidth: 1,
                    inactiveColor: ColorList.greyLightColor,
                    activeColor: ColorList.greyLightColor,
                    selectedColor: ColorList.greyLightColor,
                  ),
                  textStyle: AppStyle.b9Bold.copyWith(
                    color: ColorList.blackThirdColor,
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                  onChanged: (String value) {},
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Button(
                'Next',
                backgroundColor: ColorList.primaryColor,
                textColor: ColorList.white,
                overlayColor: ColorList.blueColor,
                borderRadius: 32,
                onPressed: () => onClickNext(),
              ),
            ],
          ),
        ),
      );

  void onClickNext() {
    hideKeyboard();
    if (otpTextEditingController.text.isEmpty) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter otp',
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
    if (otpTextEditingController.text.length != 4) {
      Utils.showToast(
          context,
          ToastWidget(
            'Enter valid otp',
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
    BlocProvider.of<ConfirmPinAndPayBloc>(context).add(VerifyPinEvent(
      model: VerifyPinRequestModel(
        pin: otpTextEditingController.text,
        userId: prefHelper?.getLoginResponseModel().id ?? '',
      ),
    ));
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

  @override
  void dispose() {
    super.dispose();
  }
}
