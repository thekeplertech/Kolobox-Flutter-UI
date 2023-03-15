import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/feature/kolobox/presentation/kolobox_page.dart';
import 'package:kolobox_new_app/feature/wallet/presentation/wallet_page.dart';

import '../../../../core/enums/dashboard_tab_enum.dart';
import '../../../account/presentation/account_page.dart';
import '../../../home/presentation/home_page.dart';

class DashboardTabModel {
  final DashboardTabEnum dashboardTabEnum;
  final String title;
  final String icon;
  final String iconSelected;
  final Widget widget;
  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
  GlobalKey dashboardKey; // = GlobalKey();

  DashboardTabModel({
    required this.dashboardTabEnum,
    required this.title,
    required this.icon,
    required this.iconSelected,
    required this.widget,
    required this.dashboardKey,
  });
}

List<DashboardTabModel> dashboardTabModels = [
  DashboardTabModel(
    dashboardTabEnum: DashboardTabEnum.home,
    title: 'Home',
    icon: imageHomeIcon,
    iconSelected: imageHomeIconSelected,
    widget: const HomePage(),
    dashboardKey: GlobalKey(),
  ),
  DashboardTabModel(
    dashboardTabEnum: DashboardTabEnum.kolobox,
    title: 'Kolobox',
    icon: imageKoloboxIcon,
    iconSelected: imageKoloboxIconSelected,
    widget: const KoloboxPage(),
    dashboardKey: GlobalKey(),
  ),
  DashboardTabModel(
    dashboardTabEnum: DashboardTabEnum.wallet,
    title: 'Wallet',
    icon: imageWalletIcon,
    iconSelected: imageWalletIconSelected,
    widget: const WalletPage(),
    dashboardKey: GlobalKey(),
  ),
  DashboardTabModel(
    dashboardTabEnum: DashboardTabEnum.account,
    title: 'Account',
    icon: imageAccountIcon,
    iconSelected: imageAccountIconSelected,
    widget: const AccountPage(),
    dashboardKey: GlobalKey(),
  ),
];
