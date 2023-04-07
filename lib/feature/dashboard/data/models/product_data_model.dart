class ProductDataModel {
  int? total;
  List<Products>? products;
  List<InterestRates>? interestRates;

  ProductDataModel({this.total, this.products, this.interestRates});

  ProductDataModel.fromJson(Map<String, dynamic> json) {
    total = json['total'] ?? 0;
    products = <Products>[];
    if (json['p'] != null) {
      json['p'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    interestRates = <InterestRates>[];
    if (json['interestRates'] != null) {
      json['interestRates'].forEach((v) {
        interestRates!.add(InterestRates.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = total ?? 0;
    if (products != null) {
      data['p'] = products!.map((v) => v.toJson()).toList();
    }
    if (interestRates != null) {
      data['interestRates'] = interestRates!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Products {
  String? id;
  String? name;
  String? productType;
  String? termsConditions;
  bool? active;
  String? eligibility;
  String? benefits;
  String? details;
  List<Performance>? performance;
  String? startDate;
  String? businessPartnerName;
  String? bankAccountNumber;
  String? bankAccountName;
  String? bankName;
  String? minimumAmount;
  String? penaltyCharge;
  String? fee;
  String? performanceFee;
  int? feeChargeDate;
  int? tenor;
  int? withdrawalMinimum;
  String? withdrawalCharges;
  String? interestRate;
  String? fallbackInterest;
  String? unitPrice;
  String? unitPriceComputation;
  String? createdAt;
  String? updatedAt;
  String? adminId;
  String? productCategoryId;

  Products(
      {this.id,
      this.name,
      this.productType,
      this.termsConditions,
      this.active,
      this.eligibility,
      this.benefits,
      this.details,
      this.performance,
      this.startDate,
      this.businessPartnerName,
      this.bankAccountNumber,
      this.bankAccountName,
      this.bankName,
      this.minimumAmount,
      this.penaltyCharge,
      this.fee,
      this.performanceFee,
      this.feeChargeDate,
      this.tenor,
      this.withdrawalMinimum,
      this.withdrawalCharges,
      this.interestRate,
      this.fallbackInterest,
      this.unitPrice,
      this.unitPriceComputation,
      this.createdAt,
      this.updatedAt,
      this.adminId,
      this.productCategoryId});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'] ?? '';
    name = json['name'] ?? '';
    productType = json['product_type'] ?? '';
    termsConditions = json['terms_conditions'] ?? '';
    active = json['active'] ?? false;
    eligibility = json['eligibility'] ?? '';
    benefits = json['benefits'] ?? '';
    details = json['details'] ?? '';
    performance = <Performance>[];
    if (json['performance'] != null) {
      json['performance'].forEach((v) {
        performance!.add(Performance.fromJson(v));
      });
    }
    startDate = json['start_date'] ?? '';
    businessPartnerName = json['business_partner_name'] ?? '';
    bankAccountNumber = json['bank_account_number'] ?? '';
    bankAccountName = json['bank_account_name'] ?? '';
    bankName = json['bank_name'] ?? '';
    minimumAmount = json['minimum_amount'] ?? '';
    penaltyCharge = json['penalty_charge'] ?? '';
    fee = json['fee'] ?? '';
    performanceFee = json['performance_fee'] ?? '';
    feeChargeDate = json['fee_charge_date'] ?? 0;
    tenor = json['tenor'] ?? 0;
    withdrawalMinimum = json['withdrawal_minimum'] ?? 0;
    withdrawalCharges = json['withdrawal_charges'] ?? '';
    interestRate = json['interest_rate'] ?? '0';
    fallbackInterest = json['fallback_interest'] ?? '0';
    unitPrice = json['unit_price'] ?? '';
    unitPriceComputation = json['unit_price_computation'] ?? '';
    createdAt = json['created_at'] ?? '';
    updatedAt = json['updated_at'] ?? '';
    adminId = json['admin_id'] ?? '';
    productCategoryId = json['product_category_id'] ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id ?? '';
    data['name'] = name ?? '';
    data['product_type'] = productType ?? '';
    data['terms_conditions'] = termsConditions ?? '';
    data['active'] = active ?? false;
    data['eligibility'] = eligibility ?? '';
    data['benefits'] = benefits ?? '';
    data['details'] = details ?? '';
    if (performance != null) {
      data['performance'] = performance!.map((v) => v.toJson()).toList();
    }
    data['start_date'] = startDate ?? '';
    data['business_partner_name'] = businessPartnerName ?? '';
    data['bank_account_number'] = bankAccountNumber ?? '';
    data['bank_account_name'] = bankAccountName ?? '';
    data['bank_name'] = bankName ?? '';
    data['minimum_amount'] = minimumAmount ?? '';
    data['penalty_charge'] = penaltyCharge ?? '';
    data['fee'] = fee ?? '';
    data['performance_fee'] = performanceFee ?? '';
    data['fee_charge_date'] = feeChargeDate ?? 0;
    data['tenor'] = tenor ?? 0;
    data['withdrawal_minimum'] = withdrawalMinimum ?? 0;
    data['withdrawal_charges'] = withdrawalCharges ?? '';
    data['interest_rate'] = interestRate ?? '0';
    data['fallback_interest'] = fallbackInterest ?? '0';
    data['unit_price'] = unitPrice ?? '';
    data['unit_price_computation'] = unitPriceComputation ?? '';
    data['created_at'] = createdAt ?? '';
    data['updated_at'] = updatedAt ?? '';
    data['admin_id'] = adminId ?? '';
    data['product_category_id'] = productCategoryId ?? '';
    return data;
  }
}

class Performance {
  String? data;
  double? value;

  Performance({this.data, this.value});

  Performance.fromJson(Map<String, dynamic> json) {
    data = json['data'] ?? '';
    value = json['value'] ?? 0.0;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['data'] = this.data ?? '';
    data['value'] = value ?? 0.0;
    return data;
  }
}

class InterestRates {
  int? min;
  int? max;
  double? koloFlex;
  double? koloTarget;
  double? koloTargetPlus;
  double? koloFamily;
  double? koloGroup;
  double? koloFunds;

  InterestRates(
      {this.min,
      this.max,
      this.koloFlex,
      this.koloTarget,
      this.koloTargetPlus,
      this.koloFamily,
      this.koloGroup,
      this.koloFunds});

  InterestRates.fromJson(Map<String, dynamic> json) {
    min = json['min'] ?? 0;
    max = json['max'] ?? 0;
    koloFlex = (json['KOLO_FLEX'] == null)
        ? 0.0
        : double.parse(json['KOLO_FLEX'].toString());
    koloTarget = (json['KOLO_TARGET'] == null)
        ? 0.0
        : double.parse(json['KOLO_TARGET'].toString());
    koloTargetPlus = (json['KOLO_TARGET_PLUS'] == null)
        ? 0.0
        : double.parse(json['KOLO_TARGET_PLUS'].toString());
    koloFamily = (json['KOLO_FAMILY'] == null)
        ? 0.0
        : double.parse(json['KOLO_FAMILY'].toString());
    koloGroup = (json['KOLO_GROUP'] == null)
        ? 0.0
        : double.parse(json['KOLO_GROUP'].toString());
    koloFunds = (json['KOLO_FUNDS'] == null)
        ? 0.0
        : double.parse(json['KOLO_FUNDS'].toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['min'] = min ?? 0;
    data['max'] = max ?? 0;
    data['KOLO_FLEX'] = koloFlex ?? 0.0;
    data['KOLO_TARGET'] = koloTarget ?? 0.0;
    data['KOLO_TARGET_PLUS'] = koloTargetPlus ?? 0.0;
    data['KOLO_FAMILY'] = koloFamily ?? 0.0;
    data['KOLO_GROUP'] = koloGroup ?? 0.0;
    data['KOLO_FUNDS'] = koloFunds ?? 0.0;
    return data;
  }
}
