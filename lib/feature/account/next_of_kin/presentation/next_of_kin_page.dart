import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/next_of_kin_screen.dart';

class NextOfKinPage extends BasePage {
  const NextOfKinPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => NextOfKinPageState();
}

class NextOfKinPageState extends BasePageState<NextOfKinPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const NextOfKinScreen();
}
