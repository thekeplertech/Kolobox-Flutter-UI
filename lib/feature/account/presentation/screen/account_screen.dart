import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';

import '../../../../../core/base/base_bloc_widget.dart';

class AccountScreen extends BaseBlocWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  AccountScreenState createState() => AccountScreenState();
}

class AccountScreenState extends BaseBlocWidgetState<AccountScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.white,
        body: const Center(child: Text('Account in development')),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
