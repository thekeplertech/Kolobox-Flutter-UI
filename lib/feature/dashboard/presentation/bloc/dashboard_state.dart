import '../../../../core/enums/dashboard_tab_enum.dart';

abstract class DashboardState {}

class InitialState extends DashboardState {}

class ShowEnableBottomScreenState extends DashboardState {}

class HideDisableBottomScreenState extends DashboardState {}

class ClearBackStackState extends DashboardState {
  final String until;

  ClearBackStackState({this.until = '/'});
}

class SelectTabState extends DashboardState {
  final DashboardTabEnum tabEnum;

  SelectTabState({
    this.tabEnum = DashboardTabEnum.home,
  });
}
