import 'package:kolobox_new_app/feature/dashboard/data/models/update_bank_request_model.dart';

import '../../../../dashboard/data/models/add_bank_request_model.dart';
import '../../../../dashboard/data/models/delete_bank_request_model.dart';

abstract class BankDetailEvent {}

class GetAllBanksEvent extends BankDetailEvent {}

class GetAllMyBanksEvent extends BankDetailEvent {}

class AddMyBanksEvent extends BankDetailEvent {
  final AddBankRequestModel model;

  AddMyBanksEvent({required this.model});
}

class DeleteMyBanksEvent extends BankDetailEvent {
  final String bankId;
  final DeleteBankRequestModel model;

  DeleteMyBanksEvent({required this.bankId, required this.model});
}

class UpdateMyBanksEvent extends BankDetailEvent {
  final String bankId;
  final UpdateBankRequestModel model;

  UpdateMyBanksEvent({required this.bankId, required this.model});
}
