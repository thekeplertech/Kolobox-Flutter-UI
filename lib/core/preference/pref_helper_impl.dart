import 'pref_constants.dart';
import 'pref_helper.dart';
import 'prefs.dart';

class PrefHelperImpl implements PrefHelper {
  // @override
  // LoginResponseModel getLoginResponseModel() => LoginResponseModel(
  //       id: Prefs.getString(keyID, ''),
  //       email: Prefs.getString(keyEmail, ''),
  //       userName: Prefs.getString(keyUserName, ''),
  //       token: Prefs.getString(keyToken, ''),
  //       name: Prefs.getString(keyName, ''),
  //       lastName: Prefs.getString(keyLastName, ''),
  //       roles: Prefs.getString(keyRoles, ''),
  //     );
  //
  // @override
  // Future<void> setLoginResponseModel(LoginResponseModel model) async {
  //   await Prefs.setString(keyID, model.id ?? '');
  //   await Prefs.setString(keyEmail, model.email ?? '');
  //   await Prefs.setString(keyUserName, model.userName ?? '');
  //   await Prefs.setString(keyToken, model.token ?? '');
  //   await Prefs.setString(keyName, model.name ?? '');
  //   await Prefs.setString(keyLastName, model.lastName ?? '');
  //   await Prefs.setString(keyRoles, model.roles ?? '');
  //   await Prefs.setBool(keyLoggedIn, true);
  // }

  @override
  bool isLoggedIn() => Prefs.getBool(keyLoggedIn, false);

  @override
  Future<bool> clear() async => await Prefs.clear();
}
