import 'package:kolobox_new_app/feature/auth/login/data/models/login_response_model.dart';

abstract class LoginState {}

class InitialState extends LoginState {}

class CallLoginState extends LoginState {
  final LoginResponseModel model;

  CallLoginState({required this.model});
}

class CreatePinState extends LoginState {
  final LoginResponseModel model;

  CreatePinState({required this.model});
}
