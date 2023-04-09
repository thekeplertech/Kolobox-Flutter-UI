import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../../../core/bloc/master_event.dart';
import 'kolobox_event.dart';
import 'kolobox_state.dart';

class KoloboxBloc extends BaseBloc<KoloboxEvent, KoloboxState> {
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();
  bool isScreenLoaded = false;

  KoloboxBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<ClickOnKoloboxEvent>((event, emit) async {
      if (!isScreenLoaded) {
        isScreenLoaded = true;
        emit(ClickOnKoloboxState());
      }
    });
    on<CallEarningsEvent>((event, emit) async {
      await callEarningsEvent(event, emit);
    });
  }

  Future<void> callEarningsEvent(CallEarningsEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getEarnings(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(CallEarningsState(/*model: r.model*/));
    });
  }
}
