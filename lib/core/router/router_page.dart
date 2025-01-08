import 'package:module_ekyc/modules/authentication_kyc/change_password/change_password.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/face_matching_result/face_matching_result.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/forgot_password/forgot_password.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/live_ness/live_ness_kyc.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/nfc_information_user/nfc_information_user_src.dart';
import 'package:module_ekyc/modules/authentication_kyc/nfc_kyc/nfc_kyc.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/verify_profile_ca/verify_profile_ca_src.dart';
import 'package:module_ekyc/modules/client/client.src.dart';
import 'package:module_ekyc/modules/home/home.src.dart';
import 'package:module_ekyc/modules/login/views/login_page.dart';
import 'package:module_ekyc/modules/provision/provision.src.dart';
import 'package:module_ekyc/modules/register_info/register_info.src.dart';
import 'package:module_ekyc/modules/support/support.src.dart';
import 'package:module_ekyc/modules/user_info/user_info.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';

import '../../modules/authentication_kyc/qr_kyc/qr_kyc.src.dart';
import '../../modules/splash/view/splash_page.dart';
import 'app_route.dart';

class RouteAppPage {
  static var route = [

    GetPage(
      name: AppRoutes.initApp,
      page: () => const SplashPage(),
    ),
    GetPage(
      name: AppRoutes.routeLogin,
      page: () => const LoginPage(),
    ),
    GetPage(
      name: AppRoutes.routeVerifyProfile,
      page: () => const VerifyProfilePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.routeScanNfcKyc,
      page: () => const ScanNfcKycPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.routeLiveNessKyc,
      page: () => const LiveNessKycPage(),
      transition: Transition.rightToLeft,
    ),
    // GetPage(
    //   name: AppRoutes.routeInstructLiveNessKyc,
    //   page: () => const InstructLiveNessKycPage(),
    //   transition: Transition.rightToLeft,
    // ),
    GetPage(
      name: AppRoutes.routeNfcInformationUser,
      page: () => const NfcInformationUserPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.routeHome,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.routeQrKyc,
      page: () => const QRGuidePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.routeAuthenticationGuide,
      page: () => const AuthenticationGuidePage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.routeChangePassword,
      page: () => const ChangePasswordPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.routeUserInfo,
      page: () => const UserInfoPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.routeProvision,
      page: () => const ProvisionPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.routeRegisterInfo,
      page: () => const RegisterInfoPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.routeForgotPass,
      page: () => const ForgotPasswordPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.routeListClient,
      page: () => const ClientPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.routeSupport,
      page: () => const SupportPage(),
      transition: Transition.rightToLeft,
    ),
    GetPage(
      name: AppRoutes.routeFaceMatchingResult,
      page: () => const FaceMatchingResultPage(),
      transition: Transition.rightToLeft,
    ),
  ];
}
