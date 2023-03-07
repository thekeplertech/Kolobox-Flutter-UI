import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

import '../di/injection_container.dart';

class CustomNavigatorObserver extends NavigatorObserver {
  Logger? logger = sl();

  @override
  void didPop(Route route, Route? previousRoute) {
    super.didPop(route, previousRoute);
    try {
      var string = "route = ${route.settings.name ?? ""}";
      string += " previousRoute = ${previousRoute?.settings.name ?? ""}";

      if (string.isNotEmpty) logger!.v("didPop $string");
    } catch (e) {
      logger!.e("didPop ex $e");
    }
  }

  @override
  void didPush(Route route, Route? previousRoute) {
    super.didPush(route, previousRoute);
    try {
      var string = "route = ${route.settings.name ?? ""}";
      string += " previousRoute = ${previousRoute?.settings.name ?? ""}";

      if (string.isNotEmpty) logger!.v("didPush $string");
    } catch (e) {
      logger!.e("didPush ex $e");
    }
  }

  @override
  void didRemove(Route route, Route? previousRoute) {
    super.didRemove(route, previousRoute);
    try {
      var string = "route = ${route.settings.name ?? ""}";
      string += " previousRoute = ${previousRoute?.settings.name ?? ""}";

      if (string.isNotEmpty) logger!.v("didRemove $string");
    } catch (e) {
      logger!.e("didRemove ex $e");
    }
  }

  @override
  void didReplace({Route? newRoute, Route? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    try {
      var string = "route = ${newRoute?.settings.name ?? ""}";
      string += " previousRoute = ${oldRoute?.settings.name ?? ""}";

      if (string.isNotEmpty) logger!.v("didReplace $string");
    } catch (e) {
      logger!.e("didReplace ex $e");
    }
  }
}
