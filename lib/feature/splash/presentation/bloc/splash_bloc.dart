import '../../../../core/base/base_bloc.dart';
import '../../../../core/bloc/master_bloc.dart';
import '../../../../core/preference/pref_helper.dart';
import '../../../../di/injection_container.dart';
import '../../domain/splash_repo.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashRepo splashRepo = sl();
  PrefHelper helper = sl();

  SplashBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<WaitEvent>((event, emit) async {
      await Future.delayed(const Duration(milliseconds: 200));
      await helper.setHomeApiCall(false);
      await helper.setKoloboxApiCall(false);
      await helper.setWalletApiCall(false);
      await helper.setAccountApiCall(false);
      if (helper.isLoggedIn()) {
        emit(GoToDashboardState());
      } else {
        emit(GoToLoginState());
      }
    });
  }
}
