import 'package:flutter/material.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/dashboard_tab_model.dart';

import '../../../../core/base/base_screen.dart';

class DashboardManagementWidget extends BaseScreen {
  const DashboardManagementWidget(
      {Key? key, required this.dashboardModel /*, required this.onNavigation*/
      })
      : super(key: key);

  final DashboardTabModel dashboardModel;

  // final Function(bool) onNavigation;

  @override
  DashboardManagementWidgetState createState() =>
      DashboardManagementWidgetState();
}

class DashboardManagementWidgetState
    extends BaseScreenState<DashboardManagementWidget> {
  @override
  Widget body(BuildContext context) => Navigator(
        key: widget.dashboardModel.navigatorKey,
        // observers: <NavigatorObserver>[
        //   DashboardViewNavigatorObserver(widget.onNavigation),
        // ],
        initialRoute: "/",
        onGenerateRoute: (RouteSettings settings) => MaterialPageRoute(
          settings: settings,
          builder: (BuildContext context) {
            final arguments = settings.arguments;
            switch (settings.name) {
              default:
                return widget.dashboardModel.widget;
            }
          },
        ),
      );
}
