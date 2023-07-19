import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_data_model.dart';

import '../../../dashboard/data/models/get_family_user_list_response_model.dart';
import '../../../dashboard/data/models/group_transactions_data_model.dart';
import '../../../dashboard/data/models/group_users_data_model.dart';

abstract class KoloFlexState {}

class InitialState extends KoloFlexState {}

class GetTransactionsState extends KoloFlexState {
  final TransactionsDataModel model;

  GetTransactionsState({required this.model});
}

class GetGroupTransactionsState extends KoloFlexState {
  final GroupTransactionsDataModel model;

  GetGroupTransactionsState({required this.model});
}

class GetGroupUsersState extends KoloFlexState {
  final GroupUsersDataModel model;

  GetGroupUsersState({required this.model});
}

class GetFamilyUsersState extends KoloFlexState {
  final GetFamilyUserListResponseModel model;

  GetFamilyUsersState({required this.model});
}

class GroupInviteState extends KoloFlexState {}

class FamilyInviteState extends KoloFlexState {}
