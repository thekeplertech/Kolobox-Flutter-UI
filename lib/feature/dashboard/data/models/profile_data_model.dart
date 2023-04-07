class ProfileDataModel {
  User? user;
  Wallet? wallet;
  List<Accounts>? accounts;
  List<UserPaymentPlans>? userPaymentPlans;

  ProfileDataModel(
      {this.user, this.wallet, this.accounts, this.userPaymentPlans});

  ProfileDataModel.fromJson(Map<String, dynamic> json) {
    user = json['user'] != null ? User.fromJson(json['user']) : null;
    wallet = json['wallet'] != null ? Wallet.fromJson(json['wallet']) : null;
    if (json['accounts'] != null) {
      accounts = <Accounts>[];
      json['accounts'].forEach((v) {
        accounts!.add(Accounts.fromJson(v));
      });
    }
    if (json['userPaymentPlans'] != null) {
      userPaymentPlans = <UserPaymentPlans>[];
      json['userPaymentPlans'].forEach((v) {
        userPaymentPlans!.add(UserPaymentPlans.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user'] = user!.toJson();
    }
    if (wallet != null) {
      data['wallet'] = wallet!.toJson();
    }
    if (accounts != null) {
      data['accounts'] = accounts!.map((v) => v.toJson()).toList();
    }
    if (userPaymentPlans != null) {
      data['userPaymentPlans'] =
          userPaymentPlans!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class User {
  String? id;
  bool? active;
  String? firstname;
  String? lastname;
  String? email;
  String? dob;
  String? phone;
  String? occupation;
  String? wallet;
  String? number;
  String? nextOfKin;
  String? createdAt;
  String? updatedAt;
  bool? smsNotification;
  bool? emailNotification;

  User({
    this.id,
    this.active,
    this.firstname,
    this.lastname,
    this.email,
    this.dob,
    this.phone,
    this.occupation,
    this.wallet,
    this.number,
    this.nextOfKin,
    this.createdAt,
    this.updatedAt,
    this.smsNotification,
    this.emailNotification,
  });

  User.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    active = json['active'] ?? false;
    firstname = json['firstname'] ?? '';
    lastname = json['lastname'] ?? '';
    email = json['email'] ?? '';
    dob = json['dob'] ?? '';
    phone = json['phone'] ?? '';
    occupation = json['occupation'] ?? '';
    wallet = json['wallet'] ?? '';
    number = json['number'] ?? '';
    nextOfKin = json['Next_Of_Kin'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    smsNotification = json['sms_notification'] ?? false;
    emailNotification = json['email_notification'] ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['active'] = active ?? false;
    data['firstname'] = firstname ?? '';
    data['lastname'] = lastname ?? '';
    data['email'] = email ?? '';
    data['dob'] = dob ?? '';
    data['phone'] = phone ?? '';
    data['occupation'] = occupation ?? '';
    data['wallet'] = wallet ?? '';
    data['number'] = number ?? '';
    data['Next_Of_Kin'] = nextOfKin ?? '';
    data['created_at'] = createdAt ?? '';
    data['updated_at'] = updatedAt ?? '';
    data['sms_notification'] = smsNotification ?? false;
    data['email_notification'] = emailNotification ?? false;
    return data;
  }
}

class Wallet {
  String? id;
  String? bookBalance;
  String? accountBalance;
  String? createdAt;
  String? updatedAt;
  String? userId;
  double? withDrawableFunds;

  Wallet(
      {this.id,
      this.bookBalance,
      this.accountBalance,
      this.createdAt,
      this.updatedAt,
      this.userId,
      this.withDrawableFunds});

  Wallet.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    bookBalance = json['book_balance'] ?? '';
    accountBalance = json['account_balance'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    userId = json['user_id'] ?? '';
    withDrawableFunds = json['withdrawable_funds'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['book_balance'] = bookBalance ?? '';
    data['account_balance'] = accountBalance ?? '';
    data['created_at'] = createdAt ?? '';
    data['updated_at'] = updatedAt ?? '';
    data['user_id'] = userId ?? '';
    data['withdrawable_funds'] = withDrawableFunds ?? 0.0;
    return data;
  }
}

class Accounts {
  String? id;
  String? bankName;
  String? accountNumber;
  String? accountName;
  String? code;
  bool? payWithBank;
  String? createdAt;
  String? updatedAt;
  String? userId;

  Accounts(
      {this.id,
      this.bankName,
      this.accountNumber,
      this.accountName,
      this.code,
      this.payWithBank,
      this.createdAt,
      this.updatedAt,
      this.userId});

  Accounts.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    bankName = json['bank_name'] ?? '';
    accountNumber = json['account_number'] ?? '';
    accountName = json['account_name'] ?? '';
    code = json['code'] ?? '';
    payWithBank = json['pay_with_bank'] ?? false;
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    userId = json['user_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['bank_name'] = bankName ?? '';
    data['account_number'] = accountNumber ?? '';
    data['account_name'] = accountName ?? '';
    data['code'] = code ?? '';
    data['pay_with_bank'] = payWithBank ?? false;
    data['created_at'] = createdAt ?? '';
    data['updated_at'] = updatedAt ?? '';
    data['user_id'] = userId ?? '';
    return data;
  }
}

class UserPaymentPlans {
  String? productId;
  String? productName;

  UserPaymentPlans({this.productId, this.productName});

  UserPaymentPlans.fromJson(Map<String, dynamic> json) {
    productId = json['product_id'] ?? '';
    productName = json['product_name'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['product_id'] = productId ?? '';
    data['product_name'] = productName ?? '';
    return data;
  }
}
