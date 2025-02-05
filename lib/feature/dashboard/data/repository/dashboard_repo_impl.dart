import 'package:dartz/dartz.dart';
import 'package:kolobox_new_app/feature/dashboard/data/data_source/remote_dashboard_data_source.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/create_group_response_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/earnings_data_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/get_all_my_banks_response_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/group_invite_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/top_up_response_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_data_model.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';
import 'package:kolobox_new_app/feature/home/data/models/wallet_data_model.dart';

import '../../../../../core/http/network_info.dart';
import '../../../../../core/models/failure.dart';
import '../../../../../core/models/success.dart';
import '../../../../../di/injection_container.dart';
import '../../../../core/enums/kolobox_fund_enum.dart';
import '../../../../core/models/api_response.dart';
import '../../../../core/preference/pref_helper.dart';
import '../../../auth/login/data/models/login_response_model.dart';
import '../models/account_transfer_request_model.dart';
import '../models/account_transfer_response_model.dart';
import '../models/active_product_data_model.dart';
import '../models/add_bank_request_model.dart';
import '../models/create_family_request_model.dart';
import '../models/create_family_response_model.dart';
import '../models/create_family_user_request_model.dart';
import '../models/create_group_request_model.dart';
import '../models/create_investment_goal_request_model.dart';
import '../models/delete_bank_request_model.dart';
import '../models/earnings_request_model.dart';
import '../models/get_banks_response_model.dart';
import '../models/get_family_user_list_response_model.dart';
import '../models/get_family_user_request_model.dart';
import '../models/get_group_list_response_model.dart';
import '../models/get_group_tenor_response_model.dart';
import '../models/get_group_type_response_model.dart';
import '../models/group_invite_data_model.dart';
import '../models/group_transactions_data_model.dart';
import '../models/group_transactions_request_model.dart';
import '../models/group_users_data_model.dart';
import '../models/group_users_request_model.dart';
import '../models/investment_goal_response_model.dart';
import '../models/my_earning_data_model.dart';
import '../models/product_data_model.dart';
import '../models/profile_data_model.dart';
import '../models/select_product_request_model.dart';
import '../models/select_product_response_model.dart';
import '../models/top_up_request_model.dart';
import '../models/transactions_request_model.dart';
import '../models/update_bank_request_model.dart';
import '../models/update_password_request_model.dart';
import '../models/update_profile_request_model.dart';
import '../models/verify_pin_request_model.dart';

class DashboardRepoImpl extends DashboardRepo {
  RemoteDashboardDataSource remoteDashboardDataSource = sl();

  DashboardRepoImpl(NetworkInfo networkInfo) : super(networkInfo);

  @override
  Future<Either<Failure, Success>> wallet() =>
      baseApiMethod(() => walletFromAPI());

  Future<Either<Failure, Success>> walletFromAPI() async =>
      Right(Success(WalletDataModel.fromJson(
          (await remoteDashboardDataSource.wallet()).data)));

  @override
  Future<Either<Failure, Success>> getProfile() =>
      baseApiMethod(() => getProfileFromAPI());

  Future<Either<Failure, Success>> getProfileFromAPI() async {
    ProfileDataModel model = ProfileDataModel.fromJson(
        (await remoteDashboardDataSource.getProfile()).data);
    PrefHelper helper = sl();
    // await helper.setLoginResponseModel(LoginResponseModel(
    //   id: model.user?.id ?? '',
    //   active: model.user?.active ?? false,
    //   firstname: model.user?.firstname ?? '',
    //   lastname: model.user?.lastname ?? '',
    //   email: model.user?.email ?? '',
    //   dob: model.user?.dob ?? '',
    //   phone: model.user?.phone ?? '',
    //   occupation: model.user?.occupation ?? '',
    //   wallet: model.user?.wallet ?? '',
    //   school: '',
    //   number: model.user?.number ?? '',
    //   nextOfKin: model.user?.nextOfKin ?? '',
    //   referral: '',
    //   createdAt: model.user?.createdAt ?? '',
    //   updatedAt: model.user?.updatedAt ?? '',
    //   smsNotification: model.user?.smsNotification ?? false,
    //   emailNotification: model.user?.emailNotification ?? false,
    //   token: helper.getToken(),
    // ));
    await helper.setProfileDataModel(model);
    return Right(Success(model));
  }

  @override
  Future<Either<Failure, Success>> getProducts() =>
      baseApiMethod(() => getProductsFromAPI());

  Future<Either<Failure, Success>> getProductsFromAPI() async {
    ProductDataModel model = ProductDataModel.fromJson(
        (await remoteDashboardDataSource.getProducts()).data);
    PrefHelper helper = sl();
    await helper.setProductDataModel(model);
    return Right(Success(model));
  }

  @override
  Future<Either<Failure, Success>> getActiveProducts() =>
      baseApiMethod(() => getActiveProductsFromAPI());

  Future<Either<Failure, Success>> getActiveProductsFromAPI() async {
    ActiveProductDataModel model = ActiveProductDataModel.fromJson(
        (await remoteDashboardDataSource.getActiveProducts()).data);
    PrefHelper helper = sl();
    await helper.setActiveProductDataModel(model);
    return Right(Success(model));
  }

  @override
  Future<Either<Failure, Success>> getMyEarnings() =>
      baseApiMethod(() => getMyEarningsFromAPI());

  Future<Either<Failure, Success>> getMyEarningsFromAPI() async {
    MyEarningDataModel model = MyEarningDataModel.fromJson(
        (await remoteDashboardDataSource.getMyEarnings()).data);
    PrefHelper helper = sl();
    await helper.setMyEarningDataModel(model);
    return Right(Success(model));
  }

  @override
  Future<Either<Failure, Success>> getEarnings(EarningsRequestModel model) =>
      baseApiMethod(() => getEarningsFromAPI(model));

  Future<Either<Failure, Success>> getEarningsFromAPI(
          EarningsRequestModel model) async =>
      Right(Success(EarningsDataModel.fromJson(
          (await remoteDashboardDataSource.getEarnings(model)).data)));

  @override
  Future<Either<Failure, Success>> getTransactions(
          TransactionsRequestModel model) =>
      baseApiMethod(() => getTransactionsFromAPI(model));

  Future<Either<Failure, Success>> getTransactionsFromAPI(
          TransactionsRequestModel model) async =>
      Right(Success(TransactionsDataModel.fromJson(
          (await remoteDashboardDataSource.getTransactions(model)).data)));

  @override
  Future<Either<Failure, Success>> getGroupTransactions(
          GroupTransactionsRequestModel model) =>
      baseApiMethod(() => getGroupTransactionsFromAPI(model));

  Future<Either<Failure, Success>> getGroupTransactionsFromAPI(
          GroupTransactionsRequestModel model) async =>
      Right(Success(GroupTransactionsDataModel.fromJson(
          (await remoteDashboardDataSource.getGroupTransactions(model)).data)));

  @override
  Future<Either<Failure, Success>> getGroupUsers(
          GroupUsersRequestModel model) =>
      baseApiMethod(() => getGroupUsersFromAPI(model));

  Future<Either<Failure, Success>> getGroupUsersFromAPI(
          GroupUsersRequestModel model) async =>
      Right(Success(GroupUsersDataModel.fromJson(
          (await remoteDashboardDataSource.getGroupUsers(model)).data)));

  @override
  Future<Either<Failure, Success>> getInviteGroup(
          GroupInviteRequestModel model) =>
      baseApiMethod(() => getInviteGroupFromAPI(model));

  Future<Either<Failure, Success>> getInviteGroupFromAPI(
          GroupInviteRequestModel model) async =>
      Right(Success(GroupInviteDataModel.fromJson(
          (await remoteDashboardDataSource.getInviteGroup(model)).data)));

  @override
  Future<Either<Failure, Success>> verifyPin(VerifyPinRequestModel model) =>
      baseApiMethod(() => verifyPinFromAPI(model));

  Future<Either<Failure, Success>> verifyPinFromAPI(
      VerifyPinRequestModel model) async {
    await remoteDashboardDataSource.verifyPin(model);
    return Right(Success(null));
  }

  @override
  Future<Either<Failure, Success>> selectProduct(
          String userId, SelectProductRequestModel model) =>
      baseApiMethod(() => selectProductFromAPI(userId, model));

  Future<Either<Failure, Success>> selectProductFromAPI(
          String userId, SelectProductRequestModel model) async =>
      Right(Success(SelectProductResponseModel.fromJson(
          (await remoteDashboardDataSource.selectProduct(userId, model))
              .data)));

  @override
  Future<Either<Failure, Success>> topUp(
          String productId, TopUpRequestModel model) =>
      baseApiMethod(() => topUpFromAPI(productId, model));

  Future<Either<Failure, Success>> topUpFromAPI(
          String productId, TopUpRequestModel model) async =>
      Right(Success(TopUpResponseModel.fromJson(
          (await remoteDashboardDataSource.topUp(productId, model)).data)));

  @override
  Future<Either<Failure, Success>> getInvestmentGoal() =>
      baseApiMethod(() => getInvestmentGoalFromAPI());

  Future<Either<Failure, Success>> getInvestmentGoalFromAPI() async {
    dynamic data = (await remoteDashboardDataSource.getInvestmentGoal()).data;

    if (data is Map<String, dynamic>) {
      return Right(Success(InvestmentGoalResponseModel.fromJson(data)));
    } else {
      return Right(Success(InvestmentGoalResponseModel.fromJson(null)));
    }
  }

  @override
  Future<Either<Failure, Success>> createInvestmentGoal(
          CreateInvestmentGoalRequestModel model) =>
      baseApiMethod(() => createInvestmentGoalFromAPI(model));

  Future<Either<Failure, Success>> createInvestmentGoalFromAPI(
      CreateInvestmentGoalRequestModel model) async {
    return Right(Success(
        (await remoteDashboardDataSource.createInvestmentGoal(model)).data));
  }

  @override
  Future<Either<Failure, Success>> createFamilyUserList(
          CreateFamilyUserRequestModel model) =>
      baseApiMethod(() => createFamilyUserListFromAPI(model));

  Future<Either<Failure, Success>> createFamilyUserListFromAPI(
      CreateFamilyUserRequestModel model) async {
    return Right(Success(
        (await remoteDashboardDataSource.createFamilyUserList(model)).data));
  }

  @override
  Future<Either<Failure, Success>> createGroup(CreateGroupRequestModel model) =>
      baseApiMethod(() => createGroupFromAPI(model));

  Future<Either<Failure, Success>> createGroupFromAPI(
      CreateGroupRequestModel model) async {
    GetGroupTypeResponseModel typeModel = GetGroupTypeResponseModel.fromJson(
        (await remoteDashboardDataSource.getGroupTypes()).data);
    List<GroupTypeModel> types = typeModel.types ?? [];
    int pos = types.indexWhere(
        (element) => element.name == KoloboxFundEnum.koloGroup.getProductName);
    if (pos != -1) {
      model.groupTypeId = types[pos].id ?? '';
    }
    return Right(Success(CreateGroupResponseModel.fromJson(
        (await remoteDashboardDataSource.createGroup(model)).data)));
  }

  @override
  Future<Either<Failure, Success>> createFamily(
          CreateFamilyRequestModel model) =>
      baseApiMethod(() => createFamilyFromAPI(model));

  Future<Either<Failure, Success>> createFamilyFromAPI(
      CreateFamilyRequestModel model) async {
    GetGroupTypeResponseModel typeModel = GetGroupTypeResponseModel.fromJson(
        (await remoteDashboardDataSource.getGroupTypes()).data);
    List<GroupTypeModel> types = typeModel.types ?? [];
    int pos = types.indexWhere(
        (element) => element.name == KoloboxFundEnum.koloFamily.getProductName);
    if (pos != -1) {
      model.groupTypeId = types[pos].id ?? '';
    }
    return Right(Success(CreateFamilyResponseModel.fromJson(
        (await remoteDashboardDataSource.createFamily(model)).data)));
  }

  @override
  Future<Either<Failure, Success>> getGroupTypes() =>
      baseApiMethod(() => getGroupTypesFromAPI());

  Future<Either<Failure, Success>> getGroupTypesFromAPI() async =>
      Right(Success(GetGroupTypeResponseModel.fromJson(
          (await remoteDashboardDataSource.getGroupTypes()).data)));

  @override
  Future<Either<Failure, Success>> getFamilyUserList(
          GetFamilyUserRequestModel model) =>
      baseApiMethod(() => getFamilyUserListFromAPI(model));

  Future<Either<Failure, Success>> getFamilyUserListFromAPI(
          GetFamilyUserRequestModel model) async =>
      Right(Success(GetFamilyUserListResponseModel.fromJson(
          (await remoteDashboardDataSource.getFamilyUserList(model)).data)));

  @override
  Future<Either<Failure, Success>> getGroupList() =>
      baseApiMethod(() => getGroupListFromAPI());

  Future<Either<Failure, Success>> getGroupListFromAPI() async {
    GetGroupListResponseModel model = GetGroupListResponseModel.fromJson(
        (await remoteDashboardDataSource.getGroupList()).data);

    PrefHelper helper = sl();
    MyEarningDataModel? earnings = helper.getMyEarningDataModel();

    if (model.types != null) {
      for (var group in model.types!) {
        group.isActive = false;
        if (earnings?.earnings != null) {
          for (var earning in earnings!.earnings!) {
            if (group.groupId == earning.groupId) {
              if ((earning.canceled ?? true) && (earning.verified ?? false)) {
                group.isActive = false;
                group.dob = earning.endStart;
              } else if (!(earning.canceled ?? true) &&
                  (earning.verified ?? false)) {
                group.isActive = true;
                group.dob = earning.endStart;
              }
            }
          }
        }
      }
    }
    return Right(Success(model));
  }

  @override
  Future<Either<Failure, Success>> getFamilyList() =>
      baseApiMethod(() => getFamilyListFromAPI());

  Future<Either<Failure, Success>> getFamilyListFromAPI() async {
    GetGroupListResponseModel model = GetGroupListResponseModel.fromJson(
        (await remoteDashboardDataSource.getFamilyList()).data);

    PrefHelper helper = sl();
    MyEarningDataModel? earnings = helper.getMyEarningDataModel();

    if (model.types != null) {
      for (var group in model.types!) {
        group.isActive = false;
        if (earnings?.earnings != null) {
          for (var earning in earnings!.earnings!) {
            if (group.groupId == earning.groupId) {
              if ((earning.canceled ?? true) && (earning.verified ?? false)) {
                group.isActive = false;
                group.dob = earning.endStart;
              } else if (!(earning.canceled ?? true) &&
                  (earning.verified ?? false)) {
                group.isActive = true;
                group.dob = earning.endStart;
              }
            }
          }
        }
      }
    }
    return Right(Success(model));
  }

  @override
  Future<Either<Failure, Success>> getGroupTenors() =>
      baseApiMethod(() => getGroupTenorsFromAPI());

  Future<Either<Failure, Success>> getGroupTenorsFromAPI() async =>
      Right(Success(GetGroupTenorResponseModel.fromJson(
          (await remoteDashboardDataSource.getGroupTenors()).data)));

  @override
  Future<Either<Failure, Success>> getBanks() =>
      baseApiMethod(() => getBanksFromAPI());

  Future<Either<Failure, Success>> getBanksFromAPI() async {
    return Right(Success(GetBanksResponseModel.fromJson(
        (await remoteDashboardDataSource.getBanks()).data)));
  }

  @override
  Future<Either<Failure, Success>> getAllMyBanks() =>
      baseApiMethod(() => getAllMyBanksFromAPI());

  Future<Either<Failure, Success>> getAllMyBanksFromAPI() async =>
      Right(Success(GetAllMyBanksResponseModel.fromJson(
          (await remoteDashboardDataSource.getAllMyBanks()).data)));

  @override
  Future<Either<Failure, Success>> addMyBanks(AddBankRequestModel model) =>
      baseApiMethod(() => addMyBanksFromAPI(model));

  Future<Either<Failure, Success>> addMyBanksFromAPI(
      AddBankRequestModel model) async {
    return Right(
        Success((await remoteDashboardDataSource.addMyBanks(model)).data));
  }

  @override
  Future<Either<Failure, Success>> deleteMyBanks(
          String bankId, DeleteBankRequestModel model) =>
      baseApiMethod(() => deleteMyBanksFromAPI(bankId, model));

  Future<Either<Failure, Success>> deleteMyBanksFromAPI(
      String bankId, DeleteBankRequestModel model) async {
    return Right(Success(
        (await remoteDashboardDataSource.deleteMyBanks(bankId, model)).data));
  }

  @override
  Future<Either<Failure, Success>> updateMyBanks(
          String bankId, UpdateBankRequestModel model) =>
      baseApiMethod(() => updateMyBanksFromAPI(bankId, model));

  Future<Either<Failure, Success>> updateMyBanksFromAPI(
      String bankId, UpdateBankRequestModel model) async {
    return Right(Success(
        (await remoteDashboardDataSource.updateMyBanks(bankId, model)).data));
  }

  @override
  Future<Either<Failure, Success>> updateProfile(
          UpdateProfileRequestModel model) =>
      baseApiMethod(() => updateProfileFromAPI(model));

  Future<Either<Failure, Success>> updateProfileFromAPI(
      UpdateProfileRequestModel model) async {
    ApiResponse apiResponse =
        await remoteDashboardDataSource.updateProfile(model);
    LoginResponseModel responseModel =
        LoginResponseModel.fromJson(apiResponse.data);
    responseModel.isLoggedIn = true;
    PrefHelper helper = sl();
    responseModel.token = helper.getLoginResponseModel().token;
    await helper.setLoginResponseModel(responseModel);
    return Right(Success(responseModel));
  }

  @override
  Future<Either<Failure, Success>> updatePassword(
          UpdatePasswordRequestModel model) =>
      baseApiMethod(() => updatePasswordFromAPI(model));

  Future<Either<Failure, Success>> updatePasswordFromAPI(
      UpdatePasswordRequestModel model) async {
    return Right(
        Success((await remoteDashboardDataSource.updatePassword(model)).data));
  }

  @override
  Future<Either<Failure, Success>> accountTransfer(
          AccountTransferRequestModel model) =>
      baseApiMethod(() => accountTransferFromAPI(model));

  Future<Either<Failure, Success>> accountTransferFromAPI(
      AccountTransferRequestModel model) async {
    return Right(Success(AccountTransferResponseModel.fromJson(
        (await remoteDashboardDataSource.accountTransfer(model)).data)));
  }
}
