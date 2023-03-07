import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/login_screen.dart';

class LoginPage extends BasePage {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends BasePageState<LoginPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const LoginScreen();
}
