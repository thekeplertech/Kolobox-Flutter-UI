import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_group_list_response_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/investment_goal_response_model.dart';

import '../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';
import '../../../core/enums/kolobox_fund_enum.dart';
import '../../koloflex/presentation/bloc/kolo_flex_bloc.dart';
import 'screen/kolo_transaction_detail_screen.dart';

class KoloTransactionDetailPage extends BasePage {
  final InvestmentGoalModel? investmentGoalModel;
  final GroupModel? groupModel;
  final double interestAmount;
  final bool isPaid;
  final KoloboxFundEnum koloboxFundEnum;

  const KoloTransactionDetailPage({
    Key? key,
    required this.isPaid,
    required this.interestAmount,
    this.investmentGoalModel,
    this.groupModel,
    required this.koloboxFundEnum,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloTransactionDetailPageState();
}

class KoloTransactionDetailPageState
    extends BasePageState<KoloTransactionDetailPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) => BlocProvider<KoloFlexBloc>(
        create: (context) => KoloFlexBloc(BlocProvider.of<MasterBloc>(context)),
        child: KoloTransactionDetailScreen(
          isPaid: widget.isPaid,
          interestAmount: widget.interestAmount,
          investmentGoalModel: widget.investmentGoalModel,
          groupModel: widget.groupModel,
          koloboxFundEnum: widget.koloboxFundEnum,
        ),
      );
}
