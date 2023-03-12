import 'package:kolobox_new_app/feature/auth/forget_password/data/models/change_password_request_model.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/forget_password_request_model.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/validate_request_model.dart';

import '../../../../../core/models/api_response.dart';

abstract class RemoteForgetPasswordDataSource {
  Future<ApiResponse> forgetPassword(ForgetPasswordRequestModel model);

  Future<ApiResponse> validate(ValidateRequestModel model);

  Future<ApiResponse> changePassword(ChangePasswordRequestModel model);
}
