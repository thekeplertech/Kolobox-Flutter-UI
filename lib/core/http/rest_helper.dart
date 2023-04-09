import 'package:dio/dio.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/change_password_request_model.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/forget_password_request_model.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/validate_request_model.dart';
import 'package:kolobox_new_app/feature/auth/login/data/models/create_pin_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/earnings_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_request_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../feature/auth/login/data/models/login_request_model.dart';
import '../../feature/auth/register/data/models/register_request_model.dart';
import '../../feature/auth/register/data/models/verify_user_request_model.dart';
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

  @POST(ApiUrls.getEarningsAPI)
  Future<ApiResponse> getEarnings(@Body() EarningsRequestModel model);

  @POST(ApiUrls.getTransactionsAPI)
  Future<ApiResponse> getTransactions(@Body() TransactionsRequestModel model);

  @POST(ApiUrls.createPinAPI)
  Future<ApiResponse> createPin(@Body() CreatePinRequestModel model);

  @POST(ApiUrls.verifyPinAPI)
  Future<ApiResponse> verifyPin(@Body() VerifyPinRequestModel model);
}
