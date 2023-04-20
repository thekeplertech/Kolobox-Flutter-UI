class UpdateProfileRequestModel {
  final String firstname;
  final String lastname;
  final String email;
  final String dob;
  final String occupation;
  final String phone;
  final String nextOfKin;
  final bool emailNotification;
  final bool smsNotification;

  UpdateProfileRequestModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.dob,
    required this.occupation,
    required this.phone,
    required this.nextOfKin,
    required this.emailNotification,
    required this.smsNotification,
  });

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['dob'] = dob;
    data['occupation'] = occupation;
    data['phone'] = phone;
    data['next_of_kin'] = nextOfKin;
    data['email_notification'] = emailNotification;
    data['sms_notification'] = smsNotification;
    return data;
  }
}
