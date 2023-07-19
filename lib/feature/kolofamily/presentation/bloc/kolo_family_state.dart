import '../../../dashboard/data/models/get_group_list_response_model.dart';

abstract class KoloFamilyState {}

class InitialState extends KoloFamilyState {}

class GetFamilyState extends KoloFamilyState {
  final GetGroupListResponseModel model;

  GetFamilyState({required this.model});
}
