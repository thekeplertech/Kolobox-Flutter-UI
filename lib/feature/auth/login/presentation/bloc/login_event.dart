import 'package:kolobox_new_app/feature/auth/login/data/models/login_request_model.dart';

abstract class LoginEvent {}

class CallLoginEvent extends LoginEvent {
  final LoginRequestModel model;

  CallLoginEvent({required this.model});
}
