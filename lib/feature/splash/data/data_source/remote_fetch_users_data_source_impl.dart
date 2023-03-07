
import '../../../../core/http/rest_client.dart';
import '../../../../core/http/rest_helper.dart';
import '../../../../core/models/api_response.dart';
import 'remote_fetch_users_data_source.dart';

class RemoteFetchUsersDataSourceImpl implements RemoteFetchUsersDataSource {
  final RestClient? restClient;

  RemoteFetchUsersDataSourceImpl({this.restClient});

  @override
  Future<ApiResponse> fetchUsers() async {
    RestHelper helper = await restClient!.getClient();
    return helper.fetchUsers();
  }
}
