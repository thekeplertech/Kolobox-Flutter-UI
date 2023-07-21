import '../../../home/data/models/wallet_data_model.dart';

abstract class WalletState {}

class InitialState extends WalletState {}

class ClickOnWalletState extends WalletState {}

class GetWalletHistoryState extends WalletState {
  final WalletDataModel model;

  GetWalletHistoryState({required this.model});
}

class GetProfileState extends WalletState {}
