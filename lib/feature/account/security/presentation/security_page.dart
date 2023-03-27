import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/security_screen.dart';

class SecurityPage extends BasePage {
  const SecurityPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => SecurityPageState();
}

class SecurityPageState extends BasePageState<SecurityPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const SecurityScreen();
}
