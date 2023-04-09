import 'package:kolobox_new_app/feature/home/data/models/dashboard_amount_model.dart';

import '../../data/models/wallet_data_model.dart';

abstract class HomeState {}

class InitialState extends HomeState {}

class ClickOnHomeState extends HomeState {}

class CallWalletState extends HomeState {
  final WalletDataModel model;

  CallWalletState({required this.model});
}

class CallProductState extends HomeState {
  final List<DashboardAmountModel> models;

  CallProductState({required this.models});
}

class CallActiveProductState extends HomeState {}
