import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/currency_text_input_formatter.dart';
import 'package:kolobox_new_app/core/utils/date_helper.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:kolobox_new_app/feature/transaction_successful/presentation/bloc/transaction_successful_bloc.dart';
import 'package:kolobox_new_app/feature/transaction_successful/presentation/bloc/transaction_successful_event.dart';
import 'package:kolobox_new_app/feature/transaction_successful/presentation/bloc/transaction_successful_state.dart';
import 'package:kolobox_new_app/feature/widgets/product_item_widget.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/pay_stack_payment_gateway/pay_stack_payment.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../../core/ui/widgets/toast_widget.dart';
import '../../../../core/utils/utils.dart';
import '../../../../di/injection_container.dart';
import '../../../dashboard/data/models/create_investment_goal_request_model.dart';
import '../../../dashboard/data/models/select_product_request_model.dart';
import '../../../dashboard/data/models/top_up_request_model.dart';
import '../../../widgets/confirm_pin_and_pay/bloc/confirm_pin_and_pay_bloc.dart';
import '../../../widgets/confirm_pin_and_pay/bloc/confirm_pin_and_pay_event.dart';
import '../../../widgets/confirm_pin_and_pay/bloc/confirm_pin_and_pay_state.dart';
import '../../../widgets/inherited_state_container.dart';

class TransactionSuccessfulScreen extends BaseBlocWidget {
  final String referenceCode;
  final String amount;
  final bool isDeposited;
  final bool isSuccess;
  final String errorMessage;

  const TransactionSuccessfulScreen({
    Key? key,
    required this.referenceCode,
    required this.isDeposited,
    required this.isSuccess,
    required this.amount,
    required this.errorMessage,
  }) : super(key: key);

  @override
  TransactionSuccessfulScreenState createState() =>
      TransactionSuccessfulScreenState();
}

class TransactionSuccessfulScreenState
    extends BaseBlocWidgetState<TransactionSuccessfulScreen>
    with TickerProviderStateMixin {
  // late AnimationController scaleController = AnimationController(
  //     duration: const Duration(milliseconds: 800), vsync: this);
  // late Animation<double> scaleAnimation =
  //     CurvedAnimation(parent: scaleController, curve: Curves.elasticOut);
  // late AnimationController checkController =
  //     AnimationController(duration: const Duration(seconds: 2), vsync: this);
  // late Animation<double> checkAnimation =
  //     CurvedAnimation(parent: checkController, curve: Curves.linearToEaseOut);
  StreamController<bool> dataStreamController =
      StreamController<bool>.broadcast();

  bool _isSuccess = true;
  bool _isDeposited = true;
  String _referenceCode = '';
  String _amount = '';
  String _errorMessage = '';

  KoloboxFundEnum? koloboxFundEnum;
  bool isInActive = false;

  @override
  void initState() {
    super.initState();
    _isSuccess = widget.isSuccess;
    _isDeposited = widget.isDeposited;
    _referenceCode = widget.referenceCode;
    _amount = widget.amount;
    _errorMessage = widget.errorMessage;
    // scaleController.addStatusListener((status) {
    //   if (status == AnimationStatus.completed) {
    //     checkController.forward();
    //   }
    // });
    // scaleController.forward();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    koloboxFundEnum = StateContainer.of(context).getKoloBoxEnum();
    isInActive = koloboxFundEnum?.isInActiveProduct() ?? false;
  }

  @override
  Widget getCustomBloc() {
    // double circleSize = 140;
    // double iconSize = 108;
    //
    // return Stack(
    //   children: [
    //     Center(
    //       child: ScaleTransition(
    //         scale: scaleAnimation,
    //         child: Container(
    //           height: circleSize,
    //           width: circleSize,
    //           decoration: BoxDecoration(
    //             color: ColorList.accentMaterialColor,
    //             shape: BoxShape.circle,
    //           ),
    //         ),
    //       ),
    //     ),
    //     SizeTransition(
    //       sizeFactor: checkAnimation,
    //       axis: Axis.horizontal,
    //       axisAlignment: -1,
    //       child: Center(
    //         child:
    //             Icon(Icons.check_rounded, color: Colors.white, size: iconSize),
    //       ),
    //     ),
    //   ],
    // );
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        backgroundColor: ColorList.white,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 30),
          child: MultiBlocListener(
            listeners: [
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
                  } else if (state is CreateInvestmentGoalState) {
                    // Goal created pay the save amount Go to success page
                    Future.delayed(const Duration(milliseconds: 300), () {
                      onSuccess(state.referenceCode, state.amount, true, true);
                    });
                  }
                },
              ),
              BlocListener<TransactionSuccessfulBloc,
                  TransactionSuccessfulState>(
                listener: (_, state) {
                  if (state is CallProductState) {
                    StateContainer.of(context).isSuccessful = true;
                    Future.delayed(const Duration(milliseconds: 300), () {
                      BlocProvider.of<DashboardBloc>(context)
                          .add(ClearBackStackEvent(
                        until: StateContainer.of(context).getPopUntil(),
                      ));
                    });
                  }
                },
              ),
            ],
            child: StreamBuilder<bool>(
                stream: dataStreamController.stream,
                builder: (context, snapshot) => getChild()),
          ),
        ),
      ),
    );
  }

  Column getChild() {
    return Column(
      children: [
        Expanded(
            child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 22,
              ),
              Image.asset(_isSuccess ? imageConfirm : imageErrorIcon),
              const SizedBox(
                height: 8,
              ),
              Text(
                _isSuccess ? 'Transaction Successful' : 'Transaction Failed',
                style:
                    AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 7,
              ),
              Text(
                _isSuccess ? 'This transaction was successful' : _errorMessage,
                style: AppStyle.b8Medium
                    .copyWith(color: ColorList.blackThirdColor),
              ),
              const SizedBox(
                height: 17,
              ),
              Container(
                decoration: BoxDecoration(
                  color: _isDeposited
                      ? ColorList.lightBlue6Color
                      : ColorList.redLightColor,
                  shape: BoxShape.circle,
                ),
                padding: const EdgeInsets.all(25),
                child: Icon(
                  _isDeposited ? KoloBoxIcons.deposit : KoloBoxIcons.withdrawal,
                  size: 20,
                  color: _isDeposited
                      ? ColorList.primaryColor
                      : ColorList.redDarkColor,
                ),
              ),
              const SizedBox(
                height: 17,
              ),
              Text(
                _isDeposited ? 'Deposited' : 'Withdrawal',
                style:
                    AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                CurrencyTextInputFormatter.formatAmount(_amount),
                style:
                    AppStyle.b5SemiBold.copyWith(color: ColorList.primaryColor),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                DateHelper.getTextFromDateTime(
                    DateTime.now(), 'MMM dd, yyyy - hh:mm a'),
                style: AppStyle.b9SemiBold
                    .copyWith(color: ColorList.greyLight2Color),
              ),
              const SizedBox(
                height: 18,
              ),
              Text(
                'Ref',
                style: AppStyle.b9SemiBold
                    .copyWith(color: ColorList.greyLight2Color),
              ),
              const SizedBox(
                height: 3,
              ),
              Text(
                _referenceCode,
                style: AppStyle.b8Medium
                    .copyWith(color: ColorList.blackThirdColor),
              ),
            ],
          ),
        )),
        Column(
          children: [
            Text(
              'Deposit destination',
              style: AppStyle.b8SemiBold
                  .copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 7,
            ),
            if (StateContainer.of(context).getKoloBoxEnum() != null) ...[
              ProductItemWidget(
                  fundEnum: StateContainer.of(context).getKoloBoxEnum()!),
            ],
            // Container(
            //   decoration: BoxDecoration(
            //     color: ColorList.lightBlue3Color,
            //     borderRadius: BorderRadius.circular(14),
            //   ),
            //   padding: const EdgeInsets.symmetric(
            //       horizontal: 20, vertical: 20),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Wallet',
            //         style: AppStyle.b3Bold
            //             .copyWith(color: ColorList.blackSecondColor),
            //       ),
            //       Image.asset(imageWalletSuccessIconSelected),
            //     ],
            //   ),
            // ),
            const SizedBox(
              height: 15,
            ),
            Button(
              'Share',
              backgroundColor: ColorList.lightBlue3Color,
              textColor: ColorList.primaryColor,
              overlayColor: ColorList.blueColor,
              borderRadius: 32,
              onPressed: () => comingSoon(),
            ),
            const SizedBox(
              height: 15,
            ),
            if (_isSuccess) ...[
              Button(
                'Ok',
                backgroundColor: ColorList.primaryColor,
                textColor: ColorList.white,
                overlayColor: ColorList.blueColor,
                borderRadius: 32,
                onPressed: () =>
                    BlocProvider.of<TransactionSuccessfulBloc>(context)
                        .add(CallProductEvent()),
              ),
            ] else ...[
              Button(
                'Try Again',
                backgroundColor: ColorList.redDarkColor,
                textColor: ColorList.white,
                overlayColor: ColorList.redDark2Color,
                borderRadius: 32,
                onPressed: () => initiatePayment(),
              ),
            ],
          ],
        ),
      ],
    );
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
            savingFrequency: 'monthly',
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
          if (!isInActive && isKoloTarget()) {
            // Create Goal
            BlocProvider.of<ConfirmPinAndPayBloc>(context).add(
              CreateInvestmentGoalEvent(
                model: CreateInvestmentGoalRequestModel(
                  purpose: StateContainer.of(context).getTargetName() ?? '',
                  amount: StateContainer.of(context).getTargetAmount(),
                  dueDate: DateHelper.getTextFromDateTime(
                      StateContainer.of(context).getTargetDate()!,
                      'yyyy-MM-dd'),
                ),
                amount: amount,
                referenceCode: referenceCode,
              ),
            );
          } else {
            onSuccess(referenceCode, amount, true, true);
          }
        });
      },
      (errorMessage) {
        Future.delayed(const Duration(milliseconds: 300), () {
          _errorMessage = errorMessage;
          onSuccess(referenceCode, amount, true, false);
        });
      },
    );
  }

  void onSuccess(
      String referenceCode, String amount, bool isDeposited, bool isSuccess) {
    _referenceCode = referenceCode;
    _amount = amount;
    _isDeposited = isDeposited;
    _isSuccess = isSuccess;
    dataStreamController.add(true);
  }

  @override
  void dispose() {
    // scaleController.dispose();
    // checkController.dispose();
    dataStreamController.close();
    super.dispose();
  }

  bool isKoloFlex() => koloboxFundEnum == KoloboxFundEnum.koloFlex;

  bool isKoloTarget() => koloboxFundEnum == KoloboxFundEnum.koloTarget;

  // bool isKoloTargetPlus() => koloboxFundEnum == KoloboxFundEnum.koloTargetPlus;

  bool isKoloFamily() => koloboxFundEnum == KoloboxFundEnum.koloFamily;

  bool isKoloGroup() => koloboxFundEnum == KoloboxFundEnum.koloGroup;
}
