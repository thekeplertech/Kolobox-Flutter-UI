import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_bloc.dart';

import '../../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';
import 'screen/dashboard_screen.dart';

class DashboardPage extends BasePage {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DashboardPageState();
}

class DashboardPageState extends BasePageState<DashboardPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<DashboardBloc>(
        create: (context) =>
            DashboardBloc(BlocProvider.of<MasterBloc>(context)),
        child: const DashboardScreen(),
      );
}
