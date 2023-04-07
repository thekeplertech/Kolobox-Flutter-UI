import 'package:dartz/dartz.dart';
import 'package:kolobox_new_app/feature/auth/register/data/data_source/remote_register_data_source.dart';
import 'package:kolobox_new_app/feature/auth/register/data/models/register_request_model.dart';
import 'package:kolobox_new_app/feature/auth/register/data/models/validate_code_request_model.dart';
import 'package:kolobox_new_app/feature/auth/register/domain/register_repo.dart';

import '../../../../../core/http/network_info.dart';
import '../../../../../core/models/failure.dart';
import '../../../../../core/models/success.dart';
import '../../../../../di/injection_container.dart';
import '../models/register_response_model.dart';

class RegisterRepoImpl extends RegisterRepo {
  RemoteRegisterDataSource remoteRegisterDataSource = sl();

  RegisterRepoImpl(NetworkInfo networkInfo) : super(networkInfo);

  @override
  Future<Either<Failure, Success>> register(RegisterRequestModel model) =>
      baseApiMethod(() => registerFromAPI(model));

  Future<Either<Failure, Success>> registerFromAPI(
      RegisterRequestModel model) async {
    RegisterResponseModel responseModel = RegisterResponseModel.fromJson(
        (await remoteRegisterDataSource.register(model)).data);
    return Right(Success(null /*responseModel*/));
  }

  @override
  Future<Either<Failure, Success>> verifyCode(ValidateCodeRequestModel model) =>
      baseApiMethod(() => verifyCodeFromAPI(model));

  Future<Either<Failure, Success>> verifyCodeFromAPI(
      ValidateCodeRequestModel model) async {
    dynamic apiResponse = await remoteRegisterDataSource.verifyCode(model);
    // LoginResponseModel responseModel =
    //     LoginResponseModel.fromJson(await remoteLoginDataSource.login(model));
    // PrefHelper helper = sl();
    // await helper.setLoginResponseModel(responseModel);
    return Right(Success(null /*responseModel*/));
  }
}
