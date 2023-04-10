import 'package:dartz/dartz.dart';
import 'package:kolobox_new_app/core/models/api_response.dart';
import 'package:kolobox_new_app/feature/auth/login/data/models/login_response_model.dart';

import '../../../../../core/http/network_info.dart';
import '../../../../../core/models/failure.dart';
import '../../../../../core/models/success.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../domain/login_repo.dart';
import '../data_source/remote_login_data_source.dart';
import '../models/create_pin_request_model.dart';
import '../models/login_request_model.dart';

class LoginRepoImpl extends LoginRepo {
  RemoteLoginDataSource remoteLoginDataSource = sl();

  LoginRepoImpl(NetworkInfo networkInfo) : super(networkInfo);

  @override
  Future<Either<Failure, Success>> login(LoginRequestModel model) =>
      baseApiMethod(() => loginFromAPI(model));

  Future<Either<Failure, Success>> loginFromAPI(LoginRequestModel model) async {
    ApiResponse apiResponse = await remoteLoginDataSource.login(model);
    LoginResponseModel responseModel =
        LoginResponseModel.fromJson(apiResponse.data);
    responseModel.isLoggedIn = responseModel.isPin ?? false;
    PrefHelper helper = sl();
    await helper.setLoginResponseModel(responseModel);
    return Right(Success(responseModel));
  }

  @override
  Future<Either<Failure, Success>> createPin(CreatePinRequestModel model) =>
      baseApiMethod(() => createPinFromAPI(model));

  Future<Either<Failure, Success>> createPinFromAPI(
      CreatePinRequestModel model) async {
    ApiResponse apiResponse = await remoteLoginDataSource.createPin(model);
    // LoginResponseModel responseModel =
    //     LoginResponseModel.fromJson(apiResponse.data);
    // responseModel.isLoggedIn = false;
    // PrefHelper helper = sl();
    // await helper.setLoginResponseModel(responseModel);
    return Right(Success(null));
  }
}
