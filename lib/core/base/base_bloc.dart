import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/master_bloc.dart';

abstract class BaseBloc<Event, State> extends Bloc<Event, State> {
  BaseBloc(this.baseBlocObject, State initialState) : super(initialState);

  final MasterBloc? baseBlocObject;
}
