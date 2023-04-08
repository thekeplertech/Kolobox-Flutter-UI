import 'package:kolobox_new_app/feature/dashboard/data/models/active_product_data_model.dart';

import '../../feature/auth/login/data/models/login_response_model.dart';
import '../../feature/dashboard/data/models/product_data_model.dart';
import '../../feature/dashboard/data/models/profile_data_model.dart';

abstract class PrefHelper {
  LoginResponseModel getLoginResponseModel();

  Future<void> setLoginResponseModel(LoginResponseModel model);

  ProfileDataModel getProfileDataModel();

  Future<void> setProfileDataModel(ProfileDataModel model);

  ProductDataModel? getProductDataModel();

  Future<void> setProductDataModel(ProductDataModel model);

  ActiveProductDataModel? getActiveProductDataModel();

  Future<void> setActiveProductDataModel(ActiveProductDataModel model);

  String getToken();

  Future<void> setToken(String token);

  bool isLoggedIn();

  Future<bool> clear();
}
