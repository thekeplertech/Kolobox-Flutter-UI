import 'package:kolobox_new_app/feature/dashboard/data/models/earnings_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/select_product_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/top_up_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/verify_pin_request_model.dart';

import '../../../../../core/models/api_response.dart';

abstract class RemoteDashboardDataSource {
  Future<ApiResponse> wallet();

  Future<ApiResponse> getProfile();

  Future<ApiResponse> getProducts();

  Future<ApiResponse> getActiveProducts();

  Future<ApiResponse> getEarnings(EarningsRequestModel model);

  Future<ApiResponse> getTransactions(TransactionsRequestModel model);

  Future<ApiResponse> verifyPin(VerifyPinRequestModel model);

  Future<ApiResponse> selectProduct(
      String userId, SelectProductRequestModel model);

  Future<ApiResponse> topUp(String productId, TopUpRequestModel model);
}
