import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/bloc/master_event.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();

  HomeBloc(MasterBloc baseBlocObject) : super(baseBlocObject, InitialState()) {
    on<CallWalletEvent>((event, emit) async {
      await callWalletEvent(event, emit);
    });
  }

  Future<void> callWalletEvent(CallWalletEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.wallet();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(CallWalletState(model: r.model));
    });
  }
}
