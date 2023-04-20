import '../../../dashboard/data/models/update_profile_request_model.dart';

abstract class EditProfileEvent {}

class UpdateProfileEvent extends EditProfileEvent {
  final UpdateProfileRequestModel model;

  UpdateProfileEvent({required this.model});
}
