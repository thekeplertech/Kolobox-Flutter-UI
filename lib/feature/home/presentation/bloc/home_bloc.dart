import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/core/colors/color_list.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/active_product_data_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/product_data_model.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';
import 'package:kolobox_new_app/feature/home/data/models/DashboardAmountModel.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/bloc/master_event.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import 'home_event.dart';
import 'home_state.dart';

class HomeBloc extends BaseBloc<HomeEvent, HomeState> {
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();

  HomeBloc(MasterBloc baseBlocObject) : super(baseBlocObject, InitialState()) {
    on<CallWalletEvent>((event, emit) async {
      await callWalletEvent(event, emit);
    });
    on<CallProductEvent>((event, emit) async {
      await callProductEvent(event, emit);
    });
    on<CallActiveProductEvent>((event, emit) async {
      await callActiveProductEvent(event, emit);
    });
    on<ClickOnHomeEvent>((event, emit) async {
      emit(ClickOnHomeState());
    });
  }

  Future<void> callWalletEvent(CallWalletEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.wallet();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(CallWalletState(model: r.model));
    });
  }

  Future<void> callProductEvent(CallProductEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    await dashboardRepo.getProducts();
    final result = await dashboardRepo.getActiveProducts();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());

      ActiveProductDataModel activeProductDataModel = r.model;
      List<Data> activeProducts = activeProductDataModel.products ?? [];
      List<Products> products = helper.getProductDataModel()?.products ?? [];

      List<DashboardAmountModel> models = [];
      models.add(DashboardAmountModel(
        title: 'Total Assets',
        amount: helper
                .getProfileDataModel()
                .wallet
                ?.withDrawableFunds
                ?.toString() ??
            '0.0',
        backColor: ColorList.primaryColor,
      ));

      for (var active in activeProducts) {
        Products activeProduct =
            products.singleWhere((element) => element.id == active.productId);
        if (activeProduct.id == active.productId) {
          models.add(DashboardAmountModel(
              title: activeProduct.name ?? '',
              amount: active.depositAmount ?? '',
              backColor: ColorList.greenColor));
        }
      }

      emit(CallProductState(models: models));
    });
  }

  Future<void> callActiveProductEvent(
      CallActiveProductEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.getActiveProducts();

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(CallActiveProductState(/*model: r.model*/));
    });
  }
}
