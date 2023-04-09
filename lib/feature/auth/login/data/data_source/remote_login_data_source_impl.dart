import 'package:kolobox_new_app/feature/auth/login/data/models/login_request_model.dart';

import '../../../../../core/http/rest_client.dart';
import '../../../../../core/http/rest_helper.dart';
import '../../../../../core/models/api_response.dart';
import '../models/create_pin_request_model.dart';
import 'remote_login_data_source.dart';

class RemoteLoginDataSourceImpl implements RemoteLoginDataSource {
  final RestClient? restClient;

  RemoteLoginDataSourceImpl({this.restClient});

  @override
  Future<ApiResponse> login(LoginRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.login(model);
  }

  @override
  Future<ApiResponse> createPin(CreatePinRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.createPin(model);
  }
}
