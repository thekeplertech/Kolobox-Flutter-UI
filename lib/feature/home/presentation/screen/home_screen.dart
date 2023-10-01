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

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../core/constants/image_constants.dart';
import '../../../../core/ui/widgets/button.dart';
import '../../../dashboard/presentation/bloc/dashboard_bloc.dart';
import '../../../dashboard/presentation/bloc/dashboard_event.dart';
import '../../../widgets/fund_your_kolo_box/fund_your_kolobox_widget.dart';
import '../../../widgets/inherited_state_container.dart';
import '../../data/models/dashboard_amount_model.dart';
import '../../data/models/wallet_data_model.dart';

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
                // leftIcon: imageDashboardIcon,
                // rightIcon: imageNotification,
                // onLeftPressed: () => comingSoon(),
                // onRightPressed: () {
                //   BlocProvider.of<DashboardBloc>(context)
                //       .add(HideDisableBottomScreenEvent());
                //   navigatePush(context, const NotificationsPage())
                //       .then((value) {
                //     BlocProvider.of<DashboardBloc>(context)
                //         .add(ShowEnableBottomScreenEvent());
                //   });
                // },
              ),
              getHeaderWidget(),
              Padding(
                padding: const EdgeInsets.only(
                  left: 28,
                  right: 28,
                  bottom: 12,
                ),
                child: Text(
                  'Products',
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
                        child: ProductItemWidget(
                          title: 'KOLO FLEX',
                          text:
                              'This is an unlocked plan that allows flexibility and liquidity of funds. Tenor: Investment is made for a period of 30 days. . Access: Withdrawal can be made anytime subsequently. . Interest rate: 6% annual percentage rate (APR)',
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: ProductItemWidget(
                          title: 'KOLO TARGET',
                          text:
                              'This is a locked plan aimed at individuals trying to save towards a target – a car, rent, school fees etc. . Tenor: return is expected on this class of investment over a period of 3 Months (90days). . Access: Withdrawal is not allowed till due date. . Interest rate: 8% annual percentage rate (APR).',
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: ProductItemWidget(
                          title: 'KOLO GROUP',
                          text:
                              'This is a locked collective plan where customers can now invest as a group, saving towards better financial opportunities e.g. cooperative society, association etc. . How to Use: A user will serve as the Administrator; set up, name the group, invite members and recommend amount and frequency. . Tenor: A fixed return is expected on this investment class over 6 months (180 days). . Access: Withdrawal is not allowed till the due date. . Interest rate: 10% annual percentage rate (APR)',
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: ProductItemWidget(
                          title: 'KOLO FAMILY',
                          text:
                              'This is a locked collective plan where customers can now invest as a group, saving towards better financial opportunities e.g. cooperative society, association etc. . Tenor: A fixed return is expected on this investment class over 6 months (180 days). . Access: Withdrawal is not allowed till the due date. . Interest rate: 10% annual percentage rate (APR)',
                        ),
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
                  'Testimony',
                  style: AppStyle.b7SemiBold
                      .copyWith(color: ColorList.greyLight2Color),
                ),
              ),
              SizedBox(
                height: 180,
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
                          child: NewsItemWidget(
                            icon: testimonyOneIcon,
                            title: 'Titi Oyewole',
                            text:
                                'I started using Kolobox last month to save towards my tour in December and i am astonished at how much I have saved within that short period of time, now i am rest assured my tour will happen and this is all thanks to Kolobox.',
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: NewsItemWidget(
                            icon: testimonyTwoIcon,
                            title: 'Olamide Komolafe',
                            text:
                                'Kolobox has made me so fond of investment and has helped curtail my excessive spending habit.With it I can set any target and the best part is i get an interest of 12% APR with KoloTarget. It is such a great App and is super easy to use with no hidden charges.I have no regret joining them.',
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: NewsItemWidget(
                            icon: testimonyThreeIcon,
                            title: 'Olufunmilayo Oni',
                            text:
                                'Having my fitness store and being a personal trainer i have so many tall dreams but my life became easier since i got the plug \\"KoloboxNG\\" that has helped me save a lot to achieve most of it. Now i save and get interest accrued,withdraw,buy new stock and reinvest again.',
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: NewsItemWidget(
                            icon: testimonyFourIcon,
                            title: 'Yetunde Olawale',
                            text:
                                'For a long time i used to love doing "Ajo" -The traditional way of saving but i lost interest because there were so many defaults and risk involved.And at the end of this i was frustrated and often times hurt because of late payments and backlog from some members of the contribution.Then came my ray of hope in the person of my bestfriend,Oju who hinted me about this new hip app that i can use for saving and is so easy because with just a couple of clicks i am done with my transactions.The best part is after the initial payment into my E-Wallet my debit card automatically is synced with my account and i don\'t have to go through the rigour of putting that in everytime i have to save.I could go on and on but the truth is my makeup business and i are grateful we decided to do it the Kolobox way.You should try it too!!!',
                          ),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        Padding(
                          padding: EdgeInsets.only(bottom: 2),
                          child: NewsItemWidget(
                            icon: testimonyFiveIcon,
                            title: 'Tobi Sadiq',
                            text:
                                'I have been looking for a simple and easy to use platform that is not so classist and is highly flexible, then my cousin made mention of koloboxng. I tried it out and found out not only does it not add irrelevant charges but like the name implies it is nostalgic and takes me back to my childhood way of saving in a wooden box.',
                          ),
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
                        child: LearnItemWidget(
                          title: 'Where are my investments going',
                          url: 'https://www.youtube.com/embed/ZzX_bqz2Vyw',
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: LearnItemWidget(
                          title: 'How Do I Sign Up for KOLOBOX',
                          url: 'https://www.youtube.com/embed/GDF1MGe3cgk',
                        ),
                      ),
                      SizedBox(
                        width: 16,
                      ),
                      Padding(
                        padding: EdgeInsets.only(bottom: 2),
                        child: LearnItemWidget(
                          title: 'How Does KOLOBOX work',
                          url: 'https://www.youtube.com/embed/dIZX5x1_yNY',
                        ),
                      ),
                      // SizedBox(
                      //   width: 16,
                      // ),
                      // Padding(
                      //   padding: EdgeInsets.only(bottom: 2),
                      //   child: LearnItemWidget(
                      //     title: 'Why KOLOBOX?',
                      //     url: 'https://www.youtube.com/embed/NZyiZRbG90w',
                      //   ),
                      // ),
                      SizedBox(
                        width: 28,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              // getReferAndEarnWidget(),
            ],
          ),
        ),
      );

  Widget getHeaderWidget() => Padding(
        padding: const EdgeInsets.only(
          top: 10,
          left: 28,
          right: 28,
          bottom: 25,
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
                  onPressed: () {
                    StateContainer.of(context)
                        .openFundMyKoloBox(isFundYourKoloBox: true);
                    BlocProvider.of<DashboardBloc>(context)
                        .add(HideDisableBottomScreenEvent());
                    showCustomBottomSheet(const FundYourKoloboxWidget())
                        .then((value) {
                      BlocProvider.of<DashboardBloc>(context)
                          .add(ShowEnableBottomScreenEvent());
                      if (StateContainer.of(context).isSuccessful) {
                        //   childStreamController.add(true);
                        callProductsAPI();
                      }
                      StateContainer.of(context).clearData();
                    });
                  },
                  postIcon: imageDownload,
                ),
              ),
            ),
            // const SizedBox(
            //   height: 23,
            // ),
            // const WelcomeToKoloboxWidget(),
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
    // StateContainer.of(context).openFundMyKoloBox(isWallet: true);
    // BlocProvider.of<DashboardBloc>(context).add(HideDisableBottomScreenEvent());
    // showCustomBottomSheet(const DepositYourKoloboxWidget()).then((value) {
    //   BlocProvider.of<DashboardBloc>(context)
    //       .add(ShowEnableBottomScreenEvent());
    //   if (StateContainer.of(context).isSuccessful) {
    //     callProductsAPI();
    //   }
    //   StateContainer.of(context).clearData();
    // });
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
