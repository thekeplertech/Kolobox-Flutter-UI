import 'package:kolobox_new_app/feature/auth/forget_password/data/models/change_password_request_model.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/forget_password_request_model.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/validate_request_model.dart';

abstract class ForgotPasswordEvent {}

class CallForgotPasswordEvent extends ForgotPasswordEvent {
  final ForgetPasswordRequestModel model;

  CallForgotPasswordEvent({required this.model});
}

class ForgotPasswordValidateEvent extends ForgotPasswordEvent {
  final ValidateRequestModel model;

  ForgotPasswordValidateEvent({required this.model});
}

class ChangePasswordEvent extends ForgotPasswordEvent {
  final ChangePasswordRequestModel model;

  ChangePasswordEvent({required this.model});
}
