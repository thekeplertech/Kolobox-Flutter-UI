import '../../../../dashboard/data/models/add_bank_request_model.dart';

abstract class BankDetailEvent {}

class GetAllBanksEvent extends BankDetailEvent {}

class GetAllMyBanksEvent extends BankDetailEvent {}

class AddMyBanksEvent extends BankDetailEvent {
  final AddBankRequestModel model;

  AddMyBanksEvent({required this.model});
}
