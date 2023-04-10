import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:kolobox_new_app/feature/koloflex/presentation/bloc/kolo_flex_bloc.dart';
import 'package:kolobox_new_app/feature/widgets/deposited_withdrawal_info/deposited_withdrawal_info_kolobox_widget.dart';
import 'package:kolobox_new_app/feature/widgets/kolo_info_widget.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../../core/ui/widgets/currency_text_input_formatter.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../dashboard/data/models/transactions_data_model.dart';
import '../../../widgets/deposit/deposit_your_kolobox_widget.dart';
import '../../../widgets/home_app_bar_widget.dart';
import '../../../widgets/inherited_state_container.dart';
import '../bloc/kolo_flex_event.dart';
import '../bloc/kolo_flex_state.dart';
import '../widgets/account_item_widget.dart';
import '../widgets/transactions_item_widget.dart';

class KoloFlexScreen extends BaseBlocWidget {
  const KoloFlexScreen({
    Key? key,
  }) : super(key: key);

  @override
  KoloFlexScreenState createState() => KoloFlexScreenState();
}

class KoloFlexScreenState extends BaseBlocWidgetState<KoloFlexScreen> {
  StreamController<bool> emptyStreamController =
      StreamController<bool>.broadcast();
  StreamController<bool> leftRightStreamController =
      StreamController<bool>.broadcast();
  bool isLeft = true;

  bool isEmpty = true;

  // KoloboxFundEnum koloboxFundEnum = KoloboxFundEnum.koloFlex;

  List<Transactions> transactions = [];

  @override
  void initState() {
    super.initState();
    callTransactions();
  }

  callTransactions() =>
      BlocProvider.of<KoloFlexBloc>(context).add(GetTransactionsEvent(
        model: TransactionsRequestModel(
            productId: KoloboxFundEnum.koloFlex.getProductId),
      ));

  @override
  Widget getCustomBloc() {
    // koloboxFundEnum = StateContainer.of(context).koloboxFundEnum;
    return Scaffold(
      backgroundColor: ColorList.white,
      appBar: const NoAppBar(),
      body: BlocListener<KoloFlexBloc, KoloFlexState>(
        listener: (_, state) {
          if (state is GetTransactionsState) {
            transactions = state.model.transactions ?? [];
            isEmpty = transactions.isEmpty;
            emptyStreamController.add(isEmpty);
          }
        },
        child: getChild(),
      ),
    );
  }

  ScrollConfiguration getChild() {
    return ScrollConfiguration(
      behavior: NoOverFlowScrollbarBehaviour(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAppBarWidget(
              leftIcon: imageBackArrowIcon,
              rightIcon: imageInfoIcon,
              onRightPressed: () {
                BlocProvider.of<DashboardBloc>(context)
                    .add(HideDisableBottomScreenEvent());
                showCustomBottomSheet(const KoloInfoWidget(
                  koloboxFundEnum: KoloboxFundEnum.koloFlex,
                )).then((value) {
                  BlocProvider.of<DashboardBloc>(context)
                      .add(ShowEnableBottomScreenEvent());
                });
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 18.52),
              child: Column(
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Koloflex Account',
                    style: AppStyle.b7SemiBold
                        .copyWith(color: ColorList.blackSecondColor),
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    CurrencyTextInputFormatter.formatAmount(
                        KoloboxFundEnum.koloFlex.getDepositAmountValue()),
                    style: AppStyle.b2Bold
                        .copyWith(color: ColorList.koloFlexTextColor),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: ColorList.koloFlexColor,
                      borderRadius: BorderRadius.circular(14),
                    ),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 18),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Interest (${CurrencyTextInputFormatter.formatAmount(KoloboxFundEnum.koloFlex.getInterestRate(), isSymbol: false)}% p.a)',
                          style: AppStyle.b7SemiBold
                              .copyWith(color: ColorList.blackSecondColor),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '₦ 540.00',
                              style: AppStyle.b7Bold
                                  .copyWith(color: ColorList.koloFlexTextColor),
                            ),
                            const SizedBox(
                              height: 3,
                            ),
                            Text(
                              'Interest in ${KoloboxFundEnum.koloFlex.getTenor()} days',
                              style: AppStyle.b9Medium
                                  .copyWith(color: ColorList.blackThirdColor),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: ColorList.greyLight6Color, width: 1),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    width: double.maxFinite,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 13, vertical: 14),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Withdrawals',
                          style: AppStyle.b9Medium
                              .copyWith(color: ColorList.blackThirdColor),
                        ),
                        Text(
                          '0 of 5 limit used this month',
                          style: AppStyle.b9Bold
                              .copyWith(color: ColorList.blackThirdColor),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  StreamBuilder(
                    initialData: isEmpty,
                    stream: emptyStreamController.stream,
                    builder: (_, snapshot) =>
                        isEmpty ? getEmptyWidget() : getDataWidget(),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget getEmptyWidget() => Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Recent Transaction',
              style: AppStyle.b7SemiBold
                  .copyWith(color: ColorList.blackSecondColor),
            ),
          ),
          const SizedBox(
            height: 60,
          ),
          Icon(
            KoloboxFundEnum.koloFlex.getFundIconValue,
            size: 55,
            color: KoloboxFundEnum.koloFlex.getFundIconColorValue,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'You have not performed any transaction',
            style: AppStyle.b8Medium.copyWith(color: ColorList.blackThirdColor),
          ),
          const SizedBox(
            height: 20,
          ),
          SizedBox(
            width: 180,
            child: Button(
              'Deposit',
              backgroundColor: ColorList.lightBlue3Color,
              textColor: ColorList.primaryColor,
              overlayColor: ColorList.blueColor,
              borderRadius: 24,
              verticalPadding: 10,
              onPressed: () => onClickDeposit(),
              postIcon: imageDownload,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      );

  void onClickDeposit() {
    StateContainer.of(context).openFundMyKoloBox(
        fundEnum: KoloboxFundEnum.koloFlex,
        popUntil: KoloboxFundEnum.koloFlex.getFundPageValue(false));
    BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
    showCustomBottomSheet(const DepositYourKoloboxWidget()).then((value) {
      BlocProvider.of<DashboardBloc>(context)
          .add(ShowEnableBottomScreenEvent());
      isEmpty = false;
      emptyStreamController.add(isEmpty);
      Future.delayed(const Duration(milliseconds: 300), () {
        callTransactions();
      });
    });
  }

  Widget getDataWidget() => Column(
        children: [
          SizedBox(
            width: 180,
            child: Button(
              'Deposit',
              backgroundColor: ColorList.lightBlue3Color,
              textColor: ColorList.primaryColor,
              overlayColor: ColorList.blueColor,
              borderRadius: 24,
              verticalPadding: 10,
              onPressed: () {
                onClickDeposit();
              },
              postIcon: imageDownload,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          StreamBuilder<bool>(
            initialData: isLeft,
            stream: leftRightStreamController.stream,
            builder: (_, snapshot) => Column(
              children: [
                Container(
                  width: double.maxFinite,
                  decoration: BoxDecoration(
                    border:
                        Border.all(color: ColorList.greyLight6Color, width: 1),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  padding: const EdgeInsets.all(5),
                  child: Row(
                    children: [
                      Expanded(
                        child: Button(
                          'Account',
                          borderRadius: 12,
                          verticalPadding: 10,
                          height: 31,
                          backgroundColor: isLeft ? null : ColorList.white,
                          overlayColor: ColorList.blueColor,
                          textStyle: AppStyle.b9SemiBold.copyWith(
                              color: isLeft
                                  ? ColorList.white
                                  : ColorList.blackThirdColor),
                          onPressed: () {
                            isLeft = true;
                            leftRightStreamController.add(isLeft);
                          },
                        ),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Expanded(
                        child: Button(
                          'Transactions',
                          borderRadius: 12,
                          verticalPadding: 10,
                          height: 31,
                          backgroundColor: !isLeft ? null : ColorList.white,
                          overlayColor: ColorList.blueColor,
                          textStyle: AppStyle.b9SemiBold.copyWith(
                              color: !isLeft
                                  ? ColorList.white
                                  : ColorList.blackThirdColor),
                          onPressed: () {
                            isLeft = false;
                            leftRightStreamController.add(isLeft);
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                if (isLeft) ...[
                  getAccountWidget(),
                ] else ...[
                  getTransactionsWidget(),
                ],
              ],
            ),
          ),
        ],
      );

  Widget getTransactionsWidget() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Recent Transaction',
            style:
                AppStyle.b7SemiBold.copyWith(color: ColorList.blackSecondColor),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactions.length,
            itemBuilder: (_, index) => TransactionsItemWidget(
                  transactions: transactions[index],
                  onPressed: () {
                    BlocProvider.of<DashboardBloc>(context)
                        .add(HideDisableBottomScreenEvent());
                    showCustomBottomSheet(
                      DepositedWithdrawalInfoKoloboxWidget(
                        transactions: transactions[index],
                      ),
                      height: 0.75,
                    ).then((value) {
                      BlocProvider.of<DashboardBloc>(context)
                          .add(ShowEnableBottomScreenEvent());
                    });
                  },
                )),
        const SizedBox(
          height: 20,
        ),
        // Button(
        //   'History',
        //   backgroundColor: ColorList.greyLight10Color,
        //   textColor: ColorList.blackSecondColor,
        //   overlayColor: ColorList.blueColor,
        //   borderRadius: 32,
        //   onPressed: () {
        //     comingSoon();
        //   },
        // ),
      ],
    );
  }

  Widget getAccountWidget() {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Available for withdrawal',
            style:
                AppStyle.b7SemiBold.copyWith(color: ColorList.blackSecondColor),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (_, index) => AccountItemWidget(
                  onDetail: () {
                    comingSoon();
                    // BlocProvider.of<DashboardBloc>(context)
                    //     .add(HideDisableBottomScreenEvent());
                    // showCustomBottomSheet(
                    //   DepositedWithdrawalInfoKoloboxWidget(
                    //     koloboxFundEnum: koloboxFundEnum,
                    //   ),
                    //   height: 0.75,
                    // ).then((value) {
                    //   BlocProvider.of<DashboardBloc>(context)
                    //       .add(ShowEnableBottomScreenEvent());
                    // });
                  },
                  onWithdrawal: () {
                    comingSoon();
                    // BlocProvider.of<DashboardBloc>(context)
                    //     .add(HideDisableBottomScreenEvent());
                    // showCustomBottomSheet(
                    //         const WithdrawalSelectionKoloboxWidget())
                    //     .then((value) {
                    //   BlocProvider.of<DashboardBloc>(context)
                    //       .add(ShowEnableBottomScreenEvent());
                    // });
                  },
                )),
        const SizedBox(
          height: 20,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: Text(
            'Balance',
            style:
                AppStyle.b7SemiBold.copyWith(color: ColorList.blackSecondColor),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 5,
            itemBuilder: (_, index) => AccountItemWidget(
                  onDetail: () {},
                  onWithdrawal: () {},
                )),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    leftRightStreamController.close();
    emptyStreamController.close();
  }
}
