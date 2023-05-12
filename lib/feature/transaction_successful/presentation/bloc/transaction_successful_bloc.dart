import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../../../core/bloc/master_event.dart';
import 'transaction_successful_event.dart';
import 'transaction_successful_state.dart';

class TransactionSuccessfulBloc
    extends BaseBloc<TransactionSuccessfulEvent, TransactionSuccessfulState> {
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();

  TransactionSuccessfulBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<CallProductEvent>((event, emit) async {
      await callProductEvent(event, emit);
    });
  }

  Future<void> callProductEvent(CallProductEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    await helper.setHomeApiCall(false);
    await helper.setKoloboxApiCall(false);
    await helper.setWalletApiCall(false);
    await helper.setAccountApiCall(false);
    await dashboardRepo.getProducts();
    final result = await dashboardRepo.getActiveProducts();
    await dashboardRepo.getMyEarnings();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(CallProductState());
    });
  }
}
