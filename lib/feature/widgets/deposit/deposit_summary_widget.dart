import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_bloc_widget.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/enums/payment_gateway_enum.dart';
import 'package:kolobox_new_app/core/enums/period_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/core/ui/widgets/currency_text_input_formatter.dart';
import 'package:kolobox_new_app/feature/widgets/confirm_pin_and_pay/bloc/confirm_pin_and_pay_bloc.dart';
import 'package:kolobox_new_app/feature/widgets/inherited_state_container.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../core/colors/color_list.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/pay_stack_payment_gateway/pay_stack_payment.dart';
import '../../../core/ui/widgets/toast_widget.dart';
import '../../../core/utils/date_helper.dart';
import '../../../core/utils/utils.dart';
import '../../../di/injection_container.dart';
import '../../dashboard/data/models/create_family_request_model.dart';
import '../../dashboard/data/models/create_group_request_model.dart';
import '../../dashboard/data/models/create_investment_goal_request_model.dart';
import '../../dashboard/data/models/select_product_request_model.dart';
import '../../dashboard/data/models/top_up_request_model.dart';
import '../../transaction_successful/presentation/transaction_successful_page.dart';
import '../confirm_pin_and_pay/bloc/confirm_pin_and_pay_event.dart';
import '../confirm_pin_and_pay/bloc/confirm_pin_and_pay_state.dart';
import '../product_item_widget.dart';

class DepositSummaryWidget extends BaseBlocWidget {
  const DepositSummaryWidget({
    Key? key,
  }) : super(key: key);

  @override
  State<DepositSummaryWidget> createState() => _DepositSummaryWidgetState();
}

class _DepositSummaryWidgetState
    extends BaseBlocWidgetState<DepositSummaryWidget> {
  KoloboxFundEnum? koloboxFundEnum;
  bool isInActive = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    koloboxFundEnum = StateContainer.of(context).getKoloBoxEnum();
    isInActive = koloboxFundEnum?.isInActiveProduct() ?? false;
  }

  @override
  Widget getCustomBloc() =>
      BlocListener<ConfirmPinAndPayBloc, ConfirmPinAndPayState>(
        listener: (_, state) {
          if (state is SelectProductState) {
            Future.delayed(const Duration(milliseconds: 200), () {
              if (isKoloGroup()) {
                StateContainer.of(context).openFundMyKoloBox(
                  fundEnum: StateContainer.of(context).getKoloBoxEnum(),
                  amount: StateContainer.of(context).getAmount(),
                  periodEnum: StateContainer.of(context).getPeriodEnum(),
                  groupTenorModel:
                      StateContainer.of(context).getGroupTenorModel(),
                  groupId: state.createGroupResponseModel?.id,
                  groupName: state.createGroupResponseModel?.name,
                  targetAmount: StateContainer.of(context).getTargetAmount(),
                  targetDateTime: StateContainer.of(context).getTargetDate(),
                  targetName: StateContainer.of(context).getTargetName(),
                  paymentEnum: PaymentGatewayEnum.payStack,
                  familyUserId: state.createGroupResponseModel?.subUser?.id,
                );
              } else if (isKoloFamily()) {
                StateContainer.of(context).openFundMyKoloBox(
                  fundEnum: StateContainer.of(context).getKoloBoxEnum(),
                  amount: StateContainer.of(context).getAmount(),
                  periodEnum: StateContainer.of(context).getPeriodEnum(),
                  groupTenorModel:
                      StateContainer.of(context).getGroupTenorModel(),
                  groupId: state.createGroupResponseModel?.id,
                  groupName: state.createGroupResponseModel?.name,
                  targetAmount: StateContainer.of(context).getTargetAmount(),
                  targetDateTime: StateContainer.of(context).getTargetDate(),
                  targetName: StateContainer.of(context).getTargetName(),
                  paymentEnum: PaymentGatewayEnum.payStack,
                  familyUserId: state.createGroupResponseModel?.subUser?.id,
                );
              }
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
              onSuccess(state.amount, state.referenceCode);
            });
          } else if (state is CreateGroupState) {
            // Group created now select product
            Future.delayed(const Duration(milliseconds: 300), () {
              // Call for select product api
              BlocProvider.of<ConfirmPinAndPayBloc>(context)
                  .add(SelectProductEvent(
                userId: prefHelper?.getLoginResponseModel().id ?? '',
                model: SelectProductRequestModel(
                  productId: StateContainer.of(context)
                          .getKoloBoxEnum()
                          ?.getProductId ??
                      '',
                  savingFrequency: StateContainer.of(context)
                      .getPeriodEnum()
                      .getPeriodPassValue,
                  depositAmount:
                      getOnlyAmount(StateContainer.of(context).getAmount()),
                  groupId: state.responseModel.id ?? '',
                  subUserId: state.responseModel.subUser?.id ?? '',
                ),
                createGroupResponseModel: state.responseModel,
              ));
            });
          } else if (state is CreateFamilyState) {
            // Group created now select product
            Future.delayed(const Duration(milliseconds: 300), () {
              // Call for select product api
              BlocProvider.of<ConfirmPinAndPayBloc>(context)
                  .add(SelectProductEvent(
                userId: prefHelper?.getLoginResponseModel().id ?? '',
                model: SelectProductRequestModel(
                  productId: StateContainer.of(context)
                          .getKoloBoxEnum()
                          ?.getProductId ??
                      '',
                  savingFrequency: StateContainer.of(context)
                      .getPeriodEnum()
                      .getPeriodPassValue,
                  depositAmount:
                      getOnlyAmount(StateContainer.of(context).getAmount()),
                  groupId: state.responseModel.id ?? '',
                  subUserId: state.responseModel.subUser?.id ?? '',
                ),
                createFamilyResponseModel: state.responseModel,
              ));
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
              Row(
                children: [
                  Expanded(
                    child: Text(
                      getDepositTitle(),
                      style: AppStyle.b4Bold
                          .copyWith(color: ColorList.blackSecondColor),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: GestureDetector(
                      onTap: () {
                        goBack(context);
                      },
                      child: Image.asset(imageClose),
                    ),
                  ),
                ],
              ),
              if (getDepositMessage() != null) ...[
                const SizedBox(
                  height: 5,
                ),
                Text(
                  getDepositMessage()!,
                  style: AppStyle.b8Regular
                      .copyWith(color: ColorList.blackThirdColor),
                ),
              ],
              const SizedBox(
                height: 13,
              ),
              Button(
                'Edit',
                backgroundColor: ColorList.lightBlue3Color,
                textColor: ColorList.primaryColor,
                overlayColor: ColorList.blueColor,
                borderRadius: 32,
                onPressed: () => goBack(context),
              ),
              const SizedBox(
                height: 15,
              ),
              if (isKoloFlex()) ...[
                getDepositAmount(StateContainer.of(context).getAmount()),
                const SizedBox(
                  height: 15,
                ),
                Text(
                  'Deposit into my',
                  style: AppStyle.b9Regular
                      .copyWith(color: ColorList.blackThirdColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                ProductItemWidget(fundEnum: koloboxFundEnum!),
                const SizedBox(
                  height: 15,
                ),
              ] else if (isKoloTarget()) ...[
                if (isInActive) ...[
                  getDepositAmount(StateContainer.of(context).getAmount()),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Deposit into my',
                    style: AppStyle.b9Regular
                        .copyWith(color: ColorList.blackThirdColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ProductItemWidget(fundEnum: koloboxFundEnum!),
                  const SizedBox(
                    height: 15,
                  ),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Selected Investing towards',
                  //       style: AppStyle.b9Medium
                  //           .copyWith(color: ColorList.blackSecondColor),
                  //     ),
                  //     Text(
                  //       'Renting a new home',
                  //       style: AppStyle.b8SemiBold
                  //           .copyWith(color: ColorList.blackSecondColor),
                  //     ),
                  //   ],
                  // ),
                  // const SizedBox(
                  //   height: 20,
                  // ),
                ] else ...[
                  ProductItemWidget(fundEnum: koloboxFundEnum!),
                  const SizedBox(
                    height: 15,
                  ),
                  if (koloboxFundEnum == KoloboxFundEnum.koloTarget) ...[
                    getKoloTargetSummaryWidget(),
                  ],
                ],
              ] else if (isKoloGroup()) ...[
                if (isInActive &&
                    !(StateContainer.of(context).isCreateGroup() ?? false)) ...[
                  getDepositAmount(StateContainer.of(context).getAmount()),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Deposit into my',
                    style: AppStyle.b9Regular
                        .copyWith(color: ColorList.blackThirdColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ProductItemWidget(fundEnum: koloboxFundEnum!),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Deposit into my group',
                    style: AppStyle.b9Regular
                        .copyWith(color: ColorList.blackThirdColor),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    StateContainer.of(context).getGroupName() ?? '',
                    style: AppStyle.b8Medium
                        .copyWith(color: ColorList.blackThirdColor),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ] else ...[
                  ProductItemWidget(fundEnum: koloboxFundEnum!),
                  const SizedBox(
                    height: 15,
                  ),
                  if (koloboxFundEnum == KoloboxFundEnum.koloGroup) ...[
                    getKoloGroupSummaryWidget(),
                  ],
                ],
              ] else if (isKoloFamily()) ...[
                if (isInActive &&
                    !(StateContainer.of(context).isCreateGroup() ?? false)) ...[
                  getDepositAmount(StateContainer.of(context).getAmount()),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Deposit into my',
                    style: AppStyle.b9Regular
                        .copyWith(color: ColorList.blackThirdColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  ProductItemWidget(fundEnum: koloboxFundEnum!),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    'Deposit into my group',
                    style: AppStyle.b9Regular
                        .copyWith(color: ColorList.blackThirdColor),
                  ),
                  const SizedBox(
                    height: 7,
                  ),
                  Text(
                    StateContainer.of(context).getGroupName() ?? '',
                    style: AppStyle.b8Medium
                        .copyWith(color: ColorList.blackThirdColor),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                ] else ...[
                  ProductItemWidget(fundEnum: koloboxFundEnum!),
                  const SizedBox(
                    height: 15,
                  ),
                  if (koloboxFundEnum == KoloboxFundEnum.koloFamily) ...[
                    getKoloFamilySummaryWidget(),
                  ],
                ],
              ],
              // if (isInActive) ...[
              //   getDepositAmount(),
              //   const SizedBox(
              //     height: 15,
              //   ),
              //   Text(
              //     'Deposit into my',
              //     style: AppStyle.b9Regular
              //         .copyWith(color: ColorList.blackThirdColor),
              //   ),
              //   const SizedBox(
              //     height: 5,
              //   ),
              //   ProductItemWidget(fundEnum: koloboxFundEnum!),
              //   const SizedBox(
              //     height: 15,
              //   ),
              // ],
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
      periodEnum: StateContainer.of(context).getPeriodEnum(),
      groupTenorModel: StateContainer.of(context).getGroupTenorModel(),
      groupId: StateContainer.of(context).getGroupId(),
      groupName: StateContainer.of(context).getGroupName(),
      targetAmount: StateContainer.of(context).getTargetAmount(),
      targetDateTime: StateContainer.of(context).getTargetDate(),
      targetName: StateContainer.of(context).getTargetName(),
      paymentEnum: PaymentGatewayEnum.payStack,
      isCreateGroup: StateContainer.of(context).isCreateGroup(),
      familyUserId: StateContainer.of(context).getFamilyUserId(),
    );

    if (isKoloFlex()) {
      initiatePayment();
    } else if (isKoloTarget()) {
      initiatePayment();
    } else if (isKoloGroup()) {
      initiatePayment();
    } else if (isKoloFamily()) {
      initiatePayment();
    }
  }

  void initiatePayment() {
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

    if (StateContainer.of(context).isCreateGroup() ?? false) {
      // create group and create family case
      if (isKoloGroup()) {
        // Create Group
        BlocProvider.of<ConfirmPinAndPayBloc>(context).add(
          CreateGroupEvent(
            model: CreateGroupRequestModel(
              name: StateContainer.of(context).getTargetName() ?? '',
              tenorId:
                  StateContainer.of(context).getGroupTenorModel()?.id ?? '',
              groupTypeId: "",
              minimumAmount: StateContainer.of(context).getTargetAmount(),
              frequency:
                  StateContainer.of(context).getPeriodEnum().getPeriodPassValue,
            ),
          ),
        );
      }
      if (isKoloFamily()) {
        // Create Family
        BlocProvider.of<ConfirmPinAndPayBloc>(context).add(
          CreateFamilyEvent(
            model: CreateFamilyRequestModel(
              name: StateContainer.of(context).getTargetName() ?? '',
              tenorId:
                  StateContainer.of(context).getGroupTenorModel()?.id ?? '',
              groupTypeId: "",
              minimumAmount: StateContainer.of(context).getTargetAmount(),
              frequency:
                  StateContainer.of(context).getPeriodEnum().getPeriodPassValue,
            ),
          ),
        );
      }
    } else {
      if (isInActive) {
        // flex, target, group, family top up case
        // Call for top up api
        BlocProvider.of<ConfirmPinAndPayBloc>(context).add(TopUpEvent(
            productId:
                StateContainer.of(context).getKoloBoxEnum()?.getProductId ?? '',
            model: TopUpRequestModel(
              productId:
                  StateContainer.of(context).getKoloBoxEnum()?.getProductId ??
                      '',
              depositAmount:
                  getOnlyAmount(StateContainer.of(context).getAmount()),
              groupId: StateContainer.of(context).getGroupId() ?? '',
              subUserId: StateContainer.of(context).getFamilyUserId() ?? '',
            )));
      } else {
        if (isKoloGroup()) {
          // Create Group
          BlocProvider.of<ConfirmPinAndPayBloc>(context).add(
            CreateGroupEvent(
              model: CreateGroupRequestModel(
                name: StateContainer.of(context).getTargetName() ?? '',
                tenorId:
                    StateContainer.of(context).getGroupTenorModel()?.id ?? '',
                groupTypeId: "",
                minimumAmount: StateContainer.of(context).getTargetAmount(),
                frequency: StateContainer.of(context)
                    .getPeriodEnum()
                    .getPeriodPassValue,
              ),
            ),
          );
        } else if (isKoloFamily()) {
          // Create Group
          BlocProvider.of<ConfirmPinAndPayBloc>(context).add(
            CreateFamilyEvent(
              model: CreateFamilyRequestModel(
                name: StateContainer.of(context).getTargetName() ?? '',
                tenorId:
                    StateContainer.of(context).getGroupTenorModel()?.id ?? '',
                groupTypeId: "",
                minimumAmount: StateContainer.of(context).getTargetAmount(),
                frequency: StateContainer.of(context)
                    .getPeriodEnum()
                    .getPeriodPassValue,
              ),
            ),
          );
        } else {
          // flex and target select product
          // Call for select product api
          BlocProvider.of<ConfirmPinAndPayBloc>(context).add(SelectProductEvent(
              userId: prefHelper?.getLoginResponseModel().id ?? '',
              model: SelectProductRequestModel(
                productId:
                    StateContainer.of(context).getKoloBoxEnum()?.getProductId ??
                        '',
                savingFrequency: StateContainer.of(context)
                    .getPeriodEnum()
                    .getPeriodPassValue,
                depositAmount:
                    getOnlyAmount(StateContainer.of(context).getAmount()),
                groupId: StateContainer.of(context).getGroupId() ?? '',
                subUserId: StateContainer.of(context).getFamilyUserId() ?? '',
              )));
        }
      }
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
            onSuccess(amount, referenceCode);
          }
        });
      },
      (errorMessage) {
        Future.delayed(const Duration(milliseconds: 300), () {
          onFailure(amount, referenceCode, errorMessage);
        });
      },
    );
  }

  void onSuccess(String amount, String referenceCode) {
    navigatePush(
        context,
        TransactionSuccessfulPage(
          referenceCode: referenceCode,
          amount: amount,
          isDeposited: true,
          isSuccess: true,
        ));
  }

  void onFailure(String amount, String referenceCode, String errorMessage) {
    navigatePush(
        context,
        TransactionSuccessfulPage(
          referenceCode: referenceCode,
          amount: amount,
          isDeposited: true,
          isSuccess: false,
          errorMessage: errorMessage,
        ));
  }

  Container getDepositAmount(String amount) {
    return Container(
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
              style: AppStyle.b8Regular.copyWith(color: ColorList.white),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              CurrencyTextInputFormatter.formatAmount(amount),
              style: AppStyle.b3Bold.copyWith(color: ColorList.white),
            ),
          ],
        ),
      ),
    );
  }

  String getDepositTitle() {
    String message = 'Deposit Summary';
    logger?.d("deposit message $koloboxFundEnum In active $isInActive");

    if (!isInActive && koloboxFundEnum == KoloboxFundEnum.koloTarget) {
      return '${koloboxFundEnum!.getFundValue} Summary';
    }

    return message;
  }

  String? getDepositMessage() {
    if (!isInActive && koloboxFundEnum == KoloboxFundEnum.koloTarget) {
      return 'Start investing towards your goal';
    }
    return null;
  }

  Widget getKoloTargetSummaryWidget() {
    String targetName = StateContainer.of(context).getTargetName() ?? '';
    DateTime? targetDate = StateContainer.of(context).getTargetDate();
    String amount = StateContainer.of(context).getAmount();
    String targetAmount = StateContainer.of(context).getTargetAmount();
    PeriodEnum periodEnum = StateContainer.of(context).getPeriodEnum();
    return Column(
      children: [
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
                const SizedBox(
                  height: 5,
                ),
                Text(
                  targetName,
                  style: AppStyle.b7Bold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
              ],
            ),
            if (targetDate != null) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'End date',
                    style: AppStyle.b9Medium
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateHelper.getTextFromDateTime(targetDate, 'dd MMMM yyyy'),
                    style: AppStyle.b7Bold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                ],
              ),
            ],
          ],
        ),
        const SizedBox(
          height: 15,
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
                CurrencyTextInputFormatter.formatAmount(targetAmount),
                style:
                    AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
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
                  'Saving now',
                  style: AppStyle.b8Regular.copyWith(color: ColorList.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  CurrencyTextInputFormatter.formatAmount(amount),
                  style: AppStyle.b3Bold.copyWith(color: ColorList.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: ColorList.lightBlue11Color,
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(10),
          child: Column(
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
                periodEnum.getPeriodValue,
                style:
                    AppStyle.b6Bold.copyWith(color: ColorList.blackSecondColor),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget getKoloGroupSummaryWidget() {
    String targetName = StateContainer.of(context).getTargetName() ?? '';
    DateTime? targetDate = StateContainer.of(context).getTargetDate();
    String amount = StateContainer.of(context).getAmount();
    String targetAmount = StateContainer.of(context).getTargetAmount();
    PeriodEnum periodEnum = StateContainer.of(context).getPeriodEnum();
    return Column(
      children: [
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
                const SizedBox(
                  height: 5,
                ),
                Text(
                  targetName,
                  style: AppStyle.b7Bold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
              ],
            ),
            if (targetDate != null) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'End date',
                    style: AppStyle.b9Medium
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateHelper.getTextFromDateTime(targetDate, 'dd MMMM yyyy'),
                    style: AppStyle.b7Bold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                ],
              ),
            ],
          ],
        ),
        const SizedBox(
          height: 15,
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
                CurrencyTextInputFormatter.formatAmount(targetAmount),
                style:
                    AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
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
                  'Saving now',
                  style: AppStyle.b8Regular.copyWith(color: ColorList.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  CurrencyTextInputFormatter.formatAmount(amount),
                  style: AppStyle.b3Bold.copyWith(color: ColorList.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: ColorList.lightBlue11Color,
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(10),
          child: Column(
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
                periodEnum.getPeriodValue,
                style:
                    AppStyle.b6Bold.copyWith(color: ColorList.blackSecondColor),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  Widget getKoloFamilySummaryWidget() {
    String targetName = StateContainer.of(context).getTargetName() ?? '';
    DateTime? targetDate = StateContainer.of(context).getTargetDate();
    String amount = StateContainer.of(context).getAmount();
    String targetAmount = StateContainer.of(context).getTargetAmount();
    PeriodEnum periodEnum = StateContainer.of(context).getPeriodEnum();
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Family Name',
                  style: AppStyle.b9Medium
                      .copyWith(color: ColorList.blackSecondColor),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  targetName,
                  style: AppStyle.b7Bold
                      .copyWith(color: ColorList.blackSecondColor),
                ),
              ],
            ),
            if (targetDate != null) ...[
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    'End date',
                    style: AppStyle.b9Medium
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    DateHelper.getTextFromDateTime(targetDate, 'dd MMMM yyyy'),
                    style: AppStyle.b7Bold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                ],
              ),
            ],
          ],
        ),
        const SizedBox(
          height: 15,
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
                'Family Target amount',
                style: AppStyle.b9Regular
                    .copyWith(color: ColorList.blackSecondColor),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                CurrencyTextInputFormatter.formatAmount(targetAmount),
                style:
                    AppStyle.b4Bold.copyWith(color: ColorList.blackSecondColor),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
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
                  'Saving now',
                  style: AppStyle.b8Regular.copyWith(color: ColorList.white),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  CurrencyTextInputFormatter.formatAmount(amount),
                  style: AppStyle.b3Bold.copyWith(color: ColorList.white),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
              color: ColorList.lightBlue11Color,
              borderRadius: BorderRadius.circular(12)),
          padding: const EdgeInsets.all(10),
          child: Column(
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
                periodEnum.getPeriodValue,
                style:
                    AppStyle.b6Bold.copyWith(color: ColorList.blackSecondColor),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 15,
        ),
      ],
    );
  }

  bool isKoloFlex() => koloboxFundEnum == KoloboxFundEnum.koloFlex;

  bool isKoloTarget() => koloboxFundEnum == KoloboxFundEnum.koloTarget;

  // bool isKoloTargetPlus() => koloboxFundEnum == KoloboxFundEnum.koloTargetPlus;

  bool isKoloFamily() => koloboxFundEnum == KoloboxFundEnum.koloFamily;

  bool isKoloGroup() => koloboxFundEnum == KoloboxFundEnum.koloGroup;
}
