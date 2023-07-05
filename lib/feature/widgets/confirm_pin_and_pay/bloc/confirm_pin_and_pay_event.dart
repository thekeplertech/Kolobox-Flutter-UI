import 'package:kolobox_new_app/feature/dashboard/data/models/create_investment_goal_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/select_product_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/top_up_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/verify_pin_request_model.dart';

import '../../../dashboard/data/models/create_group_request_model.dart';

abstract class ConfirmPinAndPayEvent {}

class VerifyPinEvent extends ConfirmPinAndPayEvent {
  final VerifyPinRequestModel model;

  VerifyPinEvent({required this.model});
}

class SelectProductEvent extends ConfirmPinAndPayEvent {
  final String userId;
  final SelectProductRequestModel model;

  SelectProductEvent({required this.userId, required this.model});
}

class TopUpEvent extends ConfirmPinAndPayEvent {
  final String productId;
  final TopUpRequestModel model;

  TopUpEvent({required this.productId, required this.model});
}

class CreateInvestmentGoalEvent extends ConfirmPinAndPayEvent {
  final CreateInvestmentGoalRequestModel model;
  final String referenceCode;
  final String amount;

  CreateInvestmentGoalEvent(
      {required this.referenceCode, required this.amount, required this.model});
}

class CreateGroupEvent extends ConfirmPinAndPayEvent {
  final CreateGroupRequestModel model;
  final String referenceCode;
  final String amount;

  CreateGroupEvent(
      {required this.referenceCode, required this.amount, required this.model});
}

class GetTenorEvent extends ConfirmPinAndPayEvent {}

class GetGroupEvent extends ConfirmPinAndPayEvent {}
