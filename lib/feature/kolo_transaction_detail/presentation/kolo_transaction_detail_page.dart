import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/investment_goal_response_model.dart';

import '../../../core/base/base_page.dart';
import '../../../core/bloc/master_bloc.dart';
import '../../koloflex/presentation/bloc/kolo_flex_bloc.dart';
import 'screen/kolo_transaction_detail_screen.dart';

class KoloTransactionDetailPage extends BasePage {
  final InvestmentGoalModel investmentGoalModel;
  final double interestAmount;
  final bool isPaid;

  const KoloTransactionDetailPage({
    Key? key,
    required this.isPaid,
    required this.interestAmount,
    required this.investmentGoalModel,
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
        ),
      );
}
