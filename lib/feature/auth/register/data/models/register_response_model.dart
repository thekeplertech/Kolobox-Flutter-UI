class RegisterResponseModel {
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
  String? createdAt;
  String? updatedAt;
  bool? smsNotification;
  bool? emailNotification;
  String? token;
  String? logoUrl;
  String? inviteURL;

  RegisterResponseModel({
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
    this.createdAt,
    this.updatedAt,
    this.smsNotification,
    this.emailNotification,
    this.token,
    this.logoUrl,
    this.inviteURL,
  });

  RegisterResponseModel.fromJson(Map<String, dynamic> json) {
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
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    smsNotification = json['sms_notification'] ?? false;
    emailNotification = json['email_notification'] ?? false;
    token = json['token'] ?? '';
    logoUrl = json['logoUrl'] ?? '';
    inviteURL = json['invite_URL'] ?? '';
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
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['sms_notification'] = smsNotification;
    data['email_notification'] = emailNotification;
    data['token'] = token;
    data['logoUrl'] = logoUrl;
    data['invite_URL'] = inviteURL;
    return data;
  }
}
