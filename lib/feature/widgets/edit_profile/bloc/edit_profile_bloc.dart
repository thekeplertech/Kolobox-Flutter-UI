import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kolobox_new_app/feature/dashboard/domain/dashboard_repo.dart';

import '../../../../../core/base/base_bloc.dart';
import '../../../../../core/bloc/master_bloc.dart';
import '../../../../../core/preference/pref_helper.dart';
import '../../../../../di/injection_container.dart';
import '../../../../core/bloc/master_event.dart';
import 'edit_profile_event.dart';
import 'edit_profile_state.dart';

class EditProfileBloc extends BaseBloc<EditProfileEvent, EditProfileState> {
  DashboardRepo dashboardRepo = sl();
  PrefHelper helper = sl();

  EditProfileBloc(MasterBloc baseBlocObject)
      : super(baseBlocObject, InitialState()) {
    on<UpdateProfileEvent>((event, emit) async {
      await callUpdateProfileEvent(event, emit);
    });
  }

  Future<void> callUpdateProfileEvent(
      UpdateProfileEvent event, Emitter emit) async {
    baseBlocObject!.add(LoadApiEvent());
    final result = await dashboardRepo.updateProfile(event.model);

    result.fold((l) {
      baseBlocObject!.objectModel = l;
      baseBlocObject!.add(ErrorApiEvent());
    }, (r) {
      baseBlocObject!.add(LoadedApiEvent());
      emit(UpdateProfileState());
    });
  }
}
