import 'package:bloc/bloc.dart';

import '../models/failure.dart';
import 'master_event.dart';
import 'master_state.dart';

class MasterBloc extends Bloc<ApiStateEvents, BaseApiState> {
  late Failure objectModel;

  MasterBloc(BaseApiState initialState) : super(initialState) {
    on<LoadApiEvent>((event, emit) {
      emit(ApiLoadingState());
    });
    on<LoadedApiEvent>((event, emit) {
      emit(ApiLoadedState());
    });
    on<ErrorApiEvent>((event, emit) {
      emit(ApiErrorState(
        objectModel.message,
        objectModel.apiStatus,
        model: objectModel.model,
      ));
    });
  }
}
