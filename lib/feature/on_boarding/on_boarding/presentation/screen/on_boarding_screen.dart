import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/ui/widgets/button.dart';
import 'package:kolobox_new_app/feature/auth/register/presentation/register_page.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../../core/constants/image_constants.dart';
import '../../data/models/on_boarding_model.dart';

class OnBoardingScreen extends BaseBlocWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  OnBoardingScreenState createState() => OnBoardingScreenState();
}

class OnBoardingScreenState extends BaseBlocWidgetState<OnBoardingScreen> {
  StreamController<int> pageIndicatorStreamController =
      StreamController<int>.broadcast();

  int pageIndicatorPosition = 0;

  PageController pageController = PageController(initialPage: 0);

  List<OnBoardingModel> onBoardingModels = [
    OnBoardingModel(imageOnBoardingProduct, 'Welcome to KoloBox',
        'We make it easy to invest in right product, Let your money work for you'),
    OnBoardingModel(
        imageOnBoardingAccount,
        'Creating your account is very simple',
        'takes less than a min, Just provide us with a few basic details- Name, email, phone,etc'),
    OnBoardingModel(
        imageOnBoardingInvestmentProduct,
        'Choose an investment product',
        'Choose an investment product based on your risk appetite.'),
    OnBoardingModel(
        imageOnBoardingBankAccount,
        'Connect your card/bank account',
        'and make an initial payment, you can also select amount to invest, & frequency whether daily, weekly monthly etc for automatic subscriptions/investments'),
  ];

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: pageIndicatorPosition);
  }

  void moveToNextStep() {
    navigatePushReplacement(context, const RegisterPage());
  }

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.white,
        appBar: AppBar(
          backgroundColor: ColorList.transparentColor,
          elevation: 0,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: ColorList.white,
            statusBarIconBrightness: Brightness.dark,
            statusBarBrightness: Brightness.light,
          ),
          leading: GestureDetector(
            onTap: () => goBack(context),
            child: Icon(
              Icons.arrow_back,
              color: ColorList.black,
            ),
          ),
          actions: [
            StreamBuilder<int>(
                initialData: pageIndicatorPosition,
                stream: pageIndicatorStreamController.stream,
                builder: (_, snapshot) {
                  if (pageIndicatorPosition != onBoardingModels.length - 1) {
                    return GestureDetector(
                      onTap: () => moveToNextStep(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 15),
                        child: Text(
                          'Skip',
                          style: TextStyle(
                            color: ColorList.primaryColor,
                            fontSize: 14,
                          ),
                        ),
                      ),
                    );
                  }
                  return const SizedBox();
                }),
          ],
        ),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                imageLogoOnBoarding,
                width: 113,
                height: 70,
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                  child: PageView.builder(
                controller: pageController,
                onPageChanged: (int page) {
                  pageIndicatorPosition = page;
                  pageIndicatorStreamController.add(pageIndicatorPosition);
                },
                itemCount: onBoardingModels.length,
                itemBuilder: (_, index) => getPageChild(index),
              )),
              const SizedBox(
                height: 50,
              ),
              StreamBuilder<int>(
                  initialData: pageIndicatorPosition,
                  stream: pageIndicatorStreamController.stream,
                  builder: (context, snapshot) => Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: _buildPageIndicator(),
                      )),
              const SizedBox(
                height: 56,
              ),
              Padding(
                padding: const EdgeInsets.only(
                  left: 28,
                  right: 28,
                  bottom: 32,
                ),
                child: StreamBuilder<int>(
                  initialData: pageIndicatorPosition,
                  stream: pageIndicatorStreamController.stream,
                  builder: (context, snapshot) => Row(
                    children: [
                      if (pageIndicatorPosition !=
                          onBoardingModels.length - 1) ...[
                        Expanded(
                          child: Button(
                            'Previous',
                            backgroundColor: ColorList.blueLightColor,
                            overlayColor: ColorList.blueColor,
                            textColor: ColorList.primaryColor,
                            borderRadius: 32,
                            onPressed: () async {
                              await Future.delayed(
                                  const Duration(milliseconds: 200));
                              pageController.animateToPage(
                                --pageIndicatorPosition,
                                duration: const Duration(milliseconds: 200),
                                curve: Curves.easeIn,
                              );
                            },
                          ),
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                      ],
                      Expanded(
                        child: Button(
                          'Next',
                          backgroundColor: pageIndicatorPosition !=
                                  onBoardingModels.length - 1
                              ? ColorList.white
                              : ColorList.primaryColor,
                          overlayColor: ColorList.blueColor,
                          textColor: pageIndicatorPosition !=
                                  onBoardingModels.length - 1
                              ? ColorList.primaryColor
                              : ColorList.white,
                          borderSide: pageIndicatorPosition !=
                                  onBoardingModels.length - 1
                              ? BorderSide(
                                  color: ColorList.primaryColor, width: 2)
                              : BorderSide.none,
                          borderRadius: 32,
                          onPressed: () async {
                            await Future.delayed(
                                const Duration(milliseconds: 200));
                            if (pageIndicatorPosition ==
                                onBoardingModels.length - 1) {
                              moveToNextStep();
                              return;
                            }
                            pageController.animateToPage(
                              ++pageIndicatorPosition,
                              duration: const Duration(milliseconds: 200),
                              curve: Curves.easeIn,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      );

  List<Widget> _buildPageIndicator() {
    List<Widget> list = [];
    for (int i = 0; i < onBoardingModels.length; i++) {
      list.add(
          i == pageIndicatorPosition ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) => AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        margin: const EdgeInsets.symmetric(horizontal: 8),
        height: 8,
        width: isActive ? 45 : 21,
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: isActive ? ColorList.primaryColor : ColorList.greyShadowColor,
          borderRadius: const BorderRadius.all(Radius.circular(12)),
        ),
      );

  Widget getPageChild(int index) => Padding(
        padding: const EdgeInsets.only(left: 28, right: 28),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Expanded(
              child: Center(
                child: Image.asset(
                  onBoardingModels[index].image,
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              onBoardingModels[index].title,
              style: TextStyle(
                fontSize: 24,
                color: ColorList.blackSecondColor,
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              onBoardingModels[index].description,
              style: TextStyle(
                fontSize: 12,
                color: ColorList.blackThirdColor,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      );

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
    pageIndicatorStreamController.close();
  }
}
