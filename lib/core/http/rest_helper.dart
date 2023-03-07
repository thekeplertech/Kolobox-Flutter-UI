import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart';

import '../models/api_response.dart';
import 'api_constants.dart';

part 'rest_helper.g.dart';

//flutter pub run build_runner build
@RestApi(baseUrl: "")
abstract class RestHelper {
  factory RestHelper(Dio dio, {String? baseUrl}) = _RestHelper;

  @GET(USERS_API)
  Future<ApiResponse> fetchUsers();

  @GET(PRODUCTS_API)
  Future<dynamic> loadProducts();

  @GET(ApiUrls.getSystemsAPI)
  Future<dynamic> getSystems();

  // @POST(ApiUrls.loginAPI)
  // Future<dynamic> login(@Body() LoginRequestModel model);

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
