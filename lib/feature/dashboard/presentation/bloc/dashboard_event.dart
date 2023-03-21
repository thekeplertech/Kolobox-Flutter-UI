abstract class DashboardEvent {}

class ShowEnableBottomScreenEvent extends DashboardEvent {}

class HideDisableBottomScreenEvent extends DashboardEvent {}

class ClearBackStackEvent extends DashboardEvent {
  final String until;

  ClearBackStackEvent({this.until = '/'});
}
