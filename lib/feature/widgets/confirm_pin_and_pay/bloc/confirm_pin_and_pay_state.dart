import 'package:kolobox_new_app/feature/dashboard/data/models/select_product_response_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/top_up_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/top_up_response_model.dart';

import '../../../dashboard/data/models/create_family_response_model.dart';
import '../../../dashboard/data/models/create_group_response_model.dart';
import '../../../dashboard/data/models/get_group_list_response_model.dart';
import '../../../dashboard/data/models/get_group_tenor_response_model.dart';
import '../../../dashboard/data/models/select_product_request_model.dart';
import '../../../dashboard/data/models/verify_pin_request_model.dart';

abstract class ConfirmPinAndPayState {}

class InitialState extends ConfirmPinAndPayState {}

class VerifyPinState extends ConfirmPinAndPayState {
  final VerifyPinRequestModel model;

  VerifyPinState({required this.model});
}

class SelectProductState extends ConfirmPinAndPayState {
  final SelectProductRequestModel requestModel;
  final SelectProductResponseModel responseModel;
  final CreateGroupResponseModel? createGroupResponseModel;
  final CreateFamilyResponseModel? createFamilyResponseModel;

  SelectProductState({
    required this.requestModel,
    required this.responseModel,
    this.createGroupResponseModel,
    this.createFamilyResponseModel,
  });
}

class TopUpState extends ConfirmPinAndPayState {
  final TopUpRequestModel requestModel;
  final TopUpResponseModel responseModel;

  TopUpState({required this.requestModel, required this.responseModel});
}

class CreateInvestmentGoalState extends ConfirmPinAndPayState {
  final String referenceCode;
  final String amount;

  CreateInvestmentGoalState(
      {required this.referenceCode, required this.amount});
}

class CreateGroupState extends ConfirmPinAndPayState {
  final CreateGroupResponseModel responseModel;

  CreateGroupState({required this.responseModel});
}

class CreateFamilyState extends ConfirmPinAndPayState {
  final CreateFamilyResponseModel responseModel;

  CreateFamilyState({required this.responseModel});
}

class GetTenorState extends ConfirmPinAndPayState {
  final GetGroupTenorResponseModel model;

  GetTenorState({required this.model});
}

class GetGroupState extends ConfirmPinAndPayState {
  final GetGroupListResponseModel model;

  GetGroupState({required this.model});
}

class GetFamilyState extends ConfirmPinAndPayState {
  final GetGroupListResponseModel model;

  GetFamilyState({required this.model});
}
