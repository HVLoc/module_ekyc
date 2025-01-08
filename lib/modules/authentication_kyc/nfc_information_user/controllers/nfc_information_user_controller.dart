import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/nfc_kyc/nfc_kyc.src.dart';
import 'package:module_ekyc/modules/client/client.src.dart';
import 'package:module_ekyc/modules/home/home.src.dart';
import 'package:module_ekyc/modules/overview/overview.src.dart';
import 'package:module_ekyc/shares/utils/time/date_utils.dart';

import '../../../../shares/shares.src.dart';

class NfcInformationUserController extends BaseGetxController {
  // String? idDocument = '';
  // String? firstName = '';
  // String? lastName = '';

  // String? gender;
  // String? nationality;
  String? dateOfBirth;
  String? dateOfExpiry;
  String? image;
  String? imageBody;
  bool authenticationSuccess = false;
  bool successSDK = false;
  String packageKind = AppConst.typeSanbox;
  RxBool authenticationVisible = false.obs;
  SendNfcRequestModel sendNfcRequestModel = SendNfcRequestModel();
  AppController appController = Get.find<AppController>();
  late NfcRepository nfcRepository;

  @override
  void onInit() {
    setupData();
    super.onInit();
  }

  Future<void> setupData() async {
    nfcRepository = NfcRepository(this);

    if (Get.arguments != null) {
      /*if (Get.arguments[1] is DataOcrModel) {
        dataOcrModel = Get.arguments[1];
      }*/
      if (Get.arguments is SendNfcRequestModel) {
        sendNfcRequestModel = Get.arguments;
        // idDocument = sendNfcRequestModel.number;
        // firstName = sendNfcRequestModel.nameVNM;
        // lastName = sendNfcRequestModel.lastName;
        // gender = sendNfcRequestModel.sexVMN /*== "M"
        //     ? LocaleKeys.nfcInformationUserPage_sexM.tr
        //     : LocaleKeys.nfcInformationUserPage_sexF.tr*/;
        if (sendNfcRequestModel.isView) {
          dateOfBirth = sendNfcRequestModel.dob;
          dateOfExpiry = sendNfcRequestModel.doe;
        } else {
          dateOfBirth = convertDateToString(
            convertStringToDate(
              sendNfcRequestModel.dob,
              pattern5,
            ),
            pattern1,
          );
          dateOfExpiry = convertDateToString(
            convertStringToDate(
              sendNfcRequestModel.doe,
              pattern5,
            ),
            pattern1,
          );
        }
        appController.sendNfcRequestGlobalModel = sendNfcRequestModel;

        // nationality = sendNfcRequestModel.nationVNM;
        image = sendNfcRequestModel.file;
        imageBody = sendNfcRequestModel.bodyFileId;
        packageKind = sendNfcRequestModel.kind ?? AppConst.typeProduction;
        // if (appController.typeAuthentication == AppConst.typeAuthentication) {
        //   await nfcRepository
        //       .sendNfcRepository(sendNfcRequestModel)
        //       .then((value) {
        //     authenticationSuccess = value.status;
        //     authenticationVisible.value = true;
        //   });
        // }
        print(sendNfcRequestModel.isFaceMatching);
        if (sendNfcRequestModel.isFaceMatching ?? false) {
          successSDK = true;
          authenticationFake();
        }
      }
    }
  }
    void authenticationFake() async {
      authenticationSuccess = true;
      authenticationVisible.value = true;
    }

    Future<void> authentication(String id, String bodyFileId) async {
      sendNfcRequestModel.fileId = id;
      sendNfcRequestModel.bodyFileId = bodyFileId;
      await nfcRepository.sendNfcRepository(sendNfcRequestModel).then((value) {
        authenticationSuccess = value.data?.result ?? false;
        authenticationVisible.value = true;
        packageKind = value.data?.packageKind ?? AppConst.typeSanbox;
        if (Get.isRegistered<ClientController>()) {
          ClientController clientController = Get.find<ClientController>();
          clientController.initDocument();
        }
        if (Get.isRegistered<OverviewController>()) {
          OverviewController overviewController = Get.find<
              OverviewController>();
          overviewController.getUserInfo();
        }
      });
    }

    void getToHome() {
      // Get.close(1);
      appController.sendDataToNative();
    }

    Future<void> goPage() async {
      if(successSDK){
        getToHome();
      }else{
        Get.offNamed(AppRoutes.routeLiveNessKyc);
      }
      // if (appController.typeAuthentication == AppConst.typeRegister) {
      //   Get.toNamed(AppRoutes.routeRegisterInfo);
      // } else if (appController.typeAuthentication == AppConst.typeForgotPass) {
      //   await Biometrics().authenticate(
      //       // localizedReasonStr: "Quý khách vui lòng quét vân tay hoặc khuôn mặt để xác thực",
      //       onDeviceUnlockUnavailable: () async {
      //     // await gotoPage();
      //     Get.toNamed(AppRoutes.routeForgotPass);
      //   }, onAfterLimit: () {
      //     Fluttertoast.showToast(
      //         msg: LocaleKeys.biometric_msgLimit.tr,
      //         toastLength: Toast.LENGTH_LONG);
      //   }).then((isAuthenticated) async {
      //     if (isAuthenticated ?? false) {
      //       // await gotoPage();
      //       Get.toNamed(AppRoutes.routeForgotPass);
      //     }
      //   });
      // } else if (appController.typeAuthentication ==
      //     AppConst.typeAuthentication) {
      //   Get.toNamed(AppRoutes.routeLiveNessKyc);
      // }

      // if (convertStringToDate(
      //       sendNfcRequestModel.doe,
      //       pattern5,
      //     )?.isAfter(DateTime.now()) ??
      //     true) {
      //   showLoading();
      //   await nfcRepository.sendNfcRepository(sendNfcRequestModel);
      //   appController.sendNfcRequestGlobalModel = sendNfcRequestModel;
      //   hideLoading();
      //   Get.toNamed(
      //     AppRoutes.routeInstructLiveNessKyc,
      //   );
      //   // Get.toNamed(AppRoutes.routeAwaitOCRData);
      // } else {
      //   if (appController.configCertificateModel.isCreateCertificate) {
      //     if (Get.isRegistered<RegisterAccountController>()) {
      //       Get.until(
      //           (route) => route.settings.name == AppRoutes.routeRegisterAccount);
      //     }
      //   } else {
      //     if (Get.isRegistered<VerifyProfileController>()) {
      //       Get.until(
      //           (route) => route.settings.name == AppRoutes.routeVerifyProfile);
      //     }
      //   }
      //   showSnackBar(LocaleKeys.nfc_nfc_expired_message.tr);
      // }
    }

    Future<void> gotoPage() async {
      if (appController.typeAuthentication == AppConst.typeRegister) {
        Get.toNamed(AppRoutes.routeRegisterInfo);
      } else if (appController.typeAuthentication == AppConst.typeForgotPass) {
        Get.toNamed(AppRoutes.routeForgotPass);
      } else if (appController.typeAuthentication ==
          AppConst.typeAuthentication) {
        Get.toNamed(AppRoutes.routeLiveNessKyc);
      }
    }
  }
