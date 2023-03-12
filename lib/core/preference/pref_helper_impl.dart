import '../../feature/auth/login/data/models/login_response_model.dart';
import 'pref_constants.dart';
import 'pref_helper.dart';
import 'prefs.dart';

class PrefHelperImpl implements PrefHelper {
  @override
  LoginResponseModel getLoginResponseModel() => LoginResponseModel(
        id: Prefs.getString(keyID, ''),
        active: Prefs.getBool(keyActive, false),
        firstname: Prefs.getString(keyFirstName, ''),
        lastname: Prefs.getString(keyLastName, ''),
        email: Prefs.getString(keyEmail, ''),
        dob: Prefs.getString(keyDOB, ''),
        phone: Prefs.getString(keyPhone, ''),
        occupation: Prefs.getString(keyOccupation, ''),
        wallet: Prefs.getString(keyWallet, ''),
        school: Prefs.getString(keySchool, ''),
        number: Prefs.getString(keyNumber, ''),
        nextOfKin: Prefs.getString(keyNextOfKin, ''),
        referral: Prefs.getString(keyReferral, ''),
        createdAt: Prefs.getString(keyCreatedAt, ''),
        updatedAt: Prefs.getString(keyUpdatedAt, ''),
        token: Prefs.getString(keyToken, ''),
        smsNotification: Prefs.getBool(keySMSNotification, false),
        emailNotification: Prefs.getBool(keyEmailNotification, false),
      );

  @override
  Future<void> setLoginResponseModel(LoginResponseModel model) async {
    await Prefs.setString(keyID, model.id ?? '');
    await Prefs.setBool(keyActive, model.active ?? false);
    await Prefs.setString(keyFirstName, model.firstname ?? '');
    await Prefs.setString(keyLastName, model.lastname ?? '');
    await Prefs.setString(keyEmail, model.email ?? '');
    await Prefs.setString(keyDOB, model.dob ?? '');
    await Prefs.setString(keyPhone, model.phone ?? '');
    await Prefs.setString(keyOccupation, model.occupation ?? '');
    await Prefs.setString(keyWallet, model.wallet ?? '');
    await Prefs.setString(keySchool, model.school ?? '');
    await Prefs.setString(keyNumber, model.number ?? '');
    await Prefs.setString(keyNextOfKin, model.nextOfKin ?? '');
    await Prefs.setString(keyReferral, model.referral ?? '');
    await Prefs.setString(keyCreatedAt, model.createdAt ?? '');
    await Prefs.setString(keyUpdatedAt, model.updatedAt ?? '');
    await Prefs.setString(keyToken, model.token ?? '');
    await Prefs.setBool(keySMSNotification, model.smsNotification ?? false);
    await Prefs.setBool(keyEmailNotification, model.emailNotification ?? false);
    await Prefs.setBool(keyLoggedIn, model.isLoggedIn);
  }

  @override
  bool isLoggedIn() => Prefs.getBool(keyLoggedIn, false);

  @override
  Future<bool> clear() async => await Prefs.clear();
}
