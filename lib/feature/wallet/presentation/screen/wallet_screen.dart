import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';

import '../../../../../core/base/base_bloc_widget.dart';

class WalletScreen extends BaseBlocWidget {
  const WalletScreen({Key? key}) : super(key: key);

  @override
  WalletScreenState createState() => WalletScreenState();
}

class WalletScreenState extends BaseBlocWidgetState<WalletScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.white,
        body: const Center(child: Text('Wallet in development')),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
