import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/auth/login/domain/login_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/bloc/master_event.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../domain/register_repo.dart';
import 'register_event.dart';
import 'register_state.dart';

class RegisterBloc extends BaseBloc<RegisterEvent, RegisterState> {
  RegisterRepo registerRepo = sl();
  PrefHelper helper = sl();

  RegisterBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<CallRegisterEvent>((event, emit) async {
      await callRegisterEvent(event, emit);
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
      emit(CallRegisterState(model: r.model));
    });
  }
}
