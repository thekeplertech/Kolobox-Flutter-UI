import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/notification_screen.dart';

class NotificationPage extends BasePage {
  const NotificationPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => NotificationPageState();
}

class NotificationPageState extends BasePageState<NotificationPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const NotificationScreen();
}
