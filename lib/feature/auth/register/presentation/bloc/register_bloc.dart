import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/auth/register/data/models/register_response_model.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/bloc/master_event.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../../../dashboard/domain/dashboard_repo.dart';
import '../../domain/register_repo.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterRepo registerRepo = sl();
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();
  String registerInviteCode = '';

  RegisterBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<CallRegisterEvent>((event, emit) async {
      await callRegisterEvent(event, emit);
    });
    on<VerifyUserEvent>((event, emit) async {
      await callVerifyUserEvent(event, emit);
    });
    on<SaveUserEvent>((event, emit) async {
      await callSaveUserEvent(event, emit);
    });
  }

  Future<void> callRegisterEvent(CallRegisterEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await registerRepo.register(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      RegisterResponseModel model = r.model;
      registerInviteCode = model.inviteURL ?? '';
      registerInviteCode =
          registerInviteCode.substring(registerInviteCode.lastIndexOf('/') + 1);
      emit(CallRegisterState(model: model));
    });
  }

  Future<void> callVerifyUserEvent(VerifyUserEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    event.model.id = registerInviteCode;
    final result = await registerRepo.verifyCode(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(VerifyUserState());
    });
  }

  Future<void> callSaveUserEvent(SaveUserEvent event, Emitter emit) async {
    // For Save and login, below code
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getProfile();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(SaveUserState());
    });
  }
}
