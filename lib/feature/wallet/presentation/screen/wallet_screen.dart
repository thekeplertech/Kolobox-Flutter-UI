import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/currency_text_input_formatter.dart';
import 'package:kolobox_new_app/feature/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:kolobox_new_app/feature/wallet/presentation/bloc/wallet_event.dart';
import 'package:kolobox_new_app/feature/wallet/presentation/bloc/wallet_state.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/constants/app_constants.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/enums/kolobox_fund_enum.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../widgets/kolo_info_widget.dart';
import '../../../widgets/withdrawal/withdrawal_to_bank_kolobox_widget_page.dart';

class WalletScreen extends BaseBlocWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  WalletScreenState createState() => WalletScreenState();
}

class WalletScreenState extends BaseBlocWidgetState<WalletScreen> {
  StreamController<bool> emptyStreamController =
      StreamController<bool>.broadcast();

  // WalletDataModel? walletDataModel;

  @override
  void initState() {
    super.initState();
  }

  callProfile() => BlocProvider.of<WalletBloc>(context).add(GetProfileEvent());

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.white,
        appBar: const NoAppBar(),
        body: Stack(
          children: [
            BlocListener<WalletBloc, WalletState>(
              listener: (_, state) {
                if (state is ClickOnWalletState) {
                  callProfile();
                } else if (state is GetProfileState) {
                  emptyStreamController.add(true);
                }
              },
              child: getChild(),
            ),
            // StreamBuilder<bool>(
            //     initialData: isEmpty,
            //     stream: emptyStreamController.stream,
            //     builder: (_, __) =>
            //         isEmpty ? const SizedBox() : getBackground()),
          ],
        ),
      );

  Widget getBackground() => Align(
        alignment: Alignment.bottomCenter,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 28, right: 28, top: 20, bottom: 20 + dashboardTabHeight),
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
      );

  ScrollConfiguration getChild() {
    return ScrollConfiguration(
      behavior: NoOverFlowScrollbarBehaviour(),
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 28, vertical: 14),
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
                    showCustomBottomSheet(const KoloInfoWidget(
                      isWallet: true,
                    )).then((value) {
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
                          'Unlocked Funds',
                          style: AppStyle.b9SemiBold
                              .copyWith(color: ColorList.lightBlue12Color),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<bool>(
                            stream: emptyStreamController.stream,
                            builder: (context, snapshot) => Text(
                                  CurrencyTextInputFormatter.formatAmount(
                                      prefHelper
                                          ?.getProfileDataModel()
                                          .wallet
                                          ?.accountBalance),
                                  style: AppStyle.b3SemiBold
                                      .copyWith(color: ColorList.white),
                                )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                          'Locked Funds',
                          style: AppStyle.b9SemiBold
                              .copyWith(color: ColorList.lightBlue12Color),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<bool>(
                            stream: emptyStreamController.stream,
                            builder: (context, snapshot) => Text(
                                  CurrencyTextInputFormatter.formatAmount(
                                      prefHelper
                                          ?.getProfileDataModel()
                                          .wallet
                                          ?.bookBalance),
                                  style: AppStyle.b3SemiBold
                                      .copyWith(color: ColorList.white),
                                )),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
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
                          'Withdrawable Funds',
                          style: AppStyle.b9SemiBold
                              .copyWith(color: ColorList.lightBlue12Color),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        StreamBuilder<bool>(
                            stream: emptyStreamController.stream,
                            builder: (context, snapshot) => Text(
                                  CurrencyTextInputFormatter.formatAmountDouble(
                                      prefHelper
                                          ?.getProfileDataModel()
                                          .wallet
                                          ?.withDrawableFunds),
                                  style: AppStyle.b3SemiBold
                                      .copyWith(color: ColorList.white),
                                )),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 150,
                        child: Button(
                          'Withdraw',
                          backgroundColor: ColorList.primaryColor,
                          textColor: ColorList.white,
                          overlayColor: ColorList.blueColor,
                          borderRadius: 24,
                          verticalPadding: 10,
                          onPressed: () {
                            BlocProvider.of<DashboardBloc>(context)
                                .add(HideDisableBottomScreenEvent());
                            showCustomBottomSheet(
                                const WithdrawalToBankKoloboxWidgetPage(
                              koloboxFundEnum: KoloboxFundEnum.koloFlex,
                              popUntil: '/',
                            )).then((value) {
                              BlocProvider.of<DashboardBloc>(context)
                                  .add(ShowEnableBottomScreenEvent());
                              emptyStreamController.add(true);
                            });
                          },
                          postIcon: imageWithdrawIcon,
                        ),
                      ),
                    ],
                  ),
                  // Text(
                  //   'Recent Transaction',
                  //   style: AppStyle.b8SemiBold
                  //       .copyWith(color: ColorList.blackSecondColor),
                  // ),
                  // const SizedBox(
                  //   height: 8,
                  // ),
                  // StreamBuilder<bool>(
                  //     initialData: isEmpty,
                  //     stream: emptyStreamController.stream,
                  //     builder: (_, __) {
                  //       return isEmpty
                  //           ? Center(child: getEmptyWidget())
                  //           : getDataWidget();
                  //     }),
                  // const SizedBox(
                  //   height: 20,
                  // ),
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
                  const SizedBox(
                    height: dashboardTabHeight + 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget getDataWidget() => Text('Data');

  /*ListView.builder(
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
          ));*/

  // Widget getEmptyWidget() => Column(
  //       crossAxisAlignment: CrossAxisAlignment.center,
  //       children: [
  //         const SizedBox(
  //           height: 120,
  //         ),
  //         Image.asset(imageWalletSuccessIconSelected),
  //         const SizedBox(
  //           height: 10,
  //         ),
  //         Text('You have not performed any transaction',
  //             style:
  //                 AppStyle.b9Medium.copyWith(color: ColorList.blackThirdColor)),
  //         const SizedBox(
  //           height: 20,
  //         ),
  //         SizedBox(
  //           width: 140,
  //           child: Button(
  //             'Deposit',
  //             backgroundColor: ColorList.lightBlue3Color,
  //             textColor: ColorList.primaryColor,
  //             overlayColor: ColorList.blueColor,
  //             borderRadius: 24,
  //             verticalPadding: 10,
  //             onPressed: () => comingSoon(),
  //             postIcon: imageDownload,
  //           ),
  //         ),
  //       ],
  //     );

  @override
  void dispose() {
    super.dispose();
    emptyStreamController.close();
  }
}
