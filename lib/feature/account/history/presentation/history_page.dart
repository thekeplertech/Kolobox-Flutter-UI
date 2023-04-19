import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_page.dart';
import '../../../../core/bloc/master_bloc.dart';
import '../../../wallet/presentation/bloc/wallet_bloc.dart';
import 'screen/history_screen.dart';

class HistoryPage extends BasePage {
  const HistoryPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => HistoryPageState();
}

class HistoryPageState extends BasePageState<HistoryPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => BlocProvider<WalletBloc>(
        create: (context) => WalletBloc(BlocProvider.of<MasterBloc>(context)),
        child: const HistoryScreen(),
      );
}
