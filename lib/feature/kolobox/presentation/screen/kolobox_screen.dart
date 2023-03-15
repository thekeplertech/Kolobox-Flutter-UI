import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/home/presentation/widget/deposit_amount_widget.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../home/presentation/widget/home_app_bar_widget.dart';

class KoloboxScreen extends BaseBlocWidget {
  const KoloboxScreen({Key? key}) : super(key: key);

  @override
  KoloboxScreenState createState() => KoloboxScreenState();
}

class KoloboxScreenState extends BaseBlocWidgetState<KoloboxScreen> {
  StreamController<bool> walletBalanceStreamController =
      StreamController<bool>.broadcast();

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
                  amount: '0.00',
                  walletBalanceStreamController: walletBalanceStreamController,
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 28, vertical: 18.52),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'KoloBox',
                        style: AppStyle.b3Bold
                            .copyWith(color: ColorList.blackSecondColor),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        'Total ₦ 4,860,700.00',
                        style: AppStyle.b7SemiBold
                            .copyWith(color: ColorList.primaryColor),
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      const DepositAmountWidget(text: 'Fund my KoloBox'),
                      const SizedBox(
                        height: 24,
                      ),
                      getListWidget(
                          ColorList.koloFlexColor,
                          'Koloflex',
                          ColorList.koloFlexTextColor,
                          '₦ 150,000.00',
                          ColorList.koloFlexTextColor,
                          imageFlexIcon),
                      const SizedBox(
                        height: 18,
                      ),
                      getListWidget(
                          ColorList.koloTargetColor,
                          'Kolotarget',
                          ColorList.primaryColor,
                          '₦ 800,000.00',
                          ColorList.primaryColor,
                          imageTargetIcon),
                      const SizedBox(
                        height: 18,
                      ),
                      getListWidget(
                          ColorList.koloTargetPlusColor,
                          'Kolotarget+',
                          ColorList.blackSecondColor,
                          '₦ 1,200,000.00',
                          ColorList.primaryColor,
                          imageTargetPlusIcon,
                          imageWidth: 96,
                          imageHeight: 82),
                      const SizedBox(
                        height: 18,
                      ),
                      getListWidget(
                          ColorList.koloFamilyColor,
                          'Kolofamily',
                          ColorList.koloFamilyTextColor,
                          '₦ 1,080,000.00',
                          ColorList.primaryColor,
                          imageFamilyIcon),
                      const SizedBox(
                        height: 18,
                      ),
                      getListWidget(
                          ColorList.blackSecondColor,
                          'Kologroup',
                          ColorList.white,
                          '₦ 2,560,000.00',
                          ColorList.koloGroupTextColor,
                          imageGroupIcon),
                      const SizedBox(
                        height: 10,
                      ),
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
