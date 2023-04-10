const double dashboardTabHeight = 67;
const double leftRightPadding = 25;

bool isBottomTabOpened = false;
const nigerianCurrency = '₦ ';

String getOnlyAmount(String text) =>
    text.replaceAll(nigerianCurrency, '').trim();
