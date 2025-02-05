import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../../../core/bloc/master_event.dart';
import 'wallet_event.dart';
import 'wallet_state.dart';

class WalletBloc extends BaseBloc<WalletEvent, WalletState> {
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();

  WalletBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<ClickOnWalletEvent>((event, emit) async {
      if (!helper.isWalletApiCall()) {
        await helper.setWalletApiCall(true);
        emit(ClickOnWalletState());
      }
    });
    on<GetWalletHistoryEvent>((event, emit) async {
      await callWalletHistoryEvent(event, emit);
    });
    on<GetProfileEvent>((event, emit) async {
      await callGetProfileEvent(event, emit);
    });
  }

  Future<void> callWalletHistoryEvent(
      GetWalletHistoryEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.wallet();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(GetWalletHistoryState(model: r.model));
    });
  }

  Future<void> callGetProfileEvent(GetProfileEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getProfile();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(GetProfileState());
    });
  }
}
