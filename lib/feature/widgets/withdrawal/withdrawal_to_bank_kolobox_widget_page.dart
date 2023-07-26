import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/feature/account/bank_details/presentation/bloc/bank_detail_bloc.dart';

import '../../../../core/base/base_page.dart';
import '../../../../core/bloc/master_bloc.dart';
import 'withdrawal_to_bank_kolobox_widget.dart';

class WithdrawalToBankKoloboxWidgetPage extends BasePage {
  final KoloboxFundEnum koloboxFundEnum;
  final String popUntil;

  const WithdrawalToBankKoloboxWidgetPage({
    Key? key,
    required this.koloboxFundEnum,
    required this.popUntil,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      WithdrawalToBankKoloboxWidgetPageState();
}

class WithdrawalToBankKoloboxWidgetPageState
    extends BasePageState<WithdrawalToBankKoloboxWidgetPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<BankDetailBloc>(
        create: (context) =>
            BankDetailBloc(BlocProvider.of<MasterBloc>(context)),
        child: WithdrawalToBankKoloboxWidget(
          koloboxFundEnum: widget.koloboxFundEnum,
          popUntil: widget.popUntil,
        ),
      );
}
