import 'package:dartz/dartz.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/create_investment_goal_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/group_invite_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/verify_pin_request_model.dart';

import '../../../../core/apirepo/base_api_repo.dart';
import '../../../../core/http/network_info.dart';
import '../../../../core/models/failure.dart';
import '../../../../core/models/success.dart';
import '../data/models/account_transfer_request_model.dart';
import '../data/models/add_bank_request_model.dart';
import '../data/models/create_family_request_model.dart';
import '../data/models/create_family_user_request_model.dart';
import '../data/models/create_group_request_model.dart';
import '../data/models/delete_bank_request_model.dart';
import '../data/models/earnings_request_model.dart';
import '../data/models/get_family_user_request_model.dart';
import '../data/models/group_transactions_request_model.dart';
import '../data/models/group_users_request_model.dart';
import '../data/models/select_product_request_model.dart';
import '../data/models/top_up_request_model.dart';
import '../data/models/transactions_request_model.dart';
import '../data/models/update_bank_request_model.dart';
import '../data/models/update_password_request_model.dart';
import '../data/models/update_profile_request_model.dart';

abstract class DashboardRepo extends BaseApiRepo {
  DashboardRepo(NetworkInfo? networkInfo) : super(networkInfo);

  Future<Either<Failure, Success>> wallet();

  Future<Either<Failure, Success>> getProfile();

  Future<Either<Failure, Success>> getProducts();

  Future<Either<Failure, Success>> getActiveProducts();

  Future<Either<Failure, Success>> getMyEarnings();

  Future<Either<Failure, Success>> getEarnings(EarningsRequestModel model);

  Future<Either<Failure, Success>> getTransactions(
      TransactionsRequestModel model);

  Future<Either<Failure, Success>> getGroupTransactions(
      GroupTransactionsRequestModel model);

  Future<Either<Failure, Success>> getGroupUsers(GroupUsersRequestModel model);

  Future<Either<Failure, Success>> getInviteGroup(
      GroupInviteRequestModel model);

  Future<Either<Failure, Success>> verifyPin(VerifyPinRequestModel model);

  Future<Either<Failure, Success>> selectProduct(
      String userId, SelectProductRequestModel model);

  Future<Either<Failure, Success>> topUp(
      String productId, TopUpRequestModel model);

  Future<Either<Failure, Success>> getInvestmentGoal();

  Future<Either<Failure, Success>> createInvestmentGoal(
      CreateInvestmentGoalRequestModel model);

  Future<Either<Failure, Success>> createFamilyUserList(
      CreateFamilyUserRequestModel model);

  Future<Either<Failure, Success>> createGroup(CreateGroupRequestModel model);

  Future<Either<Failure, Success>> createFamily(CreateFamilyRequestModel model);

  Future<Either<Failure, Success>> getGroupTypes();

  Future<Either<Failure, Success>> getGroupList();

  Future<Either<Failure, Success>> getFamilyList();

  Future<Either<Failure, Success>> getFamilyUserList(
      GetFamilyUserRequestModel model);

  Future<Either<Failure, Success>> getGroupTenors();

  Future<Either<Failure, Success>> getBanks();

  Future<Either<Failure, Success>> getAllMyBanks();

  Future<Either<Failure, Success>> addMyBanks(AddBankRequestModel model);

  Future<Either<Failure, Success>> deleteMyBanks(
      String bankId, DeleteBankRequestModel model);

  Future<Either<Failure, Success>> updateMyBanks(
      String bankId, UpdateBankRequestModel model);

  Future<Either<Failure, Success>> updateProfile(
      UpdateProfileRequestModel model);

  Future<Either<Failure, Success>> updatePassword(
      UpdatePasswordRequestModel model);

  Future<Either<Failure, Success>> accountTransfer(
      AccountTransferRequestModel model);
}
