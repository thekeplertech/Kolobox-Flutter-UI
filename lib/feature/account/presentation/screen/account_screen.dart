import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';

import '../../../../../core/base/base_bloc_widget.dart';
import '../../../../routes/routes.dart';

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
        body: SizedBox(
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text('Account in development'),
              GestureDetector(
                onTap: () {
                  prefHelper?.clear();
                  navigateAndRemoveAll(
                      context, Routes.splashLoaded, Routes.splashLoaded);
                },
                child: Text('Logout'),
              ),
            ],
          ),
        ),
      );

  @override
  void dispose() {
    super.dispose();
  }
}
