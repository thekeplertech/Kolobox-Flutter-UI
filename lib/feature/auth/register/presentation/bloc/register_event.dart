import 'package:kolobox_new_app/feature/auth/register/data/models/register_request_model.dart';

import '../../data/models/verify_user_request_model.dart';

abstract class RegisterEvent {}

class CallRegisterEvent extends RegisterEvent {
  final RegisterRequestModel model;

  CallRegisterEvent({required this.model});
}

class VerifyUserEvent extends RegisterEvent {
  final VerifyUserRequestModel model;

  VerifyUserEvent({required this.model});
}

class SaveUserEvent extends RegisterEvent {}
