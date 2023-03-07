import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/ui/widgets/no_overflow_scrollbar_behaviour.dart';
import 'package:kolobox_new_app/feature/home/data/models/kolobox_amount_model.dart';
import 'package:kolobox_new_app/feature/home/presentation/widget/deposit_amount_widget.dart';
import 'package:kolobox_new_app/feature/home/presentation/widget/explore_item_widget.dart';
import 'package:kolobox_new_app/feature/home/presentation/widget/home_app_bar_widget.dart';
import 'package:kolobox_new_app/feature/home/presentation/widget/learn_item_widget.dart';
import 'package:kolobox_new_app/feature/home/presentation/widget/news_item_widget.dart';
import 'package:kolobox_new_app/feature/home/presentation/widget/refer_and_earn_widget.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../widget/welcome_to_kolobox_widget.dart';

class HomeScreen extends BaseBlocWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends BaseBlocWidgetState<HomeScreen> {
  StreamController<int> pageIndicatorStreamController =
      StreamController<int>.broadcast();

  int pageIndicatorPosition = 0;

  PageController pageController = PageController(initialPage: 0);

  List<KoloboxAmountModel> koloboxAmountModels = [
    KoloboxAmountModel(title: 'Total Assets', amount: '1,200,000.00'),
    KoloboxAmountModel(title: 'Koloflex', amount: '80,500.00'),
    KoloboxAmountModel(title: 'Kolotarget', amount: '200,000.00'),
    KoloboxAmountModel(title: 'Kolotarget plus', amount: '285,000.00'),
    KoloboxAmountModel(title: 'Kolofamily', amount: '450,000.00'),
    KoloboxAmountModel(title: 'Kologroup', amount: '332,800.00'),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageIndicatorPosition);
  }

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.white,
        appBar: getAppBar(),
        body: getChildWidget(),
      );

  Widget getChildWidget() {
    return ScrollConfiguration(
      behavior: NoOverFlowScrollbarBehaviour(),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            getHeaderWidget(),
            Padding(
              padding: const EdgeInsets.only(
                left: 28,
                right: 28,
                bottom: 12,
              ),
              child: Text(
                'Explore',
                style: TextStyle(
                  color: ColorList.greyLight2Color,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
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
                style: TextStyle(
                  color: ColorList.greyLight2Color,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            SizedBox(
              height: 200,
              child: ScrollConfiguration(
                behavior: NoOverFlowScrollbarBehaviour(),
                child:
                    ListView(scrollDirection: Axis.horizontal, children: const [
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
                style: TextStyle(
                  color: ColorList.greyLight2Color,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
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
  }

  Widget getHeaderWidget() => Padding(
        padding: const EdgeInsets.only(
          top: 20,
          left: 28,
          right: 28,
          bottom: 45,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi Dami',
              style: TextStyle(
                color: ColorList.blackSecondColor,
                fontSize: 24,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(
              height: 14,
            ),
            getKoloboxAmountWidget(),
            const SizedBox(
              height: 18,
            ),
            const Center(
              child: DepositAmountWidget(),
            ),
            const SizedBox(
              height: 23,
            ),
            const WelcomeToKoloboxWidget(),
          ],
        ),
      );

  Container getKoloboxAmountWidget() {
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
                  pageIndicatorStreamController.add(pageIndicatorPosition);
                },
                itemCount: koloboxAmountModels.length,
                itemBuilder: (_, index) {
                  return Column(
                    children: [
                      Text(
                        koloboxAmountModels[index].title,
                        style: TextStyle(
                          color: ColorList.white,
                          fontSize: 12,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(
                        height: 11,
                      ),
                      Text(
                        '₦ ${koloboxAmountModels[index].amount}',
                        style: TextStyle(
                          color: ColorList.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  );
                }),
          ),
          StreamBuilder<int>(
              initialData: pageIndicatorPosition,
              stream: pageIndicatorStreamController.stream,
              builder: (context, snapshot) => Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: _buildPageIndicator(),
                  )),
        ],
      ),
    );
  }

  Widget getReferAndEarnWidget() => const Padding(
        padding: EdgeInsets.only(top: 40, left: 28, right: 28, bottom: 30),
        child: ReferAndEarnWidget(),
      );

  AppBar getAppBar() => AppBar(
        backgroundColor: ColorList.transparentColor,
        bottomOpacity: 0,
        elevation: 0,
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: ColorList.white,
          statusBarIconBrightness: Brightness.dark,
          statusBarBrightness: Brightness.light,
        ),
        title: const HomeAppBarWidget(),
        leading: Image.asset(imageDashboardIcon),
        actions: [
          Image.asset(imageNotification),
        ],
        centerTitle: false,
        titleSpacing: 15.0,
      );

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < koloboxAmountModels.length; i++) {
      list.add(
          i == pageIndicatorPosition ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 4),
        height: 5,
        width: isActive ? 15 : 5,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isActive ? ColorList.white : ColorList.lightBlue4Color,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      );

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    pageIndicatorStreamController.close();
  }
}
