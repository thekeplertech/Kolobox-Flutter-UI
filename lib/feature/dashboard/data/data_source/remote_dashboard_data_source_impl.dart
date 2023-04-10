import 'package:kolobox_new_app/feature/dashboard/data/models/select_product_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/top_up_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/verify_pin_request_model.dart';

import '../../../../../core/http/rest_client.dart';
import '../../../../../core/http/rest_helper.dart';
import '../../../../../core/models/api_response.dart';
import '../models/earnings_request_model.dart';
import '../models/transactions_request_model.dart';
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
}
