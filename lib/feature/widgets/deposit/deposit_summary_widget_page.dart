import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/base/base_bloc_widget.dart';

import '../../../core/bloc/master_bloc.dart';
import '../confirm_pin_and_pay/bloc/confirm_pin_and_pay_bloc.dart';
import 'deposit_summary_widget.dart';

class DepositSummaryWidgetPage extends BaseBlocWidget {
  const DepositSummaryWidgetPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => DepositSummaryWidgetPageState();
}

class DepositSummaryWidgetPageState
    extends BaseBlocWidgetState<DepositSummaryWidgetPage> {
  @override
  Widget getCustomBloc() => BlocProvider<ConfirmPinAndPayBloc>(
        create: (context) =>
            ConfirmPinAndPayBloc(BlocProvider.of<MasterBloc>(context)),
        child: const DepositSummaryWidget(),
      );
}
