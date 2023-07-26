import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/account/bank_details/presentation/bloc/bank_detail_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_all_my_banks_response_model.dart';

import '../../../../core/base/base_page.dart';
import '../../../../core/bloc/master_bloc.dart';
import '../../../core/enums/kolobox_fund_enum.dart';
import 'withdrawal_summary_kolobox_widget.dart';

class WithdrawalSummaryKoloboxWidgetPage extends BasePage {
  final KoloboxFundEnum koloboxFundEnum;
  final String amount;
  final MyBankData myBankData;
  final String popUntil;

  const WithdrawalSummaryKoloboxWidgetPage({
    Key? key,
    required this.koloboxFundEnum,
    required this.amount,
    required this.myBankData,
    required this.popUntil,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      WithdrawalSummaryKoloboxWidgetPageState();
}

class WithdrawalSummaryKoloboxWidgetPageState
    extends BasePageState<WithdrawalSummaryKoloboxWidgetPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      BlocProvider<BankDetailBloc>(
        create: (context) =>
            BankDetailBloc(BlocProvider.of<MasterBloc>(context)),
        child: WithdrawalSummaryKoloboxWidget(
          koloboxFundEnum: widget.koloboxFundEnum,
          amount: widget.amount,
          myBankData: widget.myBankData,
          popUntil: widget.popUntil,
        ),
      );
}
