import '../../../../dashboard/data/models/get_all_my_banks_response_model.dart';
import '../../../../dashboard/data/models/get_banks_response_model.dart';

abstract class BankDetailState {}

class InitialState extends BankDetailState {}

class GetAllBanksState extends BankDetailState {
  final GetBanksResponseModel model;

  GetAllBanksState({required this.model});
}

class GetAllMyBanksState extends BankDetailState {
  final GetAllMyBanksResponseModel model;

  GetAllMyBanksState({required this.model});
}

class AddMyBanksState extends BankDetailState {}

class DeleteMyBanksState extends BankDetailState {}
