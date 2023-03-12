class RegisterRequestModel {
  // firstname, lastname, email, dob: user date of birth in the format YYYY-MM-DD e.g 1991-01-01,
  // occupation, phone: user phone number which must be 11 digits, password, cpassword,
  // school: user school where applicable, not required
  final String firstname;
  final String lastname;
  final String email;
  final String dob; // Format yyyy-MM-dd
  final String school;
  final String occupation;
  final String phone;
  final String nextOfKin;
  final bool emailNotification;
  final bool smsNotification;
  final String password;
  final String cPassword;

  RegisterRequestModel({
    required this.firstname,
    required this.lastname,
    required this.email,
    required this.dob,
    required this.occupation,
    required this.phone,
    required this.nextOfKin,
    this.emailNotification = true,
    this.smsNotification = true,
    required this.password,
    required this.cPassword,
    required this.school,
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
    data['password'] = password;
    data['cpassword'] = cPassword;
    data['school'] = school;
    return data;
  }
}
