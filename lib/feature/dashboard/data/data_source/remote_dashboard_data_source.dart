import 'package:kolobox_new_app/feature/dashboard/data/models/earnings_request_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/transactions_request_model.dart';

import '../../../../../core/models/api_response.dart';

abstract class RemoteDashboardDataSource {
  Future<ApiResponse> wallet();

  Future<ApiResponse> getProfile();

  Future<ApiResponse> getProducts();

  Future<ApiResponse> getActiveProducts();

  Future<ApiResponse> getWallet();

  Future<ApiResponse> getEarnings(EarningsRequestModel model);

  Future<ApiResponse> getTransactions(TransactionsRequestModel model);
}
