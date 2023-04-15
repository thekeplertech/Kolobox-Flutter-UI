import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_data_model.dart';

abstract class KoloTargetState {}

class InitialState extends KoloTargetState {}

class GetTransactionsState extends KoloTargetState {
  final TransactionsDataModel model;

  GetTransactionsState({required this.model});
}
