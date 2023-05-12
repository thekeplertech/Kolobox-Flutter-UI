import 'package:kolobox_new_app/feature/dashboard/data/models/get_group_list_response_model.dart';

abstract class KoloGroupState {}

class InitialState extends KoloGroupState {}

class GetGroupState extends KoloGroupState {
  final GetGroupListResponseModel model;

  GetGroupState({required this.model});
}
