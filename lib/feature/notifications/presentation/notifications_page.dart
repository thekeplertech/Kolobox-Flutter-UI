import 'package:flutter/material.dart';

import '../../../core/base/base_page.dart';
import 'screen/notifications_screen.dart';

class NotificationsPage extends BasePage {
  const NotificationsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => NotificationsPageState();
}

class NotificationsPageState extends BasePageState<NotificationsPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      const NotificationsScreen();
}
