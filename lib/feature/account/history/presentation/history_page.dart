import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/history_screen.dart';

class HistoryPage extends BasePage {
  const HistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState extends BasePageState<HistoryPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const HistoryScreen();
}
