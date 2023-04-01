import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/notification_settings_screen.dart';

class NotificationSettingsPage extends BasePage {
  const NotificationSettingsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => NotificationSettingsPageState();
}

class NotificationSettingsPageState
    extends BasePageState<NotificationSettingsPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      const NotificationSettingsScreen();
}
