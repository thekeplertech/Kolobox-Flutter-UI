import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_data_model.dart';

abstract class KoloFlexState {}

class InitialState extends KoloFlexState {}

class GetTransactionsState extends KoloFlexState {
  final TransactionsDataModel model;

  GetTransactionsState({required this.model});
}
