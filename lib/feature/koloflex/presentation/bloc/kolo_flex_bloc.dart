import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../../../core/bloc/master_event.dart';
import 'kolo_flex_event.dart';
import 'kolo_flex_state.dart';

class KoloFlexBloc extends BaseBloc<KoloFlexEvent, KoloFlexState> {
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();

  KoloFlexBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<GetTransactionsEvent>((event, emit) async {
      await callTransactionsEvent(event, emit);
    });
    on<GetGroupTransactionsEvent>((event, emit) async {
      await callGroupTransactionsEvent(event, emit);
    });
    on<GetGroupUsersEvent>((event, emit) async {
      await callGroupUsersEvent(event, emit);
    });
    on<GetFamilyUsersEvent>((event, emit) async {
      await callFamilyUsersEvent(event, emit);
    });
    on<GroupInviteEvent>((event, emit) async {
      await callGroupInviteEvent(event, emit);
    });
    on<FamilyInviteEvent>((event, emit) async {
      await callFamilyInviteEvent(event, emit);
    });
  }

  Future<void> callTransactionsEvent(
      GetTransactionsEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getTransactions(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(GetTransactionsState(model: r.model));
    });
  }

  Future<void> callGroupTransactionsEvent(
      GetGroupTransactionsEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getGroupTransactions(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(GetGroupTransactionsState(model: r.model));
    });
  }

  Future<void> callGroupUsersEvent(
      GetGroupUsersEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getGroupUsers(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(GetGroupUsersState(model: r.model));
    });
  }

  Future<void> callFamilyUsersEvent(
      GetFamilyUsersEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getFamilyUserList(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(GetFamilyUsersState(model: r.model));
    });
  }

  Future<void> callGroupInviteEvent(
      GroupInviteEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getInviteGroup(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(GroupInviteState());
    });
  }

  Future<void> callFamilyInviteEvent(
      FamilyInviteEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.createFamilyUserList(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(FamilyInviteState());
    });
  }
}
