class ApiUrls {
  ApiUrls._();

  static const String getSystemsAPI = "pvsystems";
  static const String loginAPI = "api/User/Login";
  static const String getPVSystemsAPI = "api/PVSystem/GetPVSystems";
  static const String getPVSystemImageAPI =
      "api/PVSystem/GetPVsystemImagesId/{id}";
  static const String getPVSystemFlowData =
      "api/PVSystem/GetPVsystemFlowData/{id}";
  static const String getWeatherCurrent =
      "api/Fronius/GetWeatherCurrentTemp/{id}";
  static const String getEconomicTotals = "api/PVSystem/GetEconomicTotals/{id}";
  static const String getPVSystemAggDataTotal =
      "api/PVSystem/GetPVSystemAggDataTotal/{id}";
  static const String getPowerBalanceCurrent =
      "api/PVSystem/GetPowerBalanceCurrentDay/{id}";
  static const String getPowerBalanceDay =
      "api/PVSystem/GetPowerBalanceDay/{id}/{year}/{month}/{day}";
  static const String getPowerBalanceMonth =
      "api/PVSystem/GetPowerBalanceMonth/{id}/{year}/{month}";
  static const String getPowerBalanceYear =
      "api/PVSystem/GetPowerBalanceYear/{id}/{year}";
  static const String getPowerBalanceTotal =
      "api/PVSystem/GetPowerBalanceTotal/{id}";
}

const String USERS_API = "users";
const String PRODUCTS_API = "products";

//10 seconds timeout for all apis
const int API_CONNECT_TIMEOUT = 240000;
const int RECEIVE_TIMEOUT = 240000;
const int SEND_TIMEOUT = 240000;
const String SOCKET_EXCEPTION = "SocketException";
const String MISSING_INSTANCEID_EXCEPTION = "MISSING_INSTANCEID_SERVICE";
const int UN_AUTHORISED = 401;
const int REQUEST_ALREADY_SUBMITTED = 416;
const int INTERNET_CONNECTION_ERROR_STATUS_CODE = -1;
const int API_CALL_TIMEOUT_ERROR_STATUS_CODE = -2;
const int SERVICE_DOWN_STATUS_CODE = 503;
const int ANNUAL_DECLARATION_FAILURE_STATUS_CODE = 504;
