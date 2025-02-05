import 'package:kolobox_new_app/feature/auth/login/data/models/login_request_model.dart';
import 'package:kolobox_new_app/feature/auth/login/data/models/login_response_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/update_password_request_model.dart';

import '../../data/models/create_pin_request_model.dart';
import '../../data/models/update_pin_request_model.dart';

abstract class LoginEvent {}

class CallLoginEvent extends LoginEvent {
  final LoginRequestModel model;

  CallLoginEvent({required this.model});
}

class CallCreatePinEvent extends LoginEvent {
  final LoginResponseModel loginResponseModel;
  final CreatePinRequestModel createPinRequestModel;

  CallCreatePinEvent({
    required this.loginResponseModel,
    required this.createPinRequestModel,
  });
}

class CallUpdatePinEvent extends LoginEvent {
  final UpdatePinRequestModel updatePinRequestModel;

  CallUpdatePinEvent({
    required this.updatePinRequestModel,
  });
}

class UpdatePasswordEvent extends LoginEvent {
  final UpdatePasswordRequestModel model;

  UpdatePasswordEvent({
    required this.model,
  });
}
