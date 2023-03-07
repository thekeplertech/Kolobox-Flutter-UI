import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/base/base_bloc.dart';
import '../../../../core/bloc/master_bloc.dart';
import '../../../../core/bloc/master_event.dart';
import '../../../../core/preference/pref_helper.dart';
import '../../../../di/injection_container.dart';
import '../../../../routes/routes.dart';
import '../../domain/splash_repo.dart';
import 'splash_event.dart';
import 'splash_state.dart';

class SplashBloc extends BaseBloc<SplashEvent, SplashState> {
  SplashRepo splashRepo = sl();
  PrefHelper helper = sl();

  SplashBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<WaitEvent>((event, emit) async {
      await Future.delayed(const Duration(seconds: 2));
      emit(WaitState());
    });
  }

  Future<void> fetchUsers(FetchUsersEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final loadedPensionData = await splashRepo.fetchUsers();

    loadedPensionData.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      logger?.d("response ${r.model}");
      emit(FetchUsersState());
    });
  }
}
