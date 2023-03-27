import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../koloflex/presentation/widgets/transactions_item_widget.dart';
import '../../../widgets/deposited_withdrawal_info/deposited_withdrawal_info_kolobox_widget.dart';
import '../../../widgets/kolo_info_widget.dart';

class WalletScreen extends BaseBlocWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  WalletScreenState createState() => WalletScreenState();
}

class WalletScreenState extends BaseBlocWidgetState<WalletScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.white,
        appBar: const NoAppBar(),
        body: Stack(
          children: [
            ScrollConfiguration(
              behavior: NoOverFlowScrollbarBehaviour(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 28, vertical: 14),
                          child: Text(
                            'Wallet',
                            style: AppStyle.b4Bold
                                .copyWith(color: ColorList.blackSecondColor),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<DashboardBloc>(context)
                                .add(HideDisableBottomScreenEvent());
                            showCustomBottomSheet(const KoloInfoWidget())
                                .then((value) {
                              BlocProvider.of<DashboardBloc>(context)
                                  .add(ShowEnableBottomScreenEvent());
                            });
                          },
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 28, vertical: 14),
                            child: Image.asset(
                              imageInfoIcon,
                              width: 24,
                              height: 24,
                              color: ColorList.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: double.maxFinite,
                            padding: const EdgeInsets.all(25),
                            decoration: BoxDecoration(
                              color: ColorList.primaryColor,
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Column(
                              children: [
                                Text(
                                  'Balance',
                                  style: AppStyle.b9SemiBold.copyWith(
                                      color: ColorList.lightBlue12Color),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  '₦ 34,800.00',
                                  style: AppStyle.b3SemiBold
                                      .copyWith(color: ColorList.white),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Recent Transaction',
                            style: AppStyle.b8SemiBold
                                .copyWith(color: ColorList.blackSecondColor),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: 10,
                              itemBuilder: (_, index) => TransactionsItemWidget(
                                    onPressed: () {
                                      BlocProvider.of<DashboardBloc>(context)
                                          .add(HideDisableBottomScreenEvent());
                                      showCustomBottomSheet(
                                              const DepositedWithdrawalInfoKoloboxWidget())
                                          .then((value) {
                                        BlocProvider.of<DashboardBloc>(context)
                                            .add(ShowEnableBottomScreenEvent());
                                      });
                                    },
                                  )),
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
                          const SizedBox(
                            height: dashboardTabHeight + 20,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 28,
                    right: 28,
                    top: 20,
                    bottom: 20 + dashboardTabHeight),
                child: Row(
                  children: [
                    Expanded(
                      child: Button(
                        'Deposit',
                        backgroundColor: ColorList.lightBlue3Color,
                        textColor: ColorList.primaryColor,
                        overlayColor: ColorList.blueColor,
                        borderRadius: 24,
                        verticalPadding: 10,
                        onPressed: () {},
                        postIcon: imageDownload,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Button(
                        'Withdraw',
                        backgroundColor: ColorList.primaryColor,
                        textColor: ColorList.white,
                        overlayColor: ColorList.blueColor,
                        borderRadius: 24,
                        verticalPadding: 10,
                        onPressed: () {},
                        postIcon: imageWithdrawIcon,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
