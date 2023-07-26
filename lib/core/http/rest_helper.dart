import 'package:dio/dio.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/change_password_request_model.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/forget_password_request_model.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/validate_request_model.dart';
import 'package:kolobox_new_app/feature/auth/login/data/models/create_pin_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/earnings_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/select_product_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/top_up_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/update_profile_request_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../feature/auth/login/data/models/login_request_model.dart';
import '../../feature/auth/login/data/models/update_pin_request_model.dart';
import '../../feature/auth/register/data/models/register_request_model.dart';
import '../../feature/auth/register/data/models/verify_user_request_model.dart';
import '../../feature/dashboard/data/models/account_transfer_request_model.dart';
import '../../feature/dashboard/data/models/add_bank_request_model.dart';
import '../../feature/dashboard/data/models/create_family_request_model.dart';
import '../../feature/dashboard/data/models/create_family_user_request_model.dart';
import '../../feature/dashboard/data/models/create_group_request_model.dart';
import '../../feature/dashboard/data/models/create_investment_goal_request_model.dart';
import '../../feature/dashboard/data/models/delete_bank_request_model.dart';
import '../../feature/dashboard/data/models/get_family_user_request_model.dart';
import '../../feature/dashboard/data/models/group_invite_request_model.dart';
import '../../feature/dashboard/data/models/group_transactions_request_model.dart';
import '../../feature/dashboard/data/models/group_users_request_model.dart';
import '../../feature/dashboard/data/models/update_bank_request_model.dart';
import '../../feature/dashboard/data/models/update_password_request_model.dart';
import '../../feature/dashboard/data/models/verify_pin_request_model.dart';
import '../models/api_response.dart';
import 'api_constants.dart';

part 'rest_helper.g.dart';

//flutter pub run build_runner build
@RestApi(baseUrl: "")
abstract class RestHelper {
  factory RestHelper(Dio dio, {String? baseUrl}) = _RestHelper;

  @POST(ApiUrls.registerAPI)
  Future<ApiResponse> register(@Body() RegisterRequestModel model);

  @POST(ApiUrls.verifyCodeAPI)
  Future<ApiResponse> verifyCode(@Body() VerifyUserRequestModel model);

  @POST(ApiUrls.loginAPI)
  Future<ApiResponse> login(@Body() LoginRequestModel model);

  @POST(ApiUrls.forgetPasswordAPI)
  Future<ApiResponse> forgetPassword(@Body() ForgetPasswordRequestModel model);

  @POST(ApiUrls.passwordValidateAPI)
  Future<ApiResponse> validate(@Body() ValidateRequestModel model);

  @POST(ApiUrls.changePasswordAPI)
  Future<ApiResponse> changePassword(@Body() ChangePasswordRequestModel model);

  @GET(ApiUrls.walletAPI)
  Future<ApiResponse> wallet();

  @GET(ApiUrls.getProfileAPI)
  Future<ApiResponse> getProfile();

  @GET(ApiUrls.getProductAPI)
  Future<ApiResponse> getProducts();

  @GET(ApiUrls.getActiveProductAPI)
  Future<ApiResponse> getActiveProducts();

  @GET(ApiUrls.getMyEarningsAPI)
  Future<ApiResponse> getMyEarnings();

  @POST(ApiUrls.getEarningsAPI)
  Future<ApiResponse> getEarnings(@Body() EarningsRequestModel model);

  @POST(ApiUrls.getTransactionsAPI)
  Future<ApiResponse> getTransactions(@Body() TransactionsRequestModel model);

  @POST(ApiUrls.getGroupTransactionsAPI)
  Future<ApiResponse> getGroupTransactions(
      @Body() GroupTransactionsRequestModel model);

  @POST(ApiUrls.getGroupUsersAPI)
  Future<ApiResponse> getGroupUsers(@Body() GroupUsersRequestModel model);

  @POST(ApiUrls.getInviteGroupAPI)
  Future<ApiResponse> getInviteGroup(@Body() GroupInviteRequestModel model);

  @POST(ApiUrls.createPinAPI)
  Future<ApiResponse> createPin(@Body() CreatePinRequestModel model);

  @PUT(ApiUrls.createPinAPI)
  Future<ApiResponse> updatePin(@Body() UpdatePinRequestModel model);

  @POST(ApiUrls.verifyPinAPI)
  Future<ApiResponse> verifyPin(@Body() VerifyPinRequestModel model);

  @POST(ApiUrls.selectProductAPI)
  Future<ApiResponse> selectProduct(
      @Path("userId") String userId, @Body() SelectProductRequestModel model);

  @POST(ApiUrls.topUpAPI)
  Future<ApiResponse> topUp(
      @Path("productId") String productId, @Body() TopUpRequestModel model);

  @GET(ApiUrls.investmentGoalAPI)
  Future<ApiResponse> getInvestmentGoal();

  @POST(ApiUrls.investmentGoalAPI)
  Future<ApiResponse> createInvestmentGoal(
      @Body() CreateInvestmentGoalRequestModel model);

  @POST(ApiUrls.createGroupAPI)
  Future<ApiResponse> createGroup(@Body() CreateGroupRequestModel model);

  @POST(ApiUrls.createGroupAPI)
  Future<ApiResponse> createFamily(@Body() CreateFamilyRequestModel model);

  @POST(ApiUrls.getFamilyUserListAPI)
  Future<ApiResponse> getFamilyUserList(
      @Body() GetFamilyUserRequestModel model);

  @POST(ApiUrls.createFamilyUserListAPI)
  Future<ApiResponse> createFamilyUserList(
      @Body() CreateFamilyUserRequestModel model);

  // @GET(ApiUrls.getGroupListAPI)
  // Future<ApiResponse> getGroupList();

  @GET(ApiUrls.getGroupListAPI)
  Future<ApiResponse> getGroupList();

  @GET(ApiUrls.getFamilyListAPI)
  Future<ApiResponse> getFamilyList();

  @GET(ApiUrls.groupTypesAPI)
  Future<ApiResponse> getGroupTypes();

  @GET(ApiUrls.groupTenorsAPI)
  Future<ApiResponse> getGroupTenors();

  @GET(ApiUrls.getBanksAPI)
  Future<ApiResponse> getBanks();

  @GET(ApiUrls.getAllMyBanksAPI)
  Future<ApiResponse> getAllMyBanks();

  @POST(ApiUrls.getAllMyBanksAPI)
  Future<ApiResponse> addMyBanks(@Body() AddBankRequestModel model);

  @DELETE(ApiUrls.deleteMyBanksAPI)
  Future<ApiResponse> deleteMyBanks(
      @Path("bankId") String bankId, @Body() DeleteBankRequestModel model);

  @PUT(ApiUrls.deleteMyBanksAPI)
  Future<ApiResponse> updateMyBanks(
      @Path("bankId") String bankId, @Body() UpdateBankRequestModel model);

  @PUT(ApiUrls.updateProfileAPI)
  Future<ApiResponse> updateProfile(@Body() UpdateProfileRequestModel model);

  @PUT(ApiUrls.updatePasswordAPI)
  Future<ApiResponse> updatePassword(@Body() UpdatePasswordRequestModel model);

  @POST(ApiUrls.accountTransferAPI)
  Future<ApiResponse> accountTransfer(
      @Body() AccountTransferRequestModel model);
}
