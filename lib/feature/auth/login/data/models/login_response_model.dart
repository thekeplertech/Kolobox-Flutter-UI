class LoginResponseModel {
  bool? active;
  String? id;
  String? firstname;
  String? lastname;
  String? email;
  String? dob;
  String? phone;
  String? occupation;
  String? wallet;
  String? school;
  String? number;
  String? nextOfKin;
  String? referral;
  String? createdAt;
  String? updatedAt;
  bool? smsNotification;
  bool? emailNotification;
  bool? isPin;
  String? token;
  bool isLoggedIn = true;

  LoginResponseModel({
    this.id,
    this.active,
    this.firstname,
    this.lastname,
    this.email,
    this.dob,
    this.phone,
    this.occupation,
    this.wallet,
    this.school,
    this.number,
    this.nextOfKin,
    this.referral,
    this.createdAt,
    this.updatedAt,
    this.smsNotification,
    this.emailNotification,
    this.isPin,
    this.token,
  });

  LoginResponseModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    active = json['active'] ?? false;
    firstname = json['firstname'] ?? '';
    lastname = json['lastname'] ?? '';
    email = json['email'] ?? '';
    dob = json['dob'] ?? '';
    phone = json['phone'] ?? '';
    occupation = json['occupation'] ?? '';
    wallet = json['wallet'] ?? '';
    school = json['school'] ?? '';
    number = json['number'] ?? '';
    nextOfKin = json['Next_Of_Kin'] ?? '';
    referral = json['referral'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    smsNotification = json['sms_notification'] ?? false;
    emailNotification = json['email_notification'] ?? false;
    isPin = json['is_pin'] ?? false;
    token = json['token'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['active'] = active;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['dob'] = dob;
    data['phone'] = phone;
    data['occupation'] = occupation;
    data['wallet'] = wallet;
    data['school'] = school;
    data['number'] = number;
    data['Next_Of_Kin'] = nextOfKin;
    data['referral'] = referral;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['sms_notification'] = smsNotification;
    data['email_notification'] = emailNotification;
    data['is_pin'] = isPin;
    data['token'] = token;
    return data;
  }
}
