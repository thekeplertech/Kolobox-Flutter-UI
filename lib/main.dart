import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '/di/injection_container.dart' as di;
import 'core/colors/color_list.dart';
import 'core/constants/label_constants.dart';
import 'core/preference/prefs.dart';
import 'routes/custom_navigator_observer.dart';
import 'routes/routes.dart';

void mainDelegate() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Prefs.init();
  await di.init();
  runZonedGuarded<Future<void>>(() async {
    runApp(
      const MyApp(),
    );
  }, (error, stackTrace) {});
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: ColorList.primaryMaterialColor,
      statusBarIconBrightness: Brightness.light,
    ));
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateTitle: (context) => appName,
      initialRoute: Routes.splash,
      routes: Routes.routes,
      theme: ThemeData(
        fontFamily: 'MontSerrat',
        primaryColor: ColorList.primaryColor,
        appBarTheme: AppBarTheme(
          color: ColorList.accentColor,
          systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      navigatorObservers: <NavigatorObserver>[
        CustomNavigatorObserver(),
      ],
    );
  }
}
