import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_request_model.dart';

abstract class KoloFlexEvent {}

class GetTransactionsEvent extends KoloFlexEvent {
  final TransactionsRequestModel model;

  GetTransactionsEvent({required this.model});
}
