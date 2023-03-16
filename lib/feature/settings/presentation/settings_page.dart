import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/settings_screen.dart';

class SettingsPage extends BasePage {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SettingsPageState();
}

class SettingsPageState extends BasePageState<SettingsPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const SettingsScreen();
}
