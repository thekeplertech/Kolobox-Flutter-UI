import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/wallet/presentation/bloc/wallet_bloc.dart';
import 'package:kolobox_new_app/feature/wallet/presentation/bloc/wallet_state.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../dashboard/data/models/transactions_data_model.dart';
import '../../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../../home/data/models/wallet_data_model.dart';
import '../../../../koloflex/presentation/widgets/transactions_item_widget.dart';
import '../../../../wallet/presentation/bloc/wallet_event.dart';
import '../../../../widgets/deposited_withdrawal_info/deposited_withdrawal_info_kolobox_widget.dart';
import '../../../../widgets/home_app_bar_widget.dart';

class HistoryScreen extends BaseBlocWidget {
  const HistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  HistoryState createState() => HistoryState();
}

class HistoryState extends BaseBlocWidgetState<HistoryScreen> {
  bool isEmpty = true;
  StreamController<bool> emptyStreamController =
      StreamController<bool>.broadcast();

  WalletDataModel? walletDataModel;
  List<Transactions> transactionHistory = [];

  @override
  void initState() {
    super.initState();
    callWalletHistory();
  }

  callWalletHistory() =>
      BlocProvider.of<WalletBloc>(context).add(GetWalletHistoryEvent());

  @override
  Widget getCustomBloc() {
    return Scaffold(
      backgroundColor: ColorList.white,
      appBar: const NoAppBar(),
      body: BlocListener<WalletBloc, WalletState>(
        listener: (_, state) {
          if (state is GetWalletHistoryState) {
            walletDataModel = state.model;
            transactionHistory = walletDataModel?.transactionHistory ?? [];
            isEmpty = walletDataModel?.walletHistory?.isEmpty ?? true;
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
            const HomeAppBarWidget(
                leftIcon: imageBackArrowIcon, title: 'History'),
            Padding(
              padding: const EdgeInsets.only(
                  left: 28, right: 28, top: 5, bottom: 28),
              child: StreamBuilder<bool>(
                  stream: emptyStreamController.stream,
                  builder: (context, snapshot) {
                    return isEmpty
                        ? Center(
                            child: getEmptyWidget(),
                          )
                        : getListWidget();
                  }),
            ),
            // Padding(
            //   padding: const EdgeInsets.only(
            //       left: 28, right: 28, top: 5, bottom: 28),
            //   child: Column(
            //     crossAxisAlignment: CrossAxisAlignment.start,
            //     children: [
            //       Text(
            //         'July 2022',
            //         style: AppStyle.b7SemiBold
            //             .copyWith(color: ColorList.blackSecondColor),
            //       ),
            //       const SizedBox(
            //         height: 5,
            //       ),
            //       // ListView.builder(
            //       //     shrinkWrap: true,
            //       //     physics: const NeverScrollableScrollPhysics(),
            //       //     itemCount: 5,
            //       //     itemBuilder: (_, index) => TransactionsItemWidget(
            //       //           onPressed: () {
            //       //             BlocProvider.of<DashboardBloc>(context)
            //       //                 .add(HideDisableBottomScreenEvent());
            //       //             showCustomBottomSheet(
            //       //                     const DepositedWithdrawalInfoKoloboxWidget())
            //       //                 .then((value) {
            //       //               BlocProvider.of<DashboardBloc>(context)
            //       //                   .add(ShowEnableBottomScreenEvent());
            //       //             });
            //       //           },
            //       //         )),
            //       const SizedBox(
            //         height: 20,
            //       ),
            //       Text(
            //         'August 2022',
            //         style: AppStyle.b7SemiBold
            //             .copyWith(color: ColorList.blackSecondColor),
            //       ),
            //       const SizedBox(
            //         height: 5,
            //       ),
            //       // ListView.builder(
            //       //     shrinkWrap: true,
            //       //     physics: const NeverScrollableScrollPhysics(),
            //       //     itemCount: 5,
            //       //     itemBuilder: (_, index) => TransactionsItemWidget(
            //       //           onPressed: () {
            //       //             BlocProvider.of<DashboardBloc>(context)
            //       //                 .add(HideDisableBottomScreenEvent());
            //       //             showCustomBottomSheet(
            //       //                     const DepositedWithdrawalInfoKoloboxWidget())
            //       //                 .then((value) {
            //       //               BlocProvider.of<DashboardBloc>(context)
            //       //                   .add(ShowEnableBottomScreenEvent());
            //       //             });
            //       //           },
            //       //         )),
            //     ],
            //   ),
            // ),
          ],
        ),
      ),
    );
  }

  Widget getListWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: transactionHistory.length,
            itemBuilder: (_, index) => TransactionsItemWidget(
                  transactions: transactionHistory[index],
                  onPressed: () {
                    BlocProvider.of<DashboardBloc>(context)
                        .add(HideDisableBottomScreenEvent());
                    showCustomBottomSheet(
                      DepositedWithdrawalInfoKoloboxWidget(
                        transactions: transactionHistory[index],
                      ),
                      height: 0.75,
                    ).then((value) {
                      BlocProvider.of<DashboardBloc>(context)
                          .add(ShowEnableBottomScreenEvent());
                    });
                  },
                )),
        // Text(
        //   'July 2022',
        //   style:
        //       AppStyle.b7SemiBold.copyWith(color: ColorList.blackSecondColor),
        // ),
        // const SizedBox(
        //   height: 5,
        // ),
        // ListView.builder(
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     itemCount: 5,
        //     itemBuilder: (_, index) => TransactionsItemWidget(
        //           onPressed: () {
        //             BlocProvider.of<DashboardBloc>(context)
        //                 .add(HideDisableBottomScreenEvent());
        //             showCustomBottomSheet(
        //                     const DepositedWithdrawalInfoKoloboxWidget())
        //                 .then((value) {
        //               BlocProvider.of<DashboardBloc>(context)
        //                   .add(ShowEnableBottomScreenEvent());
        //             });
        //           },
        //         )),
        // const SizedBox(
        //   height: 20,
        // ),
        // Text(
        //   'August 2022',
        //   style:
        //       AppStyle.b7SemiBold.copyWith(color: ColorList.blackSecondColor),
        // ),
        // const SizedBox(
        //   height: 5,
        // ),
        // ListView.builder(
        //     shrinkWrap: true,
        //     physics: const NeverScrollableScrollPhysics(),
        //     itemCount: 5,
        //     itemBuilder: (_, index) => TransactionsItemWidget(
        //           onPressed: () {
        //             BlocProvider.of<DashboardBloc>(context)
        //                 .add(HideDisableBottomScreenEvent());
        //             showCustomBottomSheet(
        //                     const DepositedWithdrawalInfoKoloboxWidget())
        //                 .then((value) {
        //               BlocProvider.of<DashboardBloc>(context)
        //                   .add(ShowEnableBottomScreenEvent());
        //             });
        //           },
        //         )),
      ],
    );
  }

  Widget getEmptyWidget() {
    return Column(
      children: [
        const SizedBox(
          height: 150,
        ),
        Image.asset(
          imageNoHistoryIcon,
          width: 48,
          height: 48,
        ),
        const SizedBox(
          height: 15,
        ),
        Text(
          'No history yet',
          style: AppStyle.b9Medium.copyWith(color: ColorList.blackThirdColor),
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    emptyStreamController.close();
  }
}
