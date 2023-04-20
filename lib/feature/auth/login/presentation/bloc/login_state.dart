import 'package:kolobox_new_app/feature/auth/login/data/models/login_response_model.dart';

abstract class LoginState {}

class InitialState extends LoginState {}

class CallLoginState extends LoginState {
  final LoginResponseModel model;
  final bool isPinSet;

  CallLoginState({required this.model, this.isPinSet = false});
}

class CreatePinState extends LoginState {
  final LoginResponseModel model;

  CreatePinState({required this.model});
}

class UpdatePasswordState extends LoginState {
  final String message;

  UpdatePasswordState({required this.message});
}
