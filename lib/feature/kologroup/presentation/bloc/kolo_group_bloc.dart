import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../../../core/bloc/master_event.dart';
import 'kolo_group_event.dart';
import 'kolo_group_state.dart';

class KoloGroupBloc extends BaseBloc<KoloGroupEvent, KoloGroupState> {
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();

  KoloGroupBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<GetGroupEvent>((event, emit) async {
      await callGetGroupEvent(event, emit);
    });
  }

  Future<void> callGetGroupEvent(GetGroupEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getGroupList();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(GetGroupState(model: r.model));
    });
  }
}
