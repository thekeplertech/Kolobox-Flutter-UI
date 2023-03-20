const String koloFlexValue = 'Koloflex';
const String koloTargetValue = 'Kolotarget';
const String koloTargetPlusValue = 'Kolotarget+';
const String koloFamilyValue = 'Kolofamily';
const String koloGroupValue = 'Kologroup';

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
}
