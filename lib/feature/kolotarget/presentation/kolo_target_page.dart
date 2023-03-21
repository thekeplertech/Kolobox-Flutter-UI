import 'package:flutter/material.dart';

import '../../../core/base/base_page.dart';
import 'screen/kolo_target_screen.dart';

class KoloTargetPage extends BasePage {
  const KoloTargetPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloTargetPageState();
}

class KoloTargetPageState extends BasePageState<KoloTargetPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const KoloTargetScreen();
}
