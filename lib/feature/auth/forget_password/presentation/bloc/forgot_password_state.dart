import 'package:kolobox_new_app/feature/auth/forget_password/data/models/forget_password_request_model.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/forget_password_response_model.dart';

abstract class ForgotPasswordState {}

class InitialState extends ForgotPasswordState {}

class CallForgotPasswordState extends ForgotPasswordState {
  final ForgetPasswordResponseModel model;

  CallForgotPasswordState({required this.model});
}

class ForgotPasswordValidateState extends ForgotPasswordState {
  final ForgetPasswordRequestModel model;

  ForgotPasswordValidateState({required this.model});
}

class ChangePasswordState extends ForgotPasswordState {
  final ForgetPasswordRequestModel model;

  ChangePasswordState({required this.model});
}
