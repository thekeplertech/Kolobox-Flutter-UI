import 'package:dio/dio.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/change_password_request_model.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/forget_password_request_model.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/validate_request_model.dart';
import 'package:retrofit/retrofit.dart';

import '../../feature/auth/login/data/models/login_request_model.dart';
import '../../feature/auth/register/data/models/register_request_model.dart';
import '../../feature/auth/register/data/models/verify_user_request_model.dart';
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

  @GET(USERS_API)
  Future<ApiResponse> fetchUsers();

  @GET(PRODUCTS_API)
  Future<dynamic> loadProducts();

  @GET(ApiUrls.getSystemsAPI)
  Future<dynamic> getSystems();

  @GET(ApiUrls.getPVSystemsAPI)
  Future<dynamic> getPVSystems();

  @GET(ApiUrls.getPVSystemImageAPI)
  Future<dynamic> getPVSystemImage(@Path("id") String id);

  @GET(ApiUrls.getPVSystemFlowData)
  Future<dynamic> getPotenciaActual(@Path("id") String id);

  @GET(ApiUrls.getWeatherCurrent)
  Future<dynamic> getWeatherAPI(@Path("id") String id);

  @GET(ApiUrls.getEconomicTotals)
  Future<dynamic> getEconomicTotals(@Path("id") String id);

  @GET(ApiUrls.getPVSystemAggDataTotal)
  Future<dynamic> getPVSystemAggDataTotal(@Path("id") String id);

  @GET(ApiUrls.getPowerBalanceCurrent)
  Future<dynamic> getPowerBalanceCurrent(@Path("id") String id);

  @GET(ApiUrls.getPowerBalanceDay)
  Future<dynamic> getPowerBalanceDay(
      @Path("id") String id,
      @Path("year") String year,
      @Path("month") String month,
      @Path("day") String day);

  @GET(ApiUrls.getPowerBalanceMonth)
  Future<dynamic> getPowerBalanceMonth(@Path("id") String id,
      @Path("year") String year, @Path("month") String month);

  @GET(ApiUrls.getPowerBalanceYear)
  Future<dynamic> getPowerBalanceYear(
      @Path("id") String id, @Path("year") String year);

  @GET(ApiUrls.getPowerBalanceTotal)
  Future<dynamic> getPowerBalanceTotal(@Path("id") String id);
}
