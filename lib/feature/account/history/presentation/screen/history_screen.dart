import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../widgets/home_app_bar_widget.dart';

class HistoryScreen extends BaseBlocWidget {
  const HistoryScreen({
    Key? key,
  }) : super(key: key);

  @override
  HistoryState createState() => HistoryState();
}

class HistoryState extends BaseBlocWidgetState<HistoryScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() {
    return Scaffold(
      backgroundColor: ColorList.white,
      appBar: const NoAppBar(),
      body: ScrollConfiguration(
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
                child: Center(
                  child: getEmptyWidget(),
                ),
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
      ),
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
  }
}
