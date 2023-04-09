import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/earnings_request_model.dart';
import 'package:kolobox_new_app/feature/kolobox/presentation/bloc/kolobox_bloc.dart';
import 'package:kolobox_new_app/feature/kolobox/presentation/bloc/kolobox_state.dart';
import 'package:kolobox_new_app/feature/kolofamily/presentation/kolo_family_page.dart';
import 'package:kolobox_new_app/feature/kologroup/presentation/kolo_group_page.dart';
import 'package:kolobox_new_app/feature/kolotarget/presentation/kolo_target_page.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../../core/ui/widgets/currency_text_input_formatter.dart';
import '../../../../core/ui/widgets/no_app_bar.dart';
import '../../../../core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import '../../../../routes/routes.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../koloflex/presentation/kolo_flex_page.dart';
import '../../../notifications/presentation/notifications_page.dart';
import '../../../widgets/fund_your_kolo_box/fund_your_kolobox_widget.dart';
import '../../../widgets/home_app_bar_widget.dart';
import '../../../widgets/inherited_state_container.dart';
import '../bloc/kolobox_event.dart';

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
          child: BlocListener<KoloboxBloc, KoloboxState>(
            listener: (_, state) {},
            child: getChild(),
          ),
        ),
      );

  Widget getChild() => SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeAppBarWidget(
              amount: CurrencyTextInputFormatter.formatAmount(
                  prefHelper?.getProfileDataModel().wallet?.accountBalance,
                  isSymbol: false),
              walletBalanceStreamController: walletBalanceStreamController,
              leftIcon: imageDashboardIcon,
              rightIcon: imageNotification,
              onLeftPressed: () => comingSoon(),
              onRightPressed: () {
                BlocProvider.of<DashboardBloc>(context)
                    .add(HideDisableBottomScreenEvent());
                navigatePush(context, const NotificationsPage()).then((value) {
                  BlocProvider.of<DashboardBloc>(context)
                      .add(ShowEnableBottomScreenEvent());
                });
              },
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 28, vertical: 18.52),
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
                    'Total ${CurrencyTextInputFormatter.formatAmount(prefHelper?.getProfileDataModel().wallet?.withDrawableFunds?.toString() ?? '0.0')}',
                    style: AppStyle.b7SemiBold
                        .copyWith(color: ColorList.primaryColor),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  SizedBox(
                    width: 200,
                    child: Button(
                      'Fund my KoloBox',
                      backgroundColor: ColorList.lightBlue3Color,
                      textColor: ColorList.primaryColor,
                      overlayColor: ColorList.blueColor,
                      borderRadius: 24,
                      verticalPadding: 10,
                      onPressed: () {
                        StateContainer.of(context).isFromFundMyKoloBox = true;
                        BlocProvider.of<DashboardBloc>(context)
                            .add(HideDisableBottomScreenEvent());
                        showCustomBottomSheet(const FundYourKoloboxWidget())
                            .then((value) {
                          BlocProvider.of<DashboardBloc>(context)
                              .add(ShowEnableBottomScreenEvent());
                        });
                      },
                      postIcon: imageDownload,
                    ),
                  ),
                  const SizedBox(
                    height: 24,
                  ),
                  getListWidget(
                    KoloboxFundEnum.koloFlex,
                    CurrencyTextInputFormatter.formatAmount(
                        KoloboxFundEnum.koloFlex.getDepositAmountValue()),
                    ColorList.koloFlexTextColor,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  getListWidget(
                    KoloboxFundEnum.koloTarget,
                    CurrencyTextInputFormatter.formatAmount(
                        KoloboxFundEnum.koloTarget.getDepositAmountValue()),
                    ColorList.primaryColor,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  getListWidget(
                    KoloboxFundEnum.koloTargetPlus,
                    CurrencyTextInputFormatter.formatAmount(
                        KoloboxFundEnum.koloTargetPlus.getDepositAmountValue()),
                    ColorList.primaryColor,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  getListWidget(
                    KoloboxFundEnum.koloFamily,
                    CurrencyTextInputFormatter.formatAmount(
                        KoloboxFundEnum.koloFamily.getDepositAmountValue()),
                    ColorList.primaryColor,
                  ),
                  const SizedBox(
                    height: 18,
                  ),
                  getListWidget(
                    KoloboxFundEnum.koloGroup,
                    CurrencyTextInputFormatter.formatAmount(
                        KoloboxFundEnum.koloGroup.getDepositAmountValue()),
                    ColorList.koloGroupTextColor,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ],
        ),
      );

  Widget getListWidget(
    KoloboxFundEnum fundEnum,
    String amount,
    Color amountColor,
  ) =>
      GestureDetector(
        onTap: () {
          StateContainer.of(context).isFromFundMyKoloBox = false;
          StateContainer.of(context).koloboxFundEnum = fundEnum;

          BlocProvider.of<KoloboxBloc>(context).add(CallEarningsEvent(
            model: EarningsRequestModel(userProductId: fundEnum.getProductId),
          ));
          return;
          switch (fundEnum) {
            case KoloboxFundEnum.koloFlex:
              navigatePush(context, const KoloFlexPage());
              break;
            case KoloboxFundEnum.koloTarget:
              navigatePush(context, const KoloTargetPage());
              break;
            case KoloboxFundEnum.koloTargetPlus:
              comingSoon();
              break;
            case KoloboxFundEnum.koloFamily:
              navigatePush(context, const KoloFamilyPage());
              break;
            case KoloboxFundEnum.koloGroup:
              navigatePush(context, const KoloGroupPage());
              break;
          }
        },
        child: Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            color: fundEnum.getFundBackColorValue,
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
                      fundEnum.getFundValue,
                      style: AppStyle.b3Bold
                          .copyWith(color: fundEnum.getFundTextColorValue),
                    ),
                    Text(
                      amount,
                      style: AppStyle.b7SemiBold.copyWith(color: amountColor),
                    ),
                  ],
                ),
              ),
              fundEnum.isPhotoEnabledAsIcon
                  ? Icon(
                      fundEnum.getFundIconValue,
                      size: 78,
                      color: fundEnum.getFundIconColorValue,
                    )
                  : Image.asset(
                      fundEnum.getFundImageValue,
                      width: 96,
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
