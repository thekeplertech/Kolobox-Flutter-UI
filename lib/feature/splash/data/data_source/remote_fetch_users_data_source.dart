
import '../../../../core/models/api_response.dart';

abstract class RemoteFetchUsersDataSource {
  Future<ApiResponse> fetchUsers();
}
