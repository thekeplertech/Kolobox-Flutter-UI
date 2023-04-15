import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_request_model.dart';

abstract class KoloTargetEvent {}

class GetTransactionsEvent extends KoloTargetEvent {
  final TransactionsRequestModel model;

  GetTransactionsEvent({required this.model});
}
