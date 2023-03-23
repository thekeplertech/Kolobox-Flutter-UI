import 'package:flutter/material.dart';
import 'package:kolobox_new_app/core/constants/image_constants.dart';
import 'package:kolobox_new_app/core/constants/kolo_box_icon.dart';

import '../colors/color_list.dart';

const String koloFlexValue = 'Koloflex';
const String koloTargetValue = 'Kolotarget';
const String koloTargetPlusValue = 'Kolotarget+';
const String koloFamilyValue = 'Kolofamily';
const String koloGroupValue = 'Kologroup';

const String koloFlexPageValue = 'KoloFlexPage';
const String koloTargetPageValue = 'KoloTargetPage';
const String koloTargetPlusPageValue = 'KoloTargetPlusPage';
const String koloFamilyPageValue = 'KoloFamilyPage';
const String koloGroupPageValue = 'KoloGroupPage';
const String koloTransactionDetailPageValue = 'KoloTransactionDetailPage';

enum KoloboxFundEnum {
  koloFlex,
  koloTarget,
  koloTargetPlus,
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
      case KoloboxFundEnum.koloTargetPlus:
        return koloTargetPlusValue;
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
      case KoloboxFundEnum.koloTargetPlus:
        return false;
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
      case KoloboxFundEnum.koloTargetPlus:
        return KoloBoxIcons.koloTarget;
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
      case KoloboxFundEnum.koloTargetPlus:
        return ColorList.koloFlexTextColor;
    }
  }

  Color get getFundBackColorValue {
    switch (this) {
      case KoloboxFundEnum.koloFlex:
        return ColorList.koloFlexColor;
      case KoloboxFundEnum.koloTarget:
        return ColorList.koloTargetColor;
      case KoloboxFundEnum.koloTargetPlus:
        return ColorList.koloTargetPlusColor;
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
      case KoloboxFundEnum.koloTargetPlus:
        return ColorList.blackSecondColor;
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
      case KoloboxFundEnum.koloTargetPlus:
        return imageTargetPlusIcon;
      case KoloboxFundEnum.koloFamily:
        return imageTargetPlusIcon;
      case KoloboxFundEnum.koloGroup:
        return imageGroupIcon;
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
      case KoloboxFundEnum.koloTargetPlus:
        return koloTargetPlusPageValue;
      case KoloboxFundEnum.koloFamily:
        return koloFamilyPageValue;
      case KoloboxFundEnum.koloGroup:
        return koloGroupPageValue;
    }
  }
}
