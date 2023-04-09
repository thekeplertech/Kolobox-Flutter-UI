import 'package:kolobox_new_app/feature/dashboard/data/models/earnings_request_model.dart';

abstract class KoloboxEvent {}

class ClickOnKoloboxEvent extends KoloboxEvent {}

class CallEarningsEvent extends KoloboxEvent {
  final EarningsRequestModel model;

  CallEarningsEvent({required this.model});
}
