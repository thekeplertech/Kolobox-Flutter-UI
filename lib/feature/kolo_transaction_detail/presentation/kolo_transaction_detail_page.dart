import 'package:flutter/material.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/investment_goal_response_model.dart';

import '../../../core/base/base_page.dart';
import 'screen/kolo_transaction_detail_screen.dart';

class KoloTransactionDetailPage extends BasePage {
  final InvestmentGoalResponseModel goalResponseModel;
  final double interestAmount;
  final bool isPaid;

  const KoloTransactionDetailPage({
    Key? key,
    required this.isPaid,
    required this.interestAmount,
    required this.goalResponseModel,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => KoloTransactionDetailPageState();
}

class KoloTransactionDetailPageState
    extends BasePageState<KoloTransactionDetailPage> {
  @override
  Widget getChildBlocWidget(BuildContext context) =>
      KoloTransactionDetailScreen(
        isPaid: widget.isPaid,
        interestAmount: widget.interestAmount,
        goalResponseModel: widget.goalResponseModel,
      );
}
