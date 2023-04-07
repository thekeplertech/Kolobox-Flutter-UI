import 'package:flutter/material.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../core/base/base_page.dart';
import 'screen/home_screen.dart';

class HomePage extends BasePage {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends BasePageState<HomePage> {
  @override
  Widget getChildBlocWidget(BuildContext context) {
    logger?.d('home screen');
    return const HomeScreen();
  }
}
