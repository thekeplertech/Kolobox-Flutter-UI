import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/forgot_password_screen.dart';

class ForgotPasswordPage extends BasePage {
  const ForgotPasswordPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => ForgotPasswordPageState();
}

class ForgotPasswordPageState extends BasePageState<ForgotPasswordPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      const ForgotPasswordScreen();
}
