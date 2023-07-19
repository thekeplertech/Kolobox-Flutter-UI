import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../../../core/bloc/master_event.dart';
import 'kolo_family_event.dart';
import 'kolo_family_state.dart';

class KoloFamilyBloc extends BaseBloc<KoloFamilyEvent, KoloFamilyState> {
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();

  KoloFamilyBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<GetFamilyEvent>((event, emit) async {
      await callGetFamilyEvent(event, emit);
    });
  }

  Future<void> callGetFamilyEvent(GetFamilyEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getFamilyList();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(GetFamilyState(model: r.model));
    });
  }
}
