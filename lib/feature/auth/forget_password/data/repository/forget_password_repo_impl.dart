import 'package:dartz/dartz.dart';
import 'package:kolobox_new_app/core/preference/pref_helper.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/data_source/remote_forget_password_data_source.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/data/models/forget_password_response_model.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/domain/forget_password_repo.dart';

import '../../../../../core/http/network_info.dart';
import '../../../../../core/models/failure.dart';
import '../../../../../core/models/success.dart';
import '../../../../../di/injection_container.dart';
import '../../../login/data/models/login_response_model.dart';
import '../models/change_password_request_model.dart';
import '../models/forget_password_request_model.dart';
import '../models/validate_request_model.dart';

class ForgetPasswordRepoImpl extends ForgetPasswordRepo {
  RemoteForgetPasswordDataSource remoteLoginDataSource = sl();

  ForgetPasswordRepoImpl(NetworkInfo networkInfo) : super(networkInfo);

  @override
  Future<Either<Failure, Success>> forgetPassword(
          ForgetPasswordRequestModel model) =>
      baseApiMethod(() => forgetPasswordFromAPI(model));

  Future<Either<Failure, Success>> forgetPasswordFromAPI(
      ForgetPasswordRequestModel model) async {
    ForgetPasswordResponseModel responseModel =
        ForgetPasswordResponseModel.fromJson(
            (await remoteLoginDataSource.forgetPassword(model)).data);
    PrefHelper helper = sl();
    await helper.setToken(responseModel.token ?? '');
    return Right(Success(responseModel));
  }

  @override
  Future<Either<Failure, Success>> validate(ValidateRequestModel model) =>
      baseApiMethod(() => validateFromAPI(model));

  Future<Either<Failure, Success>> validateFromAPI(
      ValidateRequestModel model) async {
    LoginResponseModel responseModel = LoginResponseModel.fromJson(
        (await remoteLoginDataSource.validate(model)).data);
    PrefHelper helper = sl();
    responseModel.isLoggedIn = false;
    await helper.setLoginResponseModel(responseModel);
    return Right(Success(null /*responseModel*/));
  }

  @override
  Future<Either<Failure, Success>> changePassword(
          ChangePasswordRequestModel model) =>
      baseApiMethod(() => changePasswordFromAPI(model));

  Future<Either<Failure, Success>> changePasswordFromAPI(
      ChangePasswordRequestModel model) async {
    return Right(
        Success((await remoteLoginDataSource.changePassword(model)).data));
  }
}
