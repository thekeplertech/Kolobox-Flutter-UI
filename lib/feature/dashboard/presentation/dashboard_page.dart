import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/dashboard_screen.dart';

class DashboardPage extends BasePage {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DashboardPageState();
}

class DashboardPageState extends BasePageState<DashboardPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const DashboardScreen();
}
