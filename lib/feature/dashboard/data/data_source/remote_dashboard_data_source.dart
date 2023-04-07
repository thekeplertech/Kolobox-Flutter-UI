import '../../../../../core/models/api_response.dart';

abstract class RemoteDashboardDataSource {
  Future<ApiResponse> wallet();

  Future<ApiResponse> getProfile();

  Future<ApiResponse> getProducts();

  Future<ApiResponse> getActiveProducts();
}
