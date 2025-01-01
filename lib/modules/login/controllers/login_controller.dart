import 'dart:async';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/verify_profile_ca/models/login_ca_model/login_ca_model.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/verify_profile_ca/repository/login_ca_repository.dart';
import 'package:module_ekyc/modules/login/login.src.dart';
import 'package:module_ekyc/shares/utils/log/dio_log.dart';

import '../../../base_app/base_app.src.dart';
import '../../../core/core.src.dart';
import '../../../shares/shares.src.dart';

class LoginController extends BaseGetxController {
  AppController appController = Get.find<AppController>();
  final formKeyReset = GlobalKey<FormState>();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();
  final Rx<FocusNode> userNameFocus = FocusNode().obs;
  final Rx<FocusNode> passwordFocus = FocusNode().obs;
  final Rx<Color> fillColorUserName = AppColors.secondaryNavyPastel.obs;
  final Rx<Color> fillColorPassword = AppColors.secondaryNavyPastel.obs;
  final formKey = GlobalKey<FormState>();

  // RxBool isShowTime = false.obs;
  RxBool isBiometric = false.obs;
  RxList<BiometricType> biometricTypes = RxList<BiometricType>();
  String? displayName;
  RxBool isSaveUser = false.obs;
  Timer? clickTimer;
  int clickCount = 0;
  late LoginCaRepository loginCaRepository;

  @override
  Future<void> onInit() async {
    initText();
    initTextHive();
    biometricTypes.value = await Biometrics().getAvailableBiometrics() ?? [];
    loginCaRepository = LoginCaRepository(this);
    super.onInit();
  }

  @override
  void onClose() {
    clickTimer?.cancel();
    super.onClose();
  }

  void showLog() {
    clickCount++;
    if (clickCount == 1) {
      clickTimer = Timer(const Duration(seconds: 2), () {
        clickCount = 0;
      });
    } else if (clickCount >= 5) {
      Diolog().showDiolog();
    }
  }

  void initText() {
    userNameFocus.value.addListener(() {
      if (userNameFocus.value.hasFocus) {
        fillColorUserName.value = AppColors.secondaryNavyPastel;
      } else {
        fillColorUserName.value = AppColors.secondaryNavyPastel;
      }
    });
    passwordFocus.value.addListener(() {
      if (passwordFocus.value.hasFocus) {
        fillColorPassword.value = AppColors.secondaryNavyPastel;
      } else {
        fillColorPassword.value = AppColors.secondaryNavyPastel;
      }
    });
    // textTaxCode.text = hiveApp.get(AppConst.textTaxCode) ?? "";
    // userNameController.text = hiveApp.get(AppConst.userName) ?? "";
    // passwordController.text = hiveApp.get(AppConst.password) ?? "";
  }

  Future<void> checkPermissionApp({Function? goTo}) async {
    PermissionStatus permissionStatus =
        await checkPermission([Permission.camera]);
    switch (permissionStatus) {
      case PermissionStatus.granted:
        {
          goTo ??
              Get.toNamed(AppRoutes.routeQrKyc)?.then((value) {
                appController.clearData();
              });
        }
        break;
      case PermissionStatus.permanentlyDenied:
        ShowDialog.openAppSetting();
        break;
      default:
        return;
    }
  }

  Future<void> loginToList(int index) async {
    appController.tabIndex = index;
    if (isBiometric.value) {
      await loginFingerprint();
    } else {
      await confirmLogin();
    }
  }

  Future<void> loginFingerprint({bool? autoBiometric}) async {
    if (isBiometric.value) {
      await Biometrics().authenticate(
          // localizedReasonStr: "Quý khách vui lòng quét vân tay hoặc khuôn mặt để xác thực",
          onDeviceUnlockUnavailable: () {
        Fluttertoast.showToast(
            msg: LocaleKeys.biometric_msgUnavailable.tr,
            toastLength: Toast.LENGTH_LONG);
      }, onAfterLimit: () {
        Fluttertoast.showToast(
            msg: LocaleKeys.biometric_msgLimit.tr,
            toastLength: Toast.LENGTH_LONG);
      }).then((isAuthenticated) async {
        if (isAuthenticated != null && isAuthenticated) {
          LoginCaRequestModel loginCaRequestModel =
              hiveUserLogin.get(AppKey.keyRememberLogin) ??
                  LoginCaRequestModel(
                    userName: "",
                    password: "",
                    isRememberMe: false,
                    isBiometric: false,
                  );
          passwordController.text = loginCaRequestModel.password;
          await confirmLogin();
        } else {
          showFlushNoti(
            LocaleKeys.login_biometricError.tr,
            type: FlushBarType.error,
          );
        }
      });
    } else {
      ShowDialog.showDialogNotificationError(
        biometricTypes.contains(BiometricType.face)
            ? LocaleKeys.biometric_noteSettingBiometricFace.tr
            : LocaleKeys.biometric_noteSettingBiometricFingerprint.tr,
        isActiveBack: false,
      );
    }
    // } else if (!(autoBiometric ?? true)) {
    //   ShowPopup.showErrorMessage(biometricTypes.contains(BiometricType.face)
    //       ? AppStr.notSaveFaceID.tr
    //       : AppStr.notSaveFingerprint.tr);
    // }
  }

  Future<void> confirmLogin() async {
    // Get.offAllNamed(
    //   AppRoutes.routeHome,
    // );
    bool isLoginSuccess = await loginResponse();
    if (isLoginSuccess) {
      Get.offAllNamed(
        AppRoutes.routeHome,
      );
    }
  }

  Future<bool> loginResponse() async {
    bool isLoginSuccess = false;

    KeyBoard.hide();
    if (formKey.currentState?.validate() ?? false) {
      try {
        showLoading();
        LoginCaRequestModel loginCaRequestModel = LoginCaRequestModel(
          userName: userNameController.text.trim(),
          password: passwordController.text.trim(),
          isRememberMe: true,
          isBiometric: isBiometric.value,
        );
        BaseResponseBE baseResponseBE =
            await loginCaRepository.loginAppRepository(loginCaRequestModel);
        if (baseResponseBE.status) {
          LoginCaResponseModel loginCaResponseModel = baseResponseBE.data;
          hiveApp.put(
              AppKey.keyToken, "Bearer ${loginCaResponseModel.accessToken}");
          saveAccUser(loginCaRequestModel);
          // await getUserInfo();
          await loginCaRepository.getUserInfo().then((value) {
            if (value.status) {
              appController.isEnablePay =
                  (value.data?.customerInfo?.id == AppConst.idEnable ||
                      value.data?.customerInfo?.id == AppConst.idEnable1);
              if (!(value.data?.customerInfo?.isChangePass ?? true)) {
                isLoginSuccess = false;
                Get.toNamed(AppRoutes.routeForgotPass, arguments: true);
              } else {
                appController.userInfoModel = value.data ?? UserInfoModel();
                hiveApp.put(AppKey.displayName,
                    appController.userInfoModel.customerInfo?.fullName);
                isLoginSuccess = true;
              }
            }
          });
        } else {
          showFlushNoti(
            baseResponseBE.errors?.first.message?.vn ?? "",
            type: FlushBarType.error,
          );
        }
      } catch (e) {
        // showSnackBar(LocaleKeys.registerCa_loginFalse.tr);
      } finally {
        hideLoading();
      }
    }
    return isLoginSuccess;
  }

  // Future<void> getUserInfo() async {
  //   await loginCaRepository.getUserInfo().then((value) {
  //     if (value.status) {
  //       appController.userInfoModel = value.data ?? UserInfoModel();
  //       hiveApp.put(AppKey.displayName,
  //           appController.userInfoModel.customerInfo?.fullName);
  //     }
  //   });
  // }

  void saveAccUser(LoginCaRequestModel loginCaRequestModel) {
    if (isRemember.isTrue) {
      loginCaRequestModel.isRememberMe = true;
      hiveUserLogin.put(AppKey.keyRememberLogin, loginCaRequestModel);
    } else {
      hiveUserLogin.clear();
    }
  }

  // Lấy dữ liệu từ hive về textEditing
  void initTextHive() {
    LoginCaRequestModel loginCaRequestModel =
        hiveUserLogin.get(AppKey.keyRememberLogin) ??
            LoginCaRequestModel(
              userName: "",
              password: "",
              isRememberMe: false,
              isBiometric: false,
            );
    appController.isFingerprintOrFaceID.value = loginCaRequestModel.isBiometric;
    userNameController.text = loginCaRequestModel.userName;
    // passwordController.text = loginCaRequestModel.password;
    // isRemember.value = loginCaRequestModel.isRememberMe;
    isBiometric.value = loginCaRequestModel.isBiometric;
    displayName = hiveApp.get(AppKey.displayName) ?? "";
    isSaveUser.value = userNameController.text != "";
  }

  void loginOther() {
    userNameController.clear();
    isBiometric.toggle();
    isSaveUser.toggle();
  }
}
