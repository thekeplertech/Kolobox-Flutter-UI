class UpdatePasswordRequestModel {
  final String oldPassword;
  final String newPassword;
  final String newCPassword;

  UpdatePasswordRequestModel({
    required this.oldPassword,
    required this.newPassword,
    required this.newCPassword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['old_password'] = oldPassword;
    data['new_password'] = newPassword;
    data['new_cpassword'] = newCPassword;
    return data;
  }
}
