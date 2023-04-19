import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/bloc/master_event.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import 'bank_detail_event.dart';
import 'bank_detail_state.dart';

class BankDetailBloc extends BaseBloc<BankDetailEvent, BankDetailState> {
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();

  BankDetailBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<GetAllBanksEvent>((event, emit) async {
      await callGetAllBanksEvent(event, emit);
    });
    on<GetAllMyBanksEvent>((event, emit) async {
      await callGetAllMyBanksEvent(event, emit);
    });
    on<AddMyBanksEvent>((event, emit) async {
      await callAddMyBanksEvent(event, emit);
    });
    on<DeleteMyBanksEvent>((event, emit) async {
      await callDeleteMyBanksEvent(event, emit);
    });
    on<UpdateMyBanksEvent>((event, emit) async {
      await callUpdateMyBanksEvent(event, emit);
    });
  }

  Future<void> callGetAllMyBanksEvent(
      GetAllMyBanksEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getAllMyBanks();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(GetAllMyBanksState(model: r.model));
    });
  }

  Future<void> callGetAllBanksEvent(
      GetAllBanksEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getBanks();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(GetAllBanksState(model: r.model));
    });
  }

  Future<void> callAddMyBanksEvent(AddMyBanksEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.addMyBanks(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(AddMyBanksState());
    });
  }

  Future<void> callDeleteMyBanksEvent(
      DeleteMyBanksEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.deleteMyBanks(event.bankId, event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(DeleteMyBanksState());
    });
  }

  Future<void> callUpdateMyBanksEvent(
      UpdateMyBanksEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.updateMyBanks(event.bankId, event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(UpdateMyBanksState());
    });
  }
}
