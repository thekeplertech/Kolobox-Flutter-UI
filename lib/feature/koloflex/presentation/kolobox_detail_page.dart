import 'package:flutter/material.dart';

import '../../../core/base/base_page.dart';
import 'screen/kolobox_detail_screen.dart';

class KoloFlexPage extends BasePage {
  const KoloFlexPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloFlexPageState();
}

class KoloFlexPageState extends BasePageState<KoloFlexPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const KoloFlexScreen();
}
