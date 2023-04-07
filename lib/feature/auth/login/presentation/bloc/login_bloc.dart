import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/auth/login/domain/login_repo.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/bloc/master_event.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import 'login_event.dart';
import 'login_state.dart';

class LoginBloc extends BaseBloc<LoginEvent, LoginState> {
  LoginRepo loginRepo = sl();
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();

  LoginBloc(MasterBloc baseBlocObject) : super(baseBlocObject, InitialState()) {
    on<CallLoginEvent>((event, emit) async {
      await callLoginEvent(event, emit);
    });
  }

  Future<void> callLoginEvent(CallLoginEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await loginRepo.login(event.model);

    if (result.isRight()) {
      await dashboardRepo.getProfile();
    }
    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(CallLoginState(model: r.model));
    });
  }
}
