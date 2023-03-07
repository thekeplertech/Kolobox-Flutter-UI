import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/master_bloc.dart';
import '../bloc/master_state.dart';

abstract class BasePage extends StatefulWidget {
  const BasePage({Key? key}) : super(key: key);
}

abstract class BasePageState<T extends BasePage> extends State<T> {
  @override
  Widget build(BuildContext context) => BlocProvider<MasterBloc>(
        create: (BuildContext context) => MasterBloc(BaseApiStateInitial()),
        child: getChildBlocWidget(context),
      );

  Widget getChildBlocWidget(BuildContext context);
}
