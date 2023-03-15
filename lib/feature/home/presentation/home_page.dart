import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/home/presentation/bloc/home_bloc.dart';
import 'package:kolobox_new_app/routes/routes.dart';

import '../../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';
import 'screen/home_screen.dart';

class HomePage extends BasePage {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => HomePageState();
}

class HomePageState extends BasePageState<HomePage> {
  @override
  Widget getChildBlocWidget(BuildContext context) {
    logger?.d('home screen');
    return BlocProvider<HomeBloc>(
      create: (context) => HomeBloc(BlocProvider.of<MasterBloc>(context)),
      child: const HomeScreen(),
    );
  }
}
