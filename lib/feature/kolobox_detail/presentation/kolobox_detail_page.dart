import 'package:flutter/material.dart';

import '../../../core/base/base_page.dart';
import '../../../core/enums/kolobox_fund_enum.dart';
import 'screen/kolobox_detail_screen.dart';

class KoloboxDetailPage extends BasePage {
  final KoloboxFundEnum koloboxFundEnum;

  const KoloboxDetailPage({
    Key? key,
    required this.koloboxFundEnum,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloboxDetailPageState();
}

class KoloboxDetailPageState extends BasePageState<KoloboxDetailPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => KoloboxDetailScreen(
        koloboxFundEnum: widget.koloboxFundEnum,
      );
}
