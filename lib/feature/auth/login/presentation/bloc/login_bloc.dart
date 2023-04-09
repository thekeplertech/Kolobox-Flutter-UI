import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/auth/login/domain/login_repo.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/bloc/master_event.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../data/models/login_response_model.dart';
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
    on<CallCreatePinEvent>((event, emit) async {
      await callCreatePinEvent(event, emit);
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
      LoginResponseModel model = r.model;
      if (model.isPin ?? false) {
        emit(CallLoginState(model: model));
      } else {
        emit(CreatePinState(model: model));
      }
    });
  }

  Future<void> callCreatePinEvent(
      CallCreatePinEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await loginRepo.createPin(event.createPinRequestModel);

    if (result.isRight()) {
      event.loginResponseModel.isLoggedIn = true;
      await helper.setLoginResponseModel(event.loginResponseModel);
    }
    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(CallLoginState(model: event.loginResponseModel, isPinSet: true));
    });
  }
}
