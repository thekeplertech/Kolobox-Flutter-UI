import 'package:kolobox_new_app/feature/auth/register/data/models/register_request_model.dart';
import 'package:kolobox_new_app/feature/auth/register/data/models/validate_code_request_model.dart';

import '../../../../../core/http/rest_client.dart';
import '../../../../../core/http/rest_helper.dart';
import '../../../../../core/models/api_response.dart';
import 'remote_register_data_source.dart';

class RemoteRegisterDataSourceImpl implements RemoteRegisterDataSource {
  final RestClient? restClient;

  RemoteRegisterDataSourceImpl({this.restClient});

  @override
  Future<ApiResponse> register(RegisterRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.register(model);
  }

  @override
  Future<ApiResponse> validateCode(ValidateCodeRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.validateCode(model);
  }
}
