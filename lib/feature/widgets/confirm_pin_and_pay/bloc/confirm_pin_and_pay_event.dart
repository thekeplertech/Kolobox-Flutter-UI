import 'package:kolobox_new_app/feature/dashboard/data/models/create_investment_goal_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/select_product_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/top_up_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/verify_pin_request_model.dart';

import '../../../dashboard/data/models/create_family_request_model.dart';
import '../../../dashboard/data/models/create_family_response_model.dart';
import '../../../dashboard/data/models/create_group_request_model.dart';
import '../../../dashboard/data/models/create_group_response_model.dart';

abstract class ConfirmPinAndPayEvent {}

class VerifyPinEvent extends ConfirmPinAndPayEvent {
  final VerifyPinRequestModel model;

  VerifyPinEvent({required this.model});
}

class SelectProductEvent extends ConfirmPinAndPayEvent {
  final String userId;
  final SelectProductRequestModel model;
  final CreateGroupResponseModel? createGroupResponseModel;
  final CreateFamilyResponseModel? createFamilyResponseModel;

  SelectProductEvent(
      {required this.userId,
      required this.model,
      this.createGroupResponseModel,
      this.createFamilyResponseModel});
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

  CreateGroupEvent({required this.model});
}

class CreateFamilyEvent extends ConfirmPinAndPayEvent {
  final CreateFamilyRequestModel model;

  CreateFamilyEvent({required this.model});
}

class GetTenorEvent extends ConfirmPinAndPayEvent {}

class GetGroupEvent extends ConfirmPinAndPayEvent {}

class GetFamilyEvent extends ConfirmPinAndPayEvent {}
