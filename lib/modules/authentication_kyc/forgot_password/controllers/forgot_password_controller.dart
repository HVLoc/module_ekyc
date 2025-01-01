import 'package:flutter/material.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/forgot_password/forgot_password.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/verify_profile_ca/models/login_ca_model/login_ca_model.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/verify_profile_ca/repository/login_ca_repository.dart';
import 'package:module_ekyc/modules/login/login.src.dart';

import '../../../../shares/shares.src.dart';

class ForgotPasswordController extends BaseGetxController {
  final TextEditingController textPassword = TextEditingController();

  final TextEditingController textPasswordConfirm = TextEditingController();

  final formKey = GlobalKey<FormState>();

  final Rx<FocusNode> passwordFocus = FocusNode().obs;

  final Rx<FocusNode> passwordConfirmFocus = FocusNode().obs;

  bool enableTextInput = true;

  late ForgotPasswordRepository forgotPasswordRepository =
      ForgotPasswordRepository(this);

  AppController appController = Get.find<AppController>();

  late LoginCaRepository loginCaRepository = LoginCaRepository(this);

  bool isResetPass = false;

  @override
  Future<void> onInit() async {
    if (Get.arguments != null) {
      if (Get.arguments) {
        isResetPass = Get.arguments;
      }
    }
    super.onInit();
  }

  Future<void> changePass() async {
    KeyBoard.hide();
    if (formKey.currentState?.validate() ?? false) {
      showLoading();
      LoginCaRequestModel loginOldModel =
          hiveUserLogin.get(AppKey.keyRememberLogin) ??
              LoginCaRequestModel(
                userName: "",
                password: "",
                isRememberMe: false,
                isBiometric: false,
              );
      if (isResetPass) {
        await forgotPasswordRepository
            .changePassRepository(
          textPassword.text.trim(),
          loginOldModel.password,
        )
            .then((value) async {
          hideLoading();
          if (value.status) {
            LoginCaRequestModel loginNewModel = LoginCaRequestModel(
              userName: loginOldModel.userName,
              password: textPassword.text.trim(),
              isRememberMe: true,
              isBiometric: false,
            );
            await getUserInfo();
            appController.isFingerprintOrFaceID.value = false;
            saveAccUser(loginNewModel);
            Get.offAllNamed(
              AppRoutes.routeHome,
            );
            showFlushNoti(
              LocaleKeys.forgotPass_resetSuccess.tr,
              type: FlushBarType.success,
            );
          } else {
            showFlushNoti(
              value.errors?.first.message?.vn ?? "",
              type: FlushBarType.error,
            );
          }
          hideLoading();
        });
      } else {
        await forgotPasswordRepository
            .forgotPassRepository(
                appController.qrUserInformation.documentNumber ?? "",
                textPassword.text.trim())
            .then((value) async {
          hideLoading();
          if (value.status) {
            LoginController login = Get.find();
            login.passwordController.text = textPassword.text.trim();
            login.userNameController.text =
                appController.qrUserInformation.documentNumber ?? "";
            login.isBiometric.value = false;
            appController.isFingerprintOrFaceID.value = false;
            // appController.clearData();
            await login.confirmLogin();
            showFlushNoti(
              LocaleKeys.forgotPass_resetSuccess.tr,
              type: FlushBarType.success,
            );
          } else {
            showFlushNoti(
              value.errors?.first.message?.vn ?? "",
              type: FlushBarType.error,
            );
          }
          hideLoading();
        });
      }
    }
  }

  void saveAccUser(LoginCaRequestModel loginCaRequestModel) {
    loginCaRequestModel.isRememberMe = true;
    hiveUserLogin.put(AppKey.keyRememberLogin, loginCaRequestModel);
  }

  Future<void> getUserInfo() async {
    await loginCaRepository.getUserInfo().then((value) {
      if (value.status) {
        appController.userInfoModel = value.data ?? UserInfoModel();
        hiveApp.put(AppKey.displayName,
            appController.userInfoModel.customerInfo?.fullName);
      }
    });
  }
}
