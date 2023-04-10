import 'package:kolobox_new_app/core/enums/kolobox_fund_enum.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/earnings_request_model.dart';

abstract class KoloboxEvent {}

class ClickOnKoloboxEvent extends KoloboxEvent {}

class CallEarningsEvent extends KoloboxEvent {
  final KoloboxFundEnum fundEnum;
  final EarningsRequestModel model;

  CallEarningsEvent({required this.model, required this.fundEnum});
}
