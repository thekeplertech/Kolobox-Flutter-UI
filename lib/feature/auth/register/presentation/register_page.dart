import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/register_screen.dart';

class RegisterPage extends BasePage {
  const RegisterPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends BasePageState<RegisterPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const RegisterScreen();
}
