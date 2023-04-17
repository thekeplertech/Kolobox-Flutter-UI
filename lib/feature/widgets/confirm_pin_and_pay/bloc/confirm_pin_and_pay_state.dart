import 'package:kolobox_new_app/feature/dashboard/data/models/select_product_response_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/top_up_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/top_up_response_model.dart';

import '../../../dashboard/data/models/select_product_request_model.dart';

abstract class ConfirmPinAndPayState {}

class InitialState extends ConfirmPinAndPayState {}

class VerifyPinState extends ConfirmPinAndPayState {}

class SelectProductState extends ConfirmPinAndPayState {
  final SelectProductRequestModel requestModel;
  final SelectProductResponseModel responseModel;

  SelectProductState({required this.requestModel, required this.responseModel});
}

class TopUpState extends ConfirmPinAndPayState {
  final TopUpRequestModel requestModel;
  final TopUpResponseModel responseModel;

  TopUpState({required this.requestModel, required this.responseModel});
}

class CreateInvestmentGoalState extends ConfirmPinAndPayState {}
