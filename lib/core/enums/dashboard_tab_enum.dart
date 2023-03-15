const int homeValue = 0;
const int koloboxValue = 1;
const int walletValue = 2;
const int accountValue = 3;

enum DashboardTabEnum { home, kolobox, wallet, account }

extension EnumExtensions on DashboardTabEnum {
  int get getDashboardValue {
    switch (this) {
      case DashboardTabEnum.home:
        return homeValue;
      case DashboardTabEnum.kolobox:
        return koloboxValue;
      case DashboardTabEnum.wallet:
        return walletValue;
      case DashboardTabEnum.account:
        return accountValue;
      default:
        return homeValue;
    }
  }
}

extension EnumExtensionsVal on int {
  DashboardTabEnum dashboardTypeVal() {
    switch (this) {
      case homeValue:
        return DashboardTabEnum.home;
      case koloboxValue:
        return DashboardTabEnum.kolobox;
      case walletValue:
        return DashboardTabEnum.wallet;
      case accountValue:
        return DashboardTabEnum.account;
      default:
        return DashboardTabEnum.home;
    }
  }
}
