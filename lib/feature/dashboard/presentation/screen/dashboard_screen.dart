import 'dart:async';

import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/enums/dashboard_tab_enum.dart';
import 'package:kolobox_new_app/feature/account/presentation/account_page.dart';
import 'package:kolobox_new_app/feature/home/presentation/home_page.dart';
import 'package:kolobox_new_app/feature/kolobox/presentation/kolobox_page.dart';
import 'package:kolobox_new_app/feature/wallet/presentation/wallet_page.dart';

import '../../../../../core/base/base_bloc_widget.dart';

class DashboardScreen extends BaseBlocWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  DashboardScreenState createState() => DashboardScreenState();
}

class DashboardScreenState extends BaseBlocWidgetState<DashboardScreen> {
  StreamController<DashboardTabEnum> dashboardTabStreamController =
      StreamController<DashboardTabEnum>.broadcast();

  DashboardTabEnum dashboardTabEnum = DashboardTabEnum.home;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget getCustomBloc() => Scaffold(
        backgroundColor: ColorList.white,
        body: Column(
          children: [
            Expanded(
              child: StreamBuilder<DashboardTabEnum>(
                  stream: dashboardTabStreamController.stream,
                  builder: (context, snapshot) {
                    switch (dashboardTabEnum) {
                      case DashboardTabEnum.home:
                        return const HomePage();
                      case DashboardTabEnum.kolobox:
                        return const KoloboxPage();
                      case DashboardTabEnum.wallet:
                        return const WalletPage();
                      case DashboardTabEnum.account:
                        return const AccountPage();
                    }
                    return Center(child: Text("In Development"));
                  }),
            ),
            getTabWidget(),
          ],
        ),
      );

  Widget getTabWidget() => StreamBuilder<DashboardTabEnum>(
      stream: dashboardTabStreamController.stream,
      builder: (context, snapshot) {
        bool isHome = dashboardTabEnum == DashboardTabEnum.home;
        bool isKolobox = dashboardTabEnum == DashboardTabEnum.kolobox;
        bool isWallet = dashboardTabEnum == DashboardTabEnum.wallet;
        bool isAccount = dashboardTabEnum == DashboardTabEnum.account;
        return Column(
          children: [
            Container(
              color: ColorList.greyLight4Color,
              width: double.maxFinite,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  Expanded(
                    child: getTabItemWidget(DashboardTabEnum.home,
                        isSelected: isHome),
                  ),
                  Expanded(
                    child: getTabItemWidget(DashboardTabEnum.kolobox,
                        isSelected: isKolobox),
                  ),
                  Expanded(
                    child: getTabItemWidget(DashboardTabEnum.wallet,
                        isSelected: isWallet),
                  ),
                  Expanded(
                    child: getTabItemWidget(DashboardTabEnum.account,
                        isSelected: isAccount),
                  ),
                ],
              ),
            ),
          ],
        );
      });

  Widget getTabItemWidget(DashboardTabEnum tabEnum, {bool isSelected = false}) {
    String image = imageHomeIcon;
    String title = 'Home';

    switch (tabEnum) {
      case DashboardTabEnum.home:
        image = isSelected ? imageHomeIconSelected : imageHomeIcon;
        title = 'Home';
        break;
      case DashboardTabEnum.kolobox:
        image = isSelected ? imageKoloboxIconSelected : imageKoloboxIcon;
        title = 'Kolobox';
        break;
      case DashboardTabEnum.wallet:
        image = isSelected ? imageWalletIconSelected : imageWalletIcon;
        title = 'Wallet';
        break;
      case DashboardTabEnum.account:
        image = isSelected ? imageAccountIconSelected : imageAccountIcon;
        title = 'Account';
        break;
    }

    return GestureDetector(
      onTap: () {
        dashboardTabEnum = tabEnum;
        dashboardTabStreamController.add(dashboardTabEnum);
      },
      child: AbsorbPointer(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 13),
          child: Column(
            children: [
              Image.asset(image),
              const SizedBox(
                height: 6,
              ),
              Text(
                title,
                style: TextStyle(
                  fontSize: 10,
                  color: isSelected
                      ? ColorList.primaryColor
                      : ColorList.blackThirdColor,
                  fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    dashboardTabStreamController.close();
  }
}
