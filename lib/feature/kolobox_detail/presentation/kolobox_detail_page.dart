import 'package:flutter/material.dart';

import '../../../core/base/base_page.dart';
import 'screen/kolobox_detail_screen.dart';

class KoloboxDetailPage extends BasePage {
  const KoloboxDetailPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloboxDetailPageState();
}

class KoloboxDetailPageState extends BasePageState<KoloboxDetailPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      const KoloboxDetailScreen();
}

// List<String> list = ['1', '2', '3'];
//
// String ids = '';
// for (int i = 0; i < list.length; i++) {
// if (ids.isNotEmpty) {
// ids += ',';
// }
// ids += list[i];
// }
