import '../../../../core/base/base_bloc.dart';
import '../../../../core/bloc/master_bloc.dart';
import '../../../../core/preference/pref_helper.dart';
import '../../../../di/injection_container.dart';
import 'dashboard_event.dart';
import 'dashboard_state.dart';

class DashboardBloc extends BaseBloc<DashboardEvent, DashboardState> {
  PrefHelper helper = sl();

  DashboardBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<ShowEnableBottomScreenEvent>((event, emit) {
      emit(ShowEnableBottomScreenState());
    });
    on<HideDisableBottomScreenEvent>((event, emit) {
      emit(HideDisableBottomScreenState());
    });
    on<ClearBackStackEvent>((event, emit) {
      emit(ClearBackStackState());
    });
  }
}
