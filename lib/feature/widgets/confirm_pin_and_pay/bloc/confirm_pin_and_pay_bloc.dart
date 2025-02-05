import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../../../core/bloc/master_event.dart';
import '../../../dashboard/data/models/create_family_response_model.dart';
import '../../../dashboard/data/models/create_group_response_model.dart';
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
    on<CreateGroupEvent>((event, emit) async {
      await callCreateGroupEvent(event, emit);
    });
    on<CreateFamilyEvent>((event, emit) async {
      await callCreateFamilyEvent(event, emit);
    });
    on<GetTenorEvent>((event, emit) async {
      await callGetTenorEvent(event, emit);
    });
    on<GetGroupEvent>((event, emit) async {
      await callGetGroupEvent(event, emit);
    });
    on<GetFamilyEvent>((event, emit) async {
      await callGetFamilyEvent(event, emit);
    });
    on<GetFamilyUsersEvent>((event, emit) async {
      await callFamilyUsersEvent(event, emit);
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
        responseModel: r.model,
        requestModel: event.model,
        createGroupResponseModel: event.createGroupResponseModel,
        createFamilyResponseModel: event.createFamilyResponseModel,
      ));
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

  // Future<void> callCreateGroupEvent(
  //     CreateGroupEvent event, Emitter emit) async {
  //   baseBlocObject!.add(LoadApiEvent());
  //   final result = await dashboardRepo.getGroupTypes();
  //
  //   result.fold((l) {
  //     createGroupEvent(event, emit);
  //   }, (r) {
  //     GetGroupTypeResponseModel model = r.model;
  //     List<GroupTypeModel> types = model.types ?? [];
  //     int pos = types.indexWhere((element) =>
  //         element.name == KoloboxFundEnum.koloGroup.getProductName);
  //     if (pos != -1) {
  //       event.model.groupTypeId = types[pos].id ?? '';
  //     }
  //     createGroupEvent(event, emit);
  //   });
  // }

  Future<void> callCreateGroupEvent(
      CreateGroupEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.createGroup(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      CreateGroupResponseModel model = r.model;
      emit(CreateGroupState(responseModel: model));
    });
  }

  Future<void> callCreateFamilyEvent(
      CreateFamilyEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.createFamily(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      CreateFamilyResponseModel model = r.model;
      emit(CreateFamilyState(responseModel: model));
    });
  }

  Future<void> callGetTenorEvent(GetTenorEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getGroupTenors();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(GetTenorState(model: r.model));
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
}
