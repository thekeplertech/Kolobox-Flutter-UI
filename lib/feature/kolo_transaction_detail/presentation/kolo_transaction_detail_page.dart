import 'package:flutter/material.dart';

import '../../../core/base/base_page.dart';
import 'screen/kolo_transaction_detail_screen.dart';

class KoloTransactionDetailPage extends BasePage {
  final bool isPaid;

  const KoloTransactionDetailPage({
    Key? key,
    required this.isPaid,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloTransactionDetailPageState();
}

class KoloTransactionDetailPageState
    extends BasePageState<KoloTransactionDetailPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      KoloTransactionDetailScreen(isPaid: widget.isPaid);
}
