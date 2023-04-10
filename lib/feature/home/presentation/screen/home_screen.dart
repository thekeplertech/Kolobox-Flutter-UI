import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/ui/style/app_style.dart';
import 'package:kolobox_new_app/core/ui/widgets/currency_text_input_formatter.dart';
import 'package:kolobox_new_app/core/ui/widgets/indicator_widget.dart';
import 'package:kolobox_new_app/core/ui/widgets/no_app_bar.dart';
import 'package:kolobox_new_app/core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import 'package:kolobox_new_app/feature/home/presentation/bloc/home_bloc.dart';
import 'package:kolobox_new_app/feature/home/presentation/bloc/home_event.dart';
import 'package:kolobox_new_app/feature/home/presentation/bloc/home_state.dart';
import 'package:kolobox_new_app/feature/home/presentation/widget/explore_item_widget.dart';
import 'package:kolobox_new_app/feature/home/presentation/widget/learn_item_widget.dart';
import 'package:kolobox_new_app/feature/home/presentation/widget/news_item_widget.dart';
import 'package:kolobox_new_app/feature/home/presentation/widget/refer_and_earn_widget.dart';
import 'package:kolobox_new_app/feature/widgets/home_app_bar_widget.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../notifications/presentation/notifications_page.dart';
import '../../../widgets/deposit/deposit_your_kolobox_widget.dart';
import '../../../widgets/inherited_state_container.dart';
import '../../data/models/dashboard_amount_model.dart';
import '../../data/models/wallet_data_model.dart';
import '../widget/welcome_to_kolobox_widget.dart';

class HomeScreen extends BaseBlocWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends BaseBlocWidgetState<HomeScreen> {
  StreamController<int> pageIndicatorStreamController =
      StreamController<int>.broadcast();

  StreamController<bool> walletBalanceStreamController =
      StreamController<bool>.broadcast();
  StreamController<bool> dashboardAmountStreamController =
      StreamController<bool>.broadcast();

  int pageIndicatorPosition = 0;

  PageController pageController = PageController(initialPage: 0);

  UserWallet? userWallet;
  List<TransactionHistory> walletHistory = [];
  List<DashboardAmountModel> dashboardAmountModels = [
    DashboardAmountModel(
      title: 'Total Assets',
      amount: '0.0',
      backColor: ColorList.primaryColor,
    )
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageIndicatorPosition);
    // callWalletAPI();
  }

  callProductsAPI() =>
      BlocProvider.of<HomeBloc>(context).add(CallProductEvent());

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.white,
        appBar: const NoAppBar(),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (_, state) {
            if (state is ClickOnHomeState) {
              callProductsAPI();
            } else if (state is CallProductState) {
              dashboardAmountModels = state.models;
              dashboardAmountStreamController.add(true);
            } else if (state is CallWalletState) {
              userWallet = state.model.userWallet;
              List<dynamic> list = state.model.transactionHistory ?? [];
              for (int i = 0; i < 10; i++) {
                walletHistory.add(list[i]);
              }
              walletBalanceStreamController.add(true);
              dashboardAmountStreamController.add(true);
            }
          },
          child: getChildWidget(),
        ),
      );

  Widget getChildWidget() => ScrollConfiguration(
        behavior: NoOverFlowScrollbarBehaviour(),
        child: SingleChildScrollView(
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
                  navigatePush(context, const NotificationsPage())
                      .then((value) {
                    BlocProvider.of<DashboardBloc>(context)
                        .add(ShowEnableBottomScreenEvent());
                  });
                },
              ),
              getHeaderWidget(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 28,
                  right: 28,
                  bottom: 12,
                ),
                child: Text(
                  'Explore',
                  style: AppStyle.b7SemiBold
                      .copyWith(color: ColorList.greyLight2Color),
                ),
              ),
              SizedBox(
                height: 130,
                child: ScrollConfiguration(
                  behavior: NoOverFlowScrollbarBehaviour(),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      SizedBox(
                        width: 28,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: ExploreItemWidget(),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: ExploreItemWidget(),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: ExploreItemWidget(),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: ExploreItemWidget(),
                      ),
                      SizedBox(
                        width: 28,
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 28,
                  right: 28,
                  bottom: 12,
                ),
                child: Text(
                  'News',
                  style: AppStyle.b7SemiBold
                      .copyWith(color: ColorList.greyLight2Color),
                ),
              ),
              SizedBox(
                height: 200,
                child: ScrollConfiguration(
                  behavior: NoOverFlowScrollbarBehaviour(),
                  child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        SizedBox(
                          width: 28,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: NewsItemWidget(),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: NewsItemWidget(),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: NewsItemWidget(),
                        ),
                        SizedBox(
                          width: 28,
                        ),
                      ]),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 40,
                  left: 28,
                  right: 28,
                  bottom: 12,
                ),
                child: Text(
                  'Learn',
                  style: AppStyle.b7SemiBold
                      .copyWith(color: ColorList.greyLight2Color),
                ),
              ),
              SizedBox(
                height: 175,
                child: ScrollConfiguration(
                  behavior: NoOverFlowScrollbarBehaviour(),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: const [
                      SizedBox(
                        width: 28,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: LearnItemWidget(),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: LearnItemWidget(),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: LearnItemWidget(),
                      ),
                      SizedBox(
                        width: 28,
                      ),
                    ],
                  ),
                ),
              ),
              getReferAndEarnWidget(),
            ],
          ),
        ),
      );

  Widget getHeaderWidget() => Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 28,
          right: 28,
          bottom: 45,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi ${prefHelper?.getLoginResponseModel().firstname} ${prefHelper?.getLoginResponseModel().lastname}',
              style:
                  AppStyle.b3Bold.copyWith(color: ColorList.blackSecondColor),
            ),
            const SizedBox(
              height: 14,
            ),
            getKoloboxAmountWidget(),
            const SizedBox(
              height: 18,
            ),
            Center(
              child: SizedBox(
                width: 129,
                child: Button(
                  'Deposit',
                  backgroundColor: ColorList.lightBlue3Color,
                  textColor: ColorList.primaryColor,
                  overlayColor: ColorList.blueColor,
                  borderRadius: 24,
                  verticalPadding: 10,
                  onPressed: () => comingSoon(),
                  postIcon: imageDownload,
                ),
              ),
            ),
            const SizedBox(
              height: 23,
            ),
            const WelcomeToKoloboxWidget(),
          ],
        ),
      );

  Widget getKoloboxAmountWidget() => StreamBuilder<bool>(
      stream: dashboardAmountStreamController.stream,
      builder: (context, snapshot) {
        return Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: ColorList.primaryColor,
          ),
          padding: const EdgeInsets.only(
            top: 25,
            bottom: 12,
            left: 20,
            right: 20,
          ),
          child: Column(
            children: [
              SizedBox(
                height: 80,
                child: PageView.builder(
                    controller: pageController,
                    onPageChanged: (int page) {
                      pageIndicatorPosition = page;
                      dashboardAmountStreamController.add(true);
                    },
                    itemCount: dashboardAmountModels.length,
                    itemBuilder: (_, index) {
                      return Column(
                        children: [
                          Text(
                            dashboardAmountModels[index].title,
                            style: AppStyle.b9SemiBold
                                .copyWith(color: ColorList.white),
                          ),
                          const SizedBox(
                            height: 11,
                          ),
                          Text(
                            CurrencyTextInputFormatter.formatAmount(
                                dashboardAmountModels[index].amount),
                            style: AppStyle.b4SemiBold
                                .copyWith(color: ColorList.white),
                          ),
                        ],
                      );
                    }),
              ),
              IndicatorWidget<DashboardAmountModel>(
                list: dashboardAmountModels,
                streamController: pageIndicatorStreamController,
                initialPosition: pageIndicatorPosition,
              ),
            ],
          ),
        );
      });

  Widget getReferAndEarnWidget() => const Padding(
        padding: EdgeInsets.only(top: 40, left: 28, right: 28, bottom: 30),
        child: ReferAndEarnWidget(),
      );

  void onClickDeposit() {
    StateContainer.of(context).openFundMyKoloBox(isWallet: true);
    BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
    showCustomBottomSheet(const DepositYourKoloboxWidget()).then((value) {
      BlocProvider.of<DashboardBloc>(context)
          .add(ShowEnableBottomScreenEvent());
      if (StateContainer.of(context).isSuccessful) {
        callProductsAPI();
      }
      StateContainer.of(context).clearData();
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    pageIndicatorStreamController.close();
    walletBalanceStreamController.close();
    dashboardAmountStreamController.close();
  }
}
