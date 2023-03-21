import 'package:flutter/material.dart';

import '../../../core/base/base_page.dart';
import 'screen/kolo_family_screen.dart';

class KoloFamilyPage extends BasePage {
  const KoloFamilyPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloFamilyPageState();
}

class KoloFamilyPageState extends BasePageState<KoloFamilyPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const KoloFamilyScreen();
}
