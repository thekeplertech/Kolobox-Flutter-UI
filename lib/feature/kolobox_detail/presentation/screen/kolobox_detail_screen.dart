import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:kolobox_new_app/feature/kolobox_detail/presentation/widgets/account_item_widget.dart';
import 'package:kolobox_new_app/feature/widgets/deposit_summary_widget.dart';
import 'package:kolobox_new_app/feature/widgets/kolo_flex_info_widget.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../home/presentation/widget/deposit_amount_widget.dart';
import '../../../widgets/home_app_bar_widget.dart';

class KoloboxDetailScreen extends BaseBlocWidget {
  const KoloboxDetailScreen({Key? key}) : super(key: key);

  @override
  KoloboxDetailScreenState createState() => KoloboxDetailScreenState();
}

class KoloboxDetailScreenState
    extends BaseBlocWidgetState<KoloboxDetailScreen> {
  StreamController<bool> walletBalanceStreamController =
      StreamController<bool>.broadcast();

  bool isEmpty = false;
  bool isAccount = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.white,
        appBar: const NoAppBar(),
        body: ScrollConfiguration(
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
                    showCustomBottomSheet(const KoloFlexInfoWidget())
                        .then((value) {
                      BlocProvider.of<DashboardBloc>(context)
                          .add(ShowEnableBottomScreenEvent());
                    });
                  },
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 18.52),
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
                        '₦ 150,000.00',
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
                              'Interest (6% p.a)',
                              style: AppStyle.b7SemiBold
                                  .copyWith(color: ColorList.blackSecondColor),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '₦ 540.00',
                                  style: AppStyle.b7Bold.copyWith(
                                      color: ColorList.koloFlexTextColor),
                                ),
                                const SizedBox(
                                  height: 3,
                                ),
                                Text(
                                  'Interest in 30 days',
                                  style: AppStyle.b9Medium.copyWith(
                                      color: ColorList.blackThirdColor),
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
                        height: 25,
                      ),
                      if (isEmpty) ...[
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
                        Image.asset(imageKoloflexDetailIcon),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          'You have not performed any transaction',
                          style: AppStyle.b8Medium
                              .copyWith(color: ColorList.blackThirdColor),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        DepositAmountWidget(
                            width: 180,
                            onPressed: () {
                              BlocProvider.of<DashboardBloc>(context)
                                  .add(HideDisableBottomScreenEvent());
                              showCustomBottomSheet(const DepositAmountWidget())
                                  .then((value) {
                                BlocProvider.of<DashboardBloc>(context)
                                    .add(ShowEnableBottomScreenEvent());
                              });
                            }),
                        const SizedBox(
                          height: 20,
                        ),
                      ] else ...[
                        DepositAmountWidget(
                          backColor: ColorList.koloFlexColor,
                          width: 180,
                          onPressed: () {
                            BlocProvider.of<DashboardBloc>(context)
                                .add(HideDisableBottomScreenEvent());
                            showCustomBottomSheet(const DepositSummaryWidget())
                                .then((value) {
                              BlocProvider.of<DashboardBloc>(context)
                                  .add(ShowEnableBottomScreenEvent());
                            });
                          },
                        ),
                        const SizedBox(
                          height: 24,
                        ),
                        Container(
                          width: double.maxFinite,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: ColorList.greyLight6Color, width: 1),
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
                                  backgroundColor:
                                      isAccount ? null : ColorList.white,
                                  overlayColor: ColorList.blueColor,
                                  textStyle: AppStyle.b9SemiBold.copyWith(
                                      color: isAccount
                                          ? ColorList.white
                                          : ColorList.blackThirdColor),
                                  onPressed: () {
                                    isAccount = true;
                                    setState(() {});
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
                                  backgroundColor:
                                      !isAccount ? null : ColorList.white,
                                  overlayColor: ColorList.blueColor,
                                  textStyle: AppStyle.b9SemiBold.copyWith(
                                      color: !isAccount
                                          ? ColorList.white
                                          : ColorList.blackThirdColor),
                                  onPressed: () {
                                    isAccount = false;
                                    setState(() {});
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        if (false) ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Available for withdrawal',
                              style: AppStyle.b7SemiBold
                                  .copyWith(color: ColorList.blackSecondColor),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (_, index) =>
                                  const AccountItemWidget()),
                          const SizedBox(
                            height: 20,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Balance',
                              style: AppStyle.b7SemiBold
                                  .copyWith(color: ColorList.blackSecondColor),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 5,
                              itemBuilder: (_, index) =>
                                  const AccountItemWidget()),
                        ] else ...[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              'Recent Transaction',
                              style: AppStyle.b7SemiBold
                                  .copyWith(color: ColorList.blackSecondColor),
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 10,
                              itemBuilder: (_, index) =>
                                  const AccountItemWidget()),
                          const SizedBox(
                            height: 20,
                          ),
                          Button(
                            'History',
                            backgroundColor: ColorList.greyLight10Color,
                            textColor: ColorList.blackSecondColor,
                            overlayColor: ColorList.blueColor,
                            borderRadius: 32,
                            onPressed: () {
                              comingSoon();
                            },
                          ),
                        ],
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  Widget getListWidget(
    Color backgroundColor,
    String title,
    Color titleColor,
    String amount,
    Color amountColor,
    String icon, {
    double imageWidth = 78,
    double imageHeight = 78,
  }) =>
      GestureDetector(
        onTap: () async {
          // BlocProvider.of<DashboardBloc>(context)
          //     .add(HideDisableBottomScreenEvent());
          // navigatePush(context, const TransactionSuccessfulPage())
          //     .then((value) {
          //   BlocProvider.of<DashboardBloc>(context)
          //       .add(ShowEnableBottomScreenEvent());
          // });
        },
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: backgroundColor,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 21, vertical: 22),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: AppStyle.b3Bold.copyWith(color: titleColor),
                    ),
                    Text(
                      amount,
                      style: AppStyle.b7SemiBold.copyWith(color: amountColor),
                    ),
                  ],
                ),
              ),
              Image.asset(
                icon,
                width: imageWidth,
                height: imageHeight,
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    walletBalanceStreamController.close();
  }
}
