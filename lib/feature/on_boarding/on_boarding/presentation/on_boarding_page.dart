import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/on_boarding_screen.dart';

class OnBoardingPage extends BasePage {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => OnBoardingPageState();
}

class OnBoardingPageState extends BasePageState<OnBoardingPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const OnBoardingScreen();
}
