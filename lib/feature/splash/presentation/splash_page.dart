import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';
import 'bloc/splash_bloc.dart';
import 'screen/splash_screen.dart';

class SplashPage extends BasePage {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => SplashPageState();
}

class SplashPageState extends BasePageState<SplashPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => BlocProvider(
        create: (context) => SplashBloc(BlocProvider.of<MasterBloc>(context)),
        child: const SplashScreen(),
      );
}
