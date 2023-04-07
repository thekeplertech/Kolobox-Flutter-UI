import 'package:dartz/dartz.dart';
import 'package:kolobox_new_app/feature/auth/register/data/models/register_request_model.dart';
import 'package:kolobox_new_app/feature/auth/register/data/models/verify_user_request_model.dart';

import '../../../../core/apirepo/base_api_repo.dart';
import '../../../../core/http/network_info.dart';
import '../../../../core/models/failure.dart';
import '../../../../core/models/success.dart';

abstract class RegisterRepo extends BaseApiRepo {
  RegisterRepo(NetworkInfo? networkInfo) : super(networkInfo);

  Future<Either<Failure, Success>> register(RegisterRequestModel model);

  Future<Either<Failure, Success>> verifyCode(VerifyUserRequestModel model);
}
