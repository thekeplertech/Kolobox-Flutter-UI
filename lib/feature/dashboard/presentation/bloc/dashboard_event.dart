import 'package:kolobox_new_app/core/enums/dashboard_tab_enum.dart';

abstract class DashboardEvent {}

class LogoutEvent extends DashboardEvent {}

class ShowEnableBottomScreenEvent extends DashboardEvent {}

class HideDisableBottomScreenEvent extends DashboardEvent {}

class ClearBackStackEvent extends DashboardEvent {
  final String until;

  ClearBackStackEvent({this.until = '/'});
}

class SelectTabEvent extends DashboardEvent {
  final DashboardTabEnum tabEnum;

  SelectTabEvent({
    this.tabEnum = DashboardTabEnum.home,
  });
}
