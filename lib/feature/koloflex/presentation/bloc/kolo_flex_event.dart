import 'package:kolobox_new_app/feature/dashboard/data/models/group_invite_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_request_model.dart';

import '../../../dashboard/data/models/create_family_user_request_model.dart';
import '../../../dashboard/data/models/get_family_user_request_model.dart';
import '../../../dashboard/data/models/group_transactions_request_model.dart';
import '../../../dashboard/data/models/group_users_request_model.dart';

abstract class KoloFlexEvent {}

class GetTransactionsEvent extends KoloFlexEvent {
  final TransactionsRequestModel model;

  GetTransactionsEvent({required this.model});
}

class GetGroupTransactionsEvent extends KoloFlexEvent {
  final GroupTransactionsRequestModel model;

  GetGroupTransactionsEvent({required this.model});
}

class GetGroupUsersEvent extends KoloFlexEvent {
  final GroupUsersRequestModel model;

  GetGroupUsersEvent({required this.model});
}

class GetFamilyUsersEvent extends KoloFlexEvent {
  final GetFamilyUserRequestModel model;

  GetFamilyUsersEvent({required this.model});
}

class GroupInviteEvent extends KoloFlexEvent {
  final GroupInviteRequestModel model;

  GroupInviteEvent({required this.model});
}

class FamilyInviteEvent extends KoloFlexEvent {
  final CreateFamilyUserRequestModel model;

  FamilyInviteEvent({required this.model});
}
