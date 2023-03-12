import 'package:dartz/dartz.dart';

import '../../../../core/apirepo/base_api_repo.dart';
import '../../../../core/http/network_info.dart';
import '../../../../core/models/failure.dart';
import '../../../../core/models/success.dart';
import '../data/models/change_password_request_model.dart';
import '../data/models/forget_password_request_model.dart';
import '../data/models/validate_request_model.dart';

abstract class ForgetPasswordRepo extends BaseApiRepo {
  ForgetPasswordRepo(NetworkInfo? networkInfo) : super(networkInfo);

  Future<Either<Failure, Success>> forgetPassword(
      ForgetPasswordRequestModel model);

  Future<Either<Failure, Success>> validate(ValidateRequestModel model);

  Future<Either<Failure, Success>> changePassword(
      ChangePasswordRequestModel model);
}
