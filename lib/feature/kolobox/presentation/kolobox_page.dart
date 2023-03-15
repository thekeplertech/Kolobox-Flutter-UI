import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import '../../../routes/routes.dart';
import 'screen/kolobox_screen.dart';

class KoloboxPage extends BasePage {
  const KoloboxPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloboxPageState();
}

class KoloboxPageState extends BasePageState<KoloboxPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) {
    logger?.d('kolobox screen');
    return const KoloboxScreen();
  }
}
