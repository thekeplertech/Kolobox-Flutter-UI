import 'package:flutter/material.dart';

import '../../../core/base/base_page.dart';
import 'screen/kolo_group_screen.dart';

class KoloGroupPage extends BasePage {
  const KoloGroupPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloGroupPageState();
}

class KoloGroupPageState extends BasePageState<KoloGroupPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const KoloGroupScreen();
}
