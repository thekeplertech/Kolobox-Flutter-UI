import 'package:flutter/foundation.dart';
import 'package:logger/logger.dart';

import '../../config/flavor_config.dart';
import '../preference/pref_helper.dart';

class AppLogPrinter extends LogPrinter {
  final PrefHelper? prefHelper;

  AppLogPrinter({
    required this.prefHelper,
  });

  @override
  List<String> log(LogEvent event) {
    if (kDebugMode && !FlavorConfig.isProd()) {
      print("printing logger ${event.message}");
    }
    return [];
  }
}
