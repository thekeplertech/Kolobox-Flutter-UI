import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import '../../../routes/routes.dart';
import 'screen/account_screen.dart';

class AccountPage extends BasePage {
  const AccountPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => AccountPageState();
}

class AccountPageState extends BasePageState<AccountPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) {
    logger?.d('account screen');
    return const AccountScreen();
  }
}
