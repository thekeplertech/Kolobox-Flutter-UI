import '../../data/models/wallet_data_model.dart';

abstract class HomeState {}

class InitialState extends HomeState {}

class CallWalletState extends HomeState {
  final WalletDataModel model;

  CallWalletState({required this.model});
}
