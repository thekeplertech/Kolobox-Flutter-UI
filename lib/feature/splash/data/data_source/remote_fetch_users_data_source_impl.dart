import '../../../../core/http/rest_client.dart';
import 'remote_fetch_users_data_source.dart';

class RemoteFetchUsersDataSourceImpl implements RemoteFetchUsersDataSource {
  final RestClient? restClient;

  RemoteFetchUsersDataSourceImpl({this.restClient});
}
