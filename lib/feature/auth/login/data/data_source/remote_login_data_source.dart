import 'package:kolobox_new_app/feature/auth/login/data/models/create_pin_request_model.dart';

import '../../../../../core/models/api_response.dart';
import '../models/login_request_model.dart';

abstract class RemoteLoginDataSource {
  Future<ApiResponse> login(LoginRequestModel model);

  Future<ApiResponse> createPin(CreatePinRequestModel model);
}
