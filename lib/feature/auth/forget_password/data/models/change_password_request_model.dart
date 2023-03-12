class ChangePasswordRequestModel {
  final String newPassword;
  final String newCPassword;

  ChangePasswordRequestModel({
    required this.newPassword,
    required this.newCPassword,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['new_password'] = newPassword;
    data['new_cpassword'] = newCPassword;
    return data;
  }
}
