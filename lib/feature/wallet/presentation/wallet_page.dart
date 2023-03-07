import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/wallet_screen.dart';

class WalletPage extends BasePage {
  const WalletPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => WalletPageState();
}

class WalletPageState extends BasePageState<WalletPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const WalletScreen();
}
