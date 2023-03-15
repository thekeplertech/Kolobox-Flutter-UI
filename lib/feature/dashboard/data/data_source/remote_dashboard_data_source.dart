import '../../../../../core/models/api_response.dart';

abstract class RemoteDashboardDataSource {
  Future<ApiResponse> wallet();
}
