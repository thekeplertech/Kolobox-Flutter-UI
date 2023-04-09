import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:kolobox_new_app/feature/home/presentation/bloc/home_bloc.dart';
import 'package:kolobox_new_app/feature/kolobox/presentation/bloc/kolobox_bloc.dart';
import 'package:kolobox_new_app/feature/wallet/presentation/bloc/wallet_bloc.dart';

import '../../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';
import '../../widgets/inherited_state_container.dart';
import 'screen/dashboard_screen.dart';

class DashboardPage extends BasePage {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => DashboardPageState();
}

class DashboardPageState extends BasePageState<DashboardPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => StateContainer(
        key: const Key('unique'),
        child: MultiBlocProvider(
          providers: [
            BlocProvider<DashboardBloc>(
              create: (context) =>
                  DashboardBloc(BlocProvider.of<MasterBloc>(context)),
            ),
            BlocProvider<HomeBloc>(
              create: (context) =>
                  HomeBloc(BlocProvider.of<MasterBloc>(context)),
            ),
            BlocProvider<KoloboxBloc>(
              create: (context) =>
                  KoloboxBloc(BlocProvider.of<MasterBloc>(context)),
            ),
            BlocProvider<WalletBloc>(
              create: (context) =>
                  WalletBloc(BlocProvider.of<MasterBloc>(context)),
            ),
          ],
          child: const DashboardScreen(),
        ),
      );
}
