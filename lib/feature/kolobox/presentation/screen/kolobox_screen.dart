import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';

import '../../../../../core/base/base_bloc_widget.dart';

class KoloboxScreen extends BaseBlocWidget {
  const KoloboxScreen({Key? key}) : super(key: key);

  @override
  KoloboxScreenState createState() => KoloboxScreenState();
}

class KoloboxScreenState extends BaseBlocWidgetState<KoloboxScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.white,
        body: const Center(child: Text('Kolobox in development')),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
