import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/auth/forget_password/domain/forget_password_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/bloc/master_event.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import 'forgot_password_event.dart';
import 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends BaseBloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgetPasswordRepo forgetPasswordRepo = sl();
  PrefHelper helper = sl();

  ForgotPasswordBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<CallForgotPasswordEvent>((event, emit) async {
      await callForgotPasswordEvent(event, emit);
    });
    on<ForgotPasswordValidateEvent>((event, emit) async {
      await callForgotPasswordValidateEvent(event, emit);
    });
    on<ChangePasswordEvent>((event, emit) async {
      await callChangePasswordEvent(event, emit);
    });
  }

  Future<void> callForgotPasswordEvent(
      CallForgotPasswordEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await forgetPasswordRepo.forgetPassword(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(CallForgotPasswordState(model: r.model));
    });
  }

  Future<void> callForgotPasswordValidateEvent(
      ForgotPasswordValidateEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await forgetPasswordRepo.validate(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(ForgotPasswordValidateState());
    });
  }

  Future<void> callChangePasswordEvent(
      ChangePasswordEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await forgetPasswordRepo.changePassword(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(ChangePasswordState(message: r.model));
    });
  }
}
