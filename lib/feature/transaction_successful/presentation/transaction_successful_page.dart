import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/transaction_successful_screen.dart';

class TransactionSuccessfulPage extends BasePage {
  const TransactionSuccessfulPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => TransactionSuccessfulPageState();
}

class TransactionSuccessfulPageState
    extends BasePageState<TransactionSuccessfulPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      const TransactionSuccessfulScreen();
}
