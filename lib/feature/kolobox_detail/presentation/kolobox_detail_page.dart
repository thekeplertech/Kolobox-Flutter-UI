import 'package:flutter/material.dart';

import '../../../core/base/base_page.dart';
import 'screen/kolobox_detail_screen.dart';

class KoloboxDetailPage extends BasePage {
  const KoloboxDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloboxDetailPageState();
}

class KoloboxDetailPageState extends BasePageState<KoloboxDetailPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => KoloboxDetailScreen();
}
