import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../../../core/bloc/master_event.dart';
import 'kolo_target_event.dart';
import 'kolo_target_state.dart';

class KoloTargetBloc extends BaseBloc<KoloTargetEvent, KoloTargetState> {
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();

  KoloTargetBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<GetGoalEvent>((event, emit) async {
      await callGetGoalEvent(event, emit);
    });
  }

  Future<void> callGetGoalEvent(GetGoalEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getInvestmentGoalAPI();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(GetGoalState(model: r.model));
    });
  }
}
