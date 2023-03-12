import '../../../../../core/http/rest_client.dart';
import '../../../../../core/http/rest_helper.dart';
import '../../../../../core/models/api_response.dart';
import '../models/change_password_request_model.dart';
import '../models/forget_password_request_model.dart';
import '../models/validate_request_model.dart';
import 'remote_forget_password_data_source.dart';

class RemoteForgetPasswordDataSourceImpl
    implements RemoteForgetPasswordDataSource {
  final RestClient? restClient;

  RemoteForgetPasswordDataSourceImpl({this.restClient});

  @override
  Future<ApiResponse> forgetPassword(ForgetPasswordRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.forgetPassword(model);
  }

  @override
  Future<ApiResponse> validate(ValidateRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.validate(model);
  }

  @override
  Future<ApiResponse> changePassword(ChangePasswordRequestModel model) async {
    RestHelper helper = await restClient!.getClient();
    return helper.changePassword(model);
  }
}
