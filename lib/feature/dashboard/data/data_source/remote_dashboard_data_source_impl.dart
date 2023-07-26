import 'package:kolobox_new_app/feature/dashboard/data/models/delete_bank_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/group_invite_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/select_product_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/top_up_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/update_profile_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/verify_pin_request_model.dart';

import '../../../../../core/http/rest_client.dart';
import '../../../../../core/http/rest_helper.dart';
import '../../../../../core/models/api_response.dart';
import '../models/account_transfer_request_model.dart';
import '../models/add_bank_request_model.dart';
import '../models/create_family_request_model.dart';
import '../models/create_family_user_request_model.dart';
import '../models/create_group_request_model.dart';
import '../models/create_investment_goal_request_model.dart';
import '../models/earnings_request_model.dart';
import '../models/get_family_user_request_model.dart';
import '../models/group_transactions_request_model.dart';
import '../models/group_users_request_model.dart';
import '../models/transactions_request_model.dart';
import '../models/update_bank_request_model.dart';
import '../models/update_password_request_model.dart';
import 'remote_dashboard_data_source.dart';

class RemoteDashboardDataSourceImpl implements RemoteDashboardDataSource {
  final RestClient? restClient;

  RemoteDashboardDataSourceImpl({this.restClient});

  @override
  Future<ApiResponse> wallet() async {
    RestHelper helper = await restClient!.getClient();
    return helper.wallet();
  }

  @override
  Future<ApiResponse> getProfile() async {
    RestHelper helper = await restClient!.getClient();
    return helper.getProfile();
  }

  @override
  Future<ApiResponse> getProducts() async {
    RestHelper helper = await restClient!.getClient();
    return helper.getProducts();
  }

  @override
  Future<ApiResponse> getActiveProducts() async {
    RestHelper helper = await restClient!.getClient();
    return helper.getActiveProducts();
  }

  @override
  Future<ApiResponse> getMyEarnings() async {
    RestHelper helper = await restClient!.getClient();
    return helper.getMyEarnings();
  }

  @override
  Future<ApiResponse> getEarnings(EarningsRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.getEarnings(model);
  }

  @override
  Future<ApiResponse> getTransactions(TransactionsRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.getTransactions(model);
  }

  @override
  Future<ApiResponse> getGroupTransactions(
      GroupTransactionsRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.getGroupTransactions(model);
  }

  @override
  Future<ApiResponse> getGroupUsers(GroupUsersRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.getGroupUsers(model);
  }

  @override
  Future<ApiResponse> getInviteGroup(GroupInviteRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.getInviteGroup(model);
  }

  @override
  Future<ApiResponse> verifyPin(VerifyPinRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.verifyPin(model);
  }

  @override
  Future<ApiResponse> selectProduct(
      String userId, SelectProductRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.selectProduct(userId, model);
  }

  @override
  Future<ApiResponse> topUp(String productId, TopUpRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.topUp(productId, model);
  }

  @override
  Future<ApiResponse> getInvestmentGoal() async {
    RestHelper helper = await restClient!.getClient();
    return helper.getInvestmentGoal();
  }

  @override
  Future<ApiResponse> createInvestmentGoal(
      CreateInvestmentGoalRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.createInvestmentGoal(model);
  }

  @override
  Future<ApiResponse> createGroup(CreateGroupRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.createGroup(model);
  }

  @override
  Future<ApiResponse> createFamily(CreateFamilyRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.createFamily(model);
  }

  @override
  Future<ApiResponse> getFamilyUserList(GetFamilyUserRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.getFamilyUserList(model);
  }

  @override
  Future<ApiResponse> createFamilyUserList(
      CreateFamilyUserRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.createFamilyUserList(model);
  }

  @override
  Future<ApiResponse> getGroupTypes() async {
    RestHelper helper = await restClient!.getClient();
    return helper.getGroupTypes();
  }

  @override
  Future<ApiResponse> getGroupList() async {
    RestHelper helper = await restClient!.getClient();
    return helper.getGroupList();
  }

  @override
  Future<ApiResponse> getFamilyList() async {
    RestHelper helper = await restClient!.getClient();
    return helper.getFamilyList();
  }

  @override
  Future<ApiResponse> getGroupTenors() async {
    RestHelper helper = await restClient!.getClient();
    return helper.getGroupTenors();
  }

  @override
  Future<ApiResponse> getBanks() async {
    RestHelper helper = await restClient!.getClient();
    return helper.getBanks();
  }

  @override
  Future<ApiResponse> getAllMyBanks() async {
    RestHelper helper = await restClient!.getClient();
    return helper.getAllMyBanks();
  }

  @override
  Future<ApiResponse> addMyBanks(AddBankRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.addMyBanks(model);
  }

  @override
  Future<ApiResponse> deleteMyBanks(
      String bankId, DeleteBankRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.deleteMyBanks(bankId, model);
  }

  @override
  Future<ApiResponse> updateMyBanks(
      String bankId, UpdateBankRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.updateMyBanks(bankId, model);
  }

  @override
  Future<ApiResponse> updateProfile(UpdateProfileRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.updateProfile(model);
  }

  @override
  Future<ApiResponse> updatePassword(UpdatePasswordRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.updatePassword(model);
  }

  @override
  Future<ApiResponse> accountTransfer(AccountTransferRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.accountTransfer(model);
  }
}
