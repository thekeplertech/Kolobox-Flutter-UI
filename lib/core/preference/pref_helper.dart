import '../../feature/auth/login/data/models/login_response_model.dart';

abstract class PrefHelper {
  LoginResponseModel getLoginResponseModel();

  Future<void> setLoginResponseModel(LoginResponseModel model);

  bool isLoggedIn();

  Future<bool> clear();
}
