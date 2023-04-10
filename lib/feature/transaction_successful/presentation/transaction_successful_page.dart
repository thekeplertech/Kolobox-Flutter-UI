import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/transaction_successful_screen.dart';

class TransactionSuccessfulPage extends BasePage {
  final String referenceCode;
  final String amount;
  final bool isDeposited;

  const TransactionSuccessfulPage({
    Key? key,
    required this.referenceCode,
    required this.amount,
    this.isDeposited = true,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => TransactionSuccessfulPageState();
}

class TransactionSuccessfulPageState
    extends BasePageState<TransactionSuccessfulPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      TransactionSuccessfulScreen(
        referenceCode: widget.referenceCode,
        amount: widget.amount,
        isDeposited: widget.isDeposited,
      );
}
