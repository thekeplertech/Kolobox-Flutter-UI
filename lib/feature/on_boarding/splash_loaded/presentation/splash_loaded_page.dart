import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/splash_loaded_screen.dart';

class SplashLoadedPage extends BasePage {
  const SplashLoadedPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashLoadedPageState();
}

class SplashLoadedPageState extends BasePageState<SplashLoadedPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const SplashLoadedScreen();
}
