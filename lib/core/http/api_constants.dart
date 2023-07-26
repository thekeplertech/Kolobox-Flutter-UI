class ApiUrls {
  ApiUrls._();

  static const String registerAPI = "auth/user/create";
  static const String loginAPI = "auth/user/login";
  static const String forgetPasswordAPI = "auth/user/forget_password";
  static const String passwordValidateAPI = "auth/user/password_reset/validate";
  static const String changePasswordAPI =
      "auth/user/password_reset/change_password";
  static const String verifyCodeAPI = "auth/user/verify/code";
  static const String walletAPI = "user/me/wallet";
  static const String getProfileAPI = "user/me/profile";
  static const String getProductAPI = "product";
  static const String getActiveProductAPI = "user/me/active/products";
  static const String getEarningsAPI = "user/me/product/earnings";
  static const String getTransactionsAPI = "user/me/product/transactions";
  static const String getGroupTransactionsAPI = "group/group_transactions";
  static const String getGroupUsersAPI = "group/group_users";
  static const String getInviteGroupAPI = "group/invite";
  static const String createPinAPI = "user/me/pin";
  static const String getMyEarningsAPI = "user/me/earning";
  static const String verifyPinAPI = "helpers/verifyPin";
  static const String selectProductAPI = "product/{userId}/selection";
  static const String topUpAPI = "product/{productId}/account/topup";
  static const String investmentGoalAPI = "user/investment/goal";
  static const String createGroupAPI = "group/create";

  // static const String getGroupListAPI = "group/user_group_list";
  static const String getGroupListAPI = "group/user_kolo_group_list";
  static const String getFamilyListAPI = "group/user_kolo_family_list";
  static const String getFamilyUserListAPI = "group/subuser";
  static const String createFamilyUserListAPI = "group/subuser/create";
  static const String groupTenorsAPI = "group/tenors";
  static const String groupTypesAPI = "group/types";
  static const String getBanksAPI = "helpers/banks";
  static const String getAllMyBanksAPI = "user/me/bank";
  static const String deleteMyBanksAPI = "user/me/bank/{bankId}";
  static const String updateProfileAPI = "user/me/update";
  static const String updatePasswordAPI = "user/me/password/change_password";
  static const String accountTransferAPI = "user/account/transfer";
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
