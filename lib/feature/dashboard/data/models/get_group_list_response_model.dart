class GetGroupListResponseModel {
  List<GroupModel>? types;

  GetGroupListResponseModel({this.types});

  GetGroupListResponseModel.fromJson(List<dynamic> data) {
    types = <GroupModel>[];
    for (var v in data) {
      types!.add(GroupModel.fromJson(v));
    }
  }

  List<dynamic> toJson() {
    List<dynamic> data = [];
    if (types != null) {
      data = types!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class GroupModel {
  String? id;
  bool? cancelled;
  String? createdAt;
  String? updatedAt;
  String? groupId;
  String? userId;
  bool? active;
  String? firstname;
  String? lastname;
  String? email;
  String? password;
  String? dob;
  String? pin;
  String? phone;
  String? occupation;
  String? wallet;
  String? paystackId;
  String? number;
  bool? smsNotification;
  bool? emailNotification;
  String? name;
  bool? notificationStatus;
  String? tenorId;
  String? groupTypeId;
  String? minimumAmount;
  String? frequency;
  String? tenor;
  String? productName;
  int? maxThreshold;
  int? activeThreshold;

  bool isActive = true;

  GroupModel({this.id,
    this.cancelled,
    this.createdAt,
    this.updatedAt,
    this.groupId,
    this.userId,
    this.active,
    this.firstname,
    this.lastname,
    this.email,
    this.password,
    this.dob,
    this.pin,
    this.phone,
    this.occupation,
    this.wallet,
    this.paystackId,
    this.number,
    this.smsNotification,
    this.emailNotification,
    this.name,
    this.notificationStatus,
    this.tenorId,
    this.groupTypeId,
    this.minimumAmount,
    this.frequency,
    this.tenor,
    this.productName,
    this.maxThreshold,
    this.activeThreshold});

  GroupModel.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    cancelled = json['cancelled'];
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    groupId = json['group_id'] ?? '';
    userId = json['user_id'] ?? '';
    active = json['active'] ?? false;
    firstname = json['firstname'] ?? '';
    lastname = json['lastname'] ?? '';
    email = json['email'] ?? '';
    password = json['password'] ?? '';
    dob = json['dob'] ?? '';
    pin = json['pin'] ?? '';
    phone = json['phone'] ?? '';
    occupation = json['occupation'] ?? '';
    wallet = json['wallet'] ?? '';
    paystackId = json['paystack_id'] ?? '';
    number = json['number'] ?? '';
    smsNotification = json['sms_notification'] ?? false;
    emailNotification = json['email_notification'] ?? false;
    name = json['name'] ?? '';
    notificationStatus = json['notification_status'] ?? false;
    tenorId = json['tenor_id'] ?? '';
    groupTypeId = json['group_type_id'] ?? '';
    minimumAmount = json['minimum_amount'] ?? '';
    frequency = json['frequency'] ?? '';
    tenor = json['Tenor'] ?? '';
    productName = json['Name'] ?? '';
    maxThreshold = json['max_threshold'] ?? 0;
    activeThreshold = json['active_threshold'] ?? 0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['cancelled'] = cancelled;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['group_id'] = groupId;
    data['user_id'] = userId;
    data['active'] = active;
    data['firstname'] = firstname;
    data['lastname'] = lastname;
    data['email'] = email;
    data['password'] = password;
    data['dob'] = dob;
    data['pin'] = pin;
    data['phone'] = phone;
    data['occupation'] = occupation;
    data['wallet'] = wallet;
    data['paystack_id'] = paystackId;
    data['number'] = number;
    data['sms_notification'] = smsNotification ?? false;
    data['email_notification'] = emailNotification ?? false;
    data['name'] = name;
    data['notification_status'] = notificationStatus;
    data['tenor_id'] = tenorId;
    data['group_type_id'] = groupTypeId;
    data['minimum_amount'] = minimumAmount;
    data['frequency'] = frequency;
    data['Tenor'] = tenor;
    data['Name'] = productName;
    data['max_threshold'] = maxThreshold ?? 0;
    data['active_threshold'] = activeThreshold ?? 0;
    return data;
  }
}
