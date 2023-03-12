import 'package:kolobox_new_app/feature/auth/register/data/models/register_request_model.dart';

abstract class RegisterEvent {}

class CallRegisterEvent extends RegisterEvent {
  final RegisterRequestModel model;

  CallRegisterEvent({required this.model});
}
