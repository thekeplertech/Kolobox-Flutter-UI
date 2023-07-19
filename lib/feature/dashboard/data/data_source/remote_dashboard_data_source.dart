import 'package:kolobox_new_app/feature/dashboard/data/models/create_group_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/create_investment_goal_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/earnings_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/group_invite_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/select_product_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/top_up_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/verify_pin_request_model.dart';

import '../../../../../core/models/api_response.dart';
import '../models/add_bank_request_model.dart';
import '../models/create_family_request_model.dart';
import '../models/create_family_user_request_model.dart';
import '../models/delete_bank_request_model.dart';
import '../models/get_family_user_request_model.dart';
import '../models/group_transactions_request_model.dart';
import '../models/group_users_request_model.dart';
import '../models/update_bank_request_model.dart';
import '../models/update_password_request_model.dart';
import '../models/update_profile_request_model.dart';

abstract class RemoteDashboardDataSource {
  Future<ApiResponse> wallet();

  Future<ApiResponse> getProfile();

  Future<ApiResponse> getProducts();

  Future<ApiResponse> getActiveProducts();

  Future<ApiResponse> getMyEarnings();

  Future<ApiResponse> getEarnings(EarningsRequestModel model);

  Future<ApiResponse> getTransactions(TransactionsRequestModel model);

  Future<ApiResponse> getGroupTransactions(GroupTransactionsRequestModel model);

  Future<ApiResponse> getGroupUsers(GroupUsersRequestModel model);

  Future<ApiResponse> getInviteGroup(GroupInviteRequestModel model);

  Future<ApiResponse> verifyPin(VerifyPinRequestModel model);

  Future<ApiResponse> selectProduct(
      String userId, SelectProductRequestModel model);

  Future<ApiResponse> topUp(String productId, TopUpRequestModel model);

  Future<ApiResponse> getInvestmentGoal();

  Future<ApiResponse> createInvestmentGoal(
      CreateInvestmentGoalRequestModel model);

  Future<ApiResponse> createGroup(CreateGroupRequestModel model);

  Future<ApiResponse> createFamily(CreateFamilyRequestModel model);

  Future<ApiResponse> getFamilyUserList(GetFamilyUserRequestModel model);

  Future<ApiResponse> createFamilyUserList(CreateFamilyUserRequestModel model);

  Future<ApiResponse> getGroupTypes();

  Future<ApiResponse> getGroupList();

  Future<ApiResponse> getFamilyList();

  Future<ApiResponse> getGroupTenors();

  Future<ApiResponse> getBanks();

  Future<ApiResponse> getAllMyBanks();

  Future<ApiResponse> addMyBanks(AddBankRequestModel model);

  Future<ApiResponse> deleteMyBanks(
      String bankId, DeleteBankRequestModel model);

  Future<ApiResponse> updateMyBanks(
      String bankId, UpdateBankRequestModel model);

  Future<ApiResponse> updateProfile(UpdateProfileRequestModel model);

  Future<ApiResponse> updatePassword(UpdatePasswordRequestModel model);
}
