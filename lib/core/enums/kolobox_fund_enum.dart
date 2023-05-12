import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';
import 'package:kolobox_new_app/core/utils/date_helper.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/active_product_data_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/my_earning_data_model.dart';
import 'package:kolobox_new_app/feature/dashboard/data/models/product_data_model.dart';

import '../../di/injection_container.dart';
import '../colors/color_list.dart';
import '../preference/pref_helper.dart';

const String koloFlexValue = 'Koloflex';
const String koloTargetValue = 'Kolotarget';
// const String koloTargetPlusValue = 'Kolotarget+';
const String koloFamilyValue = 'Kolofamily';
const String koloGroupValue = 'Kologroup';

const String koloFlexPageValue = 'KoloFlexPage';
const String koloTargetPageValue = 'KoloTargetPage';
// const String koloTargetPlusPageValue = 'KoloTargetPlusPage';
const String koloFamilyPageValue = 'KoloFamilyPage';
const String koloGroupPageValue = 'KoloGroupPage';
const String koloTransactionDetailPageValue = 'KoloTransactionDetailPage';

// String koloFlexProductId = '-M1VwdR7fF9uCEf_vU0B';
// String koloTargetProductId = '-M1VwdRAFcArdU1acs3n';
// String koloTargetPlusProductId = 'jfhfjfbhfhjfbh';
// String koloFamilyProductId = '233jfhfjfjffbh';
// String koloGroupProductId = '-M1VwdgOP70p28p1oVOv';

const String koloFlexProductName = 'KOLO-FLEX';
const String koloTargetProductName = 'KOLO-TARGET';
const String koloGroupProductName = 'KOLO-GROUP';
const String koloFamilyProductName = 'KOLO-FAMILY';
// const String koloTargetPlusProductName = 'KOLO-TARGET-PLUS';
const String koloFundsProductName = 'KOLO-FUNDS';

enum KoloboxFundEnum {
  koloFlex,
  koloTarget,
  // koloTargetPlus,
  koloFamily,
  koloGroup
}

extension EnumExtensions on KoloboxFundEnum {
  String get getFundValue {
    switch (this) {
      case KoloboxFundEnum.koloFlex:
        return koloFlexValue;
      case KoloboxFundEnum.koloTarget:
        return koloTargetValue;
      // case KoloboxFundEnum.koloTargetPlus:
      //   return koloTargetPlusValue;
      case KoloboxFundEnum.koloFamily:
        return koloFamilyValue;
      case KoloboxFundEnum.koloGroup:
        return koloGroupValue;
    }
  }

  bool get isPhotoEnabledAsIcon {
    switch (this) {
      case KoloboxFundEnum.koloFlex:
      case KoloboxFundEnum.koloTarget:
      case KoloboxFundEnum.koloFamily:
      case KoloboxFundEnum.koloGroup:
        return true;
      // case KoloboxFundEnum.koloTargetPlus:
      //   return false;
    }
  }

  IconData get getFundIconValue {
    switch (this) {
      case KoloboxFundEnum.koloFlex:
        return KoloBoxIcons.koloFlex;
      case KoloboxFundEnum.koloTarget:
        return KoloBoxIcons.koloTarget;
      case KoloboxFundEnum.koloFamily:
        return KoloBoxIcons.koloFamily;
      case KoloboxFundEnum.koloGroup:
        return KoloBoxIcons.koloGroup;
      // case KoloboxFundEnum.koloTargetPlus:
      //   return KoloBoxIcons.koloTarget;
    }
  }

  Color get getFundIconColorValue {
    switch (this) {
      case KoloboxFundEnum.koloFlex:
        return ColorList.koloFlexTextColor;
      case KoloboxFundEnum.koloTarget:
        return ColorList.primaryColor;
      case KoloboxFundEnum.koloFamily:
        return ColorList.koloFamilyIconColor;
      case KoloboxFundEnum.koloGroup:
        return ColorList.koloGroupIconColor;
      // case KoloboxFundEnum.koloTargetPlus:
      //   return ColorList.koloFlexTextColor;
    }
  }

  Color get getFundBackColorValue {
    switch (this) {
      case KoloboxFundEnum.koloFlex:
        return ColorList.koloFlexColor;
      case KoloboxFundEnum.koloTarget:
        return ColorList.koloTargetColor;
      // case KoloboxFundEnum.koloTargetPlus:
      //   return ColorList.koloTargetPlusColor;
      case KoloboxFundEnum.koloFamily:
        return ColorList.koloFamilyColor;
      case KoloboxFundEnum.koloGroup:
        return ColorList.blackSecondColor;
    }
  }

  Color get getFundTextColorValue {
    switch (this) {
      case KoloboxFundEnum.koloFlex:
        return ColorList.koloFlexTextColor;
      case KoloboxFundEnum.koloTarget:
        return ColorList.primaryColor;
      // case KoloboxFundEnum.koloTargetPlus:
      //   return ColorList.blackSecondColor;
      case KoloboxFundEnum.koloFamily:
        return ColorList.koloFamilyTextColor;
      case KoloboxFundEnum.koloGroup:
        return ColorList.white;
    }
  }

  String get getFundImageValue {
    switch (this) {
      case KoloboxFundEnum.koloFlex:
        return imageFlexIcon;
      case KoloboxFundEnum.koloTarget:
        return imageTargetIcon;
      // case KoloboxFundEnum.koloTargetPlus:
      //   return imageTargetPlusIcon;
      case KoloboxFundEnum.koloFamily:
        return imageTargetPlusIcon;
      case KoloboxFundEnum.koloGroup:
        return imageGroupIcon;
    }
  }

  String get getProductId {
    PrefHelper helper = sl();
    ProductDataModel? productModel = helper.getProductDataModel();
    List<Products> products = productModel?.products ?? [];

    int pos = products.indexWhere((element) => element.name == getProductName);

    if (pos != -1) {
      return products[pos].id ?? '';
    } else {
      return '';
    }
  }

  String get getProductName {
    switch (this) {
      case KoloboxFundEnum.koloFlex:
        return koloFlexProductName;
      case KoloboxFundEnum.koloTarget:
        return koloTargetProductName;
      // case KoloboxFundEnum.koloTargetPlus:
      //   return koloTargetPlusProductName;
      case KoloboxFundEnum.koloFamily:
        return koloFamilyProductName;
      case KoloboxFundEnum.koloGroup:
        return koloGroupProductName;
      default:
        return '';
    }
  }

  String get getActiveId {
    PrefHelper helper = sl();
    ActiveProductDataModel? active = helper.getActiveProductDataModel();

    int? index = active?.products
        ?.indexWhere((element) => element.productId == getProductId);

    if (index != null && index != -1) {
      return active?.products?[index].id ?? '';
    } else {
      return '';
    }
  }

  String getFundPageValue(bool isDetail) {
    if (this == KoloboxFundEnum.koloFlex) {
      return koloFlexPageValue;
    } else if (isDetail) {
      return koloTransactionDetailPageValue;
    }
    switch (this) {
      case KoloboxFundEnum.koloFlex:
        return koloFlexPageValue;
      case KoloboxFundEnum.koloTarget:
        return koloTargetPageValue;
      // case KoloboxFundEnum.koloTargetPlus:
      //   return koloTargetPlusPageValue;
      case KoloboxFundEnum.koloFamily:
        return koloFamilyPageValue;
      case KoloboxFundEnum.koloGroup:
        return koloGroupPageValue;
    }
  }

  String getDepositAmountValue() {
    PrefHelper helper = sl();
    ActiveProductDataModel? active = helper.getActiveProductDataModel();

    int? index = active?.products?.indexWhere((element) =>
        element.productId == getProductId &&
        (element.verified ?? false) &&
        !(element.canceled ?? true));

    if (index != null && index != -1) {
      return active?.products?[index].depositAmount ?? '0.0';
    } else {
      return '0.0';
    }
  }

  String getEarningsAmountValue() {
    PrefHelper helper = sl();
    MyEarningDataModel? myEarning = helper.getMyEarningDataModel();

    int? index = myEarning?.earnings?.indexWhere((element) =>
        element.name == getProductName &&
        (element.verified ?? false) &&
        !(element.canceled ?? true));

    if (index != null && index != -1) {
      return (myEarning?.earnings?[index].amount ?? 0).toString();
    } else {
      return '0';
    }
  }

  String getStartDateValue() {
    PrefHelper helper = sl();
    ActiveProductDataModel? active = helper.getActiveProductDataModel();

    int? index = active?.products
        ?.indexWhere((element) => element.productId == getProductId);

    if (index != null && index != -1) {
      return active?.products?[index].startDate ?? '';
    } else {
      return '';
    }
  }

  String getMinimumAmountValue() {
    PrefHelper helper = sl();
    ProductDataModel? active = helper.getProductDataModel();

    int? index =
        active?.products?.indexWhere((element) => element.id == getProductId);

    if (index != null && index != -1) {
      return active?.products?[index].minimumAmount ?? '0.0';
    } else {
      return '0.0';
    }
  }

  int getTenorValue() {
    PrefHelper helper = sl();
    ProductDataModel? model = helper.getProductDataModel();

    int? index =
        model?.products?.indexWhere((element) => element.id == getProductId);

    if (index != null && index != -1) {
      // logger?.d("tenor value ${this} ${model?.products?[index].tenor}");
      return model?.products?[index].tenor ?? 0;
    } else {
      return 0;
    }
  }

  bool isInActiveProduct() {
    PrefHelper helper = sl();
    ActiveProductDataModel? active = helper.getActiveProductDataModel();

    int? index = active?.products
        ?.indexWhere((element) => element.productId == getProductId);

    if (index != null && index != -1) {
      return true;
    } else {
      return false;
    }
  }

  int getTenor() {
    PrefHelper helper = sl();
    MyEarningDataModel? model = helper.getMyEarningDataModel();

    int? index = model?.earnings?.indexWhere((element) =>
        element.name == getProductName &&
        (element.verified ?? false) &&
        !(element.canceled ?? true));

    if (index != null && index != -1) {
      return model?.earnings?[index].tenor ?? 0;
    } else {
      return 0;
    }
  }

  String getInterestRate() {
    PrefHelper helper = sl();
    MyEarningDataModel? model = helper.getMyEarningDataModel();

    int? index = model?.earnings?.indexWhere((element) =>
        element.name == getProductName &&
        (element.verified ?? false) &&
        !(element.canceled ?? true));

    if (index != null && index != -1) {
      return model?.earnings?[index].interestRate ?? '0.0';
    } else {
      return '0.0';
    }
  }

  double getInterest() {
    PrefHelper helper = sl();
    MyEarningDataModel? model = helper.getMyEarningDataModel();

    int? index = model?.earnings?.indexWhere((element) =>
        element.name == getProductName &&
        (element.verified ?? false) &&
        !(element.canceled ?? true));

    if (index != null && index != -1) {
      return model?.earnings?[index].interest?.toDouble() ?? 0.0;
    } else {
      return 0.0;
    }
  }

  int tenorAvailableForWithdrawal() {
    PrefHelper helper = sl();
    ProductDataModel? model = helper.getProductDataModel();
    ActiveProductDataModel? active = helper.getActiveProductDataModel();

    int? index = active?.products
        ?.indexWhere((element) => element.productId == getProductId);
    // logger?.d("---------------------");
    // logger?.d("$this $index");

    if (index != null && index != -1) {
      if ((active?.products?[index].startDate ?? '').isEmpty) {
        // logger?.d("start date $this ${(active?.products?[index].startDate)}");
        return 0;
      }
      DateTime dateTime =
          DateHelper.getDateTime(active?.products?[index].startDate ?? '');
      int tenor = getTenorValue();
      // logger?.d('start date and tenor $dateTime $tenor');
      dateTime = dateTime.add(Duration(days: tenor));
      // logger?.d('start date $dateTime $tenor');

      if (DateTime.now().isBefore(dateTime)) {
        // logger?.d("before $this ${(active?.products?[index].startDate)}");
        tenor = dateTime.difference(DateTime.now()).inDays;
      } else {
        // logger?.d("not before $this ${(active?.products?[index].startDate)}");
        tenor = 0;
      }
      return tenor;
    }

    return 0;
  }
}

extension EnumIdExtensions on String {
  KoloboxFundEnum? getEnumFromProductId() {
    PrefHelper helper = sl();
    ProductDataModel? productModel = helper.getProductDataModel();
    List<Products> products = productModel?.products ?? [];

    int pos = products.indexWhere((element) => element.id == this);

    if (pos != -1) {
      return products[pos].name?.getEnumFromProductName();
    } else {
      return null;
    }
  }

  KoloboxFundEnum? getEnumFromProductName() {
    switch (this) {
      case koloFlexProductName:
        return KoloboxFundEnum.koloFlex;
      case koloTargetProductName:
        return KoloboxFundEnum.koloTarget;
      // case koloTargetPlusProductName:
      //   return KoloboxFundEnum.koloTarget;
      case koloGroupProductName:
        return KoloboxFundEnum.koloTarget;
      case koloFamilyProductName:
        return KoloboxFundEnum.koloTarget;
    }
    return null;
  }
}
