import '../../../../../core/http/rest_client.dart';
import '../../../../../core/http/rest_helper.dart';
import '../../../../../core/models/api_response.dart';
import 'remote_dashboard_data_source.dart';

class RemoteDashboardDataSourceImpl implements RemoteDashboardDataSource {
  final RestClient? restClient;

  RemoteDashboardDataSourceImpl({this.restClient});

  @override
  Future<ApiResponse> wallet() async {
    RestHelper helper = await restClient!.getClient();
    return helper.wallet();
  }
}
