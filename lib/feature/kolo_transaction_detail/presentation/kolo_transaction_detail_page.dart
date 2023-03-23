import 'package:flutter/material.dart';

import '../../../core/base/base_page.dart';
import 'screen/kolo_transaction_detail_screen.dart';

class KoloTransactionDetailPage extends BasePage {
  const KoloTransactionDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloTransactionDetailPageState();
}

class KoloTransactionDetailPageState
    extends BasePageState<KoloTransactionDetailPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      const KoloTransactionDetailScreen();
}
