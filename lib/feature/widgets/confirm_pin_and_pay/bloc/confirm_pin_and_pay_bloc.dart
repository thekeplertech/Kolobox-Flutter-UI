import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../../../core/bloc/master_event.dart';
import 'confirm_pin_and_pay_event.dart';
import 'confirm_pin_and_pay_state.dart';

class ConfirmPinAndPayBloc
    extends BaseBloc<ConfirmPinAndPayEvent, ConfirmPinAndPayState> {
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();

  ConfirmPinAndPayBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<VerifyPinEvent>((event, emit) async {
      await callVerifyPinEvent(event, emit);
    });
    on<SelectProductEvent>((event, emit) async {
      await callSelectProductEvent(event, emit);
    });
    on<TopUpEvent>((event, emit) async {
      await callTopUpEvent(event, emit);
    });
    on<CreateInvestmentGoalEvent>((event, emit) async {
      await callCreateInvestmentGoalEvent(event, emit);
    });
  }

  Future<void> callVerifyPinEvent(VerifyPinEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.verifyPin(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(VerifyPinState(model: event.model));
    });
  }

  Future<void> callSelectProductEvent(
      SelectProductEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.selectProduct(event.userId, event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(SelectProductState(
          responseModel: r.model, requestModel: event.model));
    });
  }

  Future<void> callTopUpEvent(TopUpEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.topUp(event.productId, event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(TopUpState(requestModel: event.model, responseModel: r.model));
    });
  }

  Future<void> callCreateInvestmentGoalEvent(
      CreateInvestmentGoalEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.createInvestmentGoal(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(CreateInvestmentGoalState(
          amount: event.amount, referenceCode: event.referenceCode));
    });
  }
}
