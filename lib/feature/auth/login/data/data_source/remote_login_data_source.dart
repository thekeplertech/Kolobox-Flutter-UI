import '../../../../../core/models/api_response.dart';
import '../models/login_request_model.dart';

abstract class RemoteLoginDataSource {
  Future<ApiResponse> login(LoginRequestModel model);
}
