import 'package:kolobox_new_app/feature/auth/register/data/models/register_response_model.dart';

abstract class RegisterState {}

class InitialState extends RegisterState {}

class CallRegisterState extends RegisterState {
  final RegisterResponseModel model;

  CallRegisterState({required this.model});
}
