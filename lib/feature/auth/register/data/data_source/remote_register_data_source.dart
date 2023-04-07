import 'package:kolobox_new_app/feature/auth/register/data/models/register_request_model.dart';
import 'package:kolobox_new_app/feature/auth/register/data/models/verify_user_request_model.dart';

import '../../../../../core/models/api_response.dart';

abstract class RemoteRegisterDataSource {
  Future<ApiResponse> register(RegisterRequestModel model);

  Future<ApiResponse> verifyCode(VerifyUserRequestModel model);
}
