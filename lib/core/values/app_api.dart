/// class chứa các api để giao tiếp với BE
// Todo: AppUrl
class AppApi {
  // static const String url = 'https://cloud.2id.vn/api';
  static const String url = 'https://uat-apim.2id.vn/gateway/2id-ekyc/v.1';
  // static const String url = 'https://api-c06verify.2id.vn/api';

  static const String version = "?v=1.0";
  static const String loginApp = "/v1/auth/customer/login";
  // static const String sendLiveNessData = "/live-ness-data/sendLiveNessData";
  static const String getAuthProfile = "/certificate-orders/list-auth-request";
  static const String sendNfcData = "/v1/c06-verify/verify-card";
  // static const String getDataORC = "/ocr-data/get-ocr";
  // static const String sendFileOCR = "/files/send-file";
  static const String getUserInfo = "/v1/customers/me";
  static const String getRegister = "/v1/auth/customer/register";
  static const String getProvision = "/v1/info/policy";
  static const String forgotPassWord = "/v1/auth/customer/reset-pass";
  static const String sendFileData = "/v1/files";
  static const String registerPackage = "/v1/customer/subscribes";
  static const String resetPassWord = "/v1/auth/customer/reset-pass";
  static const String changePassWord = "/v1/customers/me/change-pass";
  static const String getSupport = "/v1/info/about";

  static String getWebLink(String id) {
    return "/v1/customer/subscribes/$id/pay/request?provider=ONEFIN";
  }

  static String deletePackagePayment(String id) {
    return "/v1/customer/subscribes/$id";
  }

  static String getListPackage(int page, int pageSize) {
    return "/v1/packages?keyword&pageIndex=$page&pageSize=$pageSize";
  }

  static String getListHistoryPackage(int page, int pageSize) {
    return "/v1/customer/subscribes?pageIndex=$page&pageSize=$pageSize";
  }

  static String detailPackage(String id) {
    return "/v1/customer/subscribes/$id/pay/detail";
  }

  static String getListClient(
    int page,
    int pageSize,
    String from,
    String to,
    String keyword,
  ) {
    return "/v1/customer/subscribes/verify-histories?from=$from&to=$to&orderBy&pageIndex=$page&pageSize=$pageSize&keyword=$keyword";
  }

  static String getDetailClient(
    String id,
  ) {
    return "/v1/customer/subscribes/verify-histories/$id";
  }

  static const String getFile = "/v1/files/download";

  static const String acceptTerms = "/certificate-orders/sendPolicyAgreement";
  // static const String registerAccount = "/account/register";
  // static const String registerCertificate =
  //     "/certificate-orders/register-certificate-order";
  // static const String packageService = "/system-config/packages";

  // static const String fileSign = "/certificate-orders/send-sign-image";
  // static const String getDataPdf =
  //     "/certificate-orders/get-certificate-register";
  //
  // static String getCertVerifyStatus(int status) {
  //   return "/certificate-orders/get-certificate-info-by-status?status=$status";
  // }
  //
  // static const String sendVerifyCertification =
  //     "/certificate-orders/send-certificate-verify-status";
  // static const String updatePersonInfo = "/ocr-data/client-register";

  ///sdk
  static const String faceMatching = "/face-matches/base64?imageType=CARD";
  static const String verifyC06 = "/c06-verify/integration/verify-card";
}
