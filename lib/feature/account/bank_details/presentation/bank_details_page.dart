import 'package:flutter/material.dart';

import '../../../../core/base/base_page.dart';
import 'screen/bank_details_screen.dart';

class BankDetailsPage extends BasePage {
  const BankDetailsPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => BankDetailsPageState();
}

class BankDetailsPageState extends BasePageState<BankDetailsPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => const BankDetailsScreen();
}
