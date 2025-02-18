import 'package:flutter/material.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/login/login.src.dart';
import 'package:module_ekyc/modules/register_info/register_info.src.dart';
import 'package:module_ekyc/shares/utils/time/date_utils.dart';

import '../../../../shares/shares.src.dart';

class RegisterInfoController extends BaseGetxController {
  final TextEditingController phoneNumberConfirm = TextEditingController();

  final TextEditingController emailConfirm = TextEditingController();

  final TextEditingController userNameConfirm = TextEditingController();

  final TextEditingController password = TextEditingController();

  final TextEditingController passwordConfirm = TextEditingController();

  AppController appController = Get.find<AppController>();

  final formKey = GlobalKey<FormState>();

  final Rx<FocusNode> phoneNumberFocus = FocusNode().obs;

  final Rx<FocusNode> emailFocus = FocusNode().obs;

  final Rx<FocusNode> userNameFocus = FocusNode().obs;

  final Rx<FocusNode> passwordFocus = FocusNode().obs;

  final Rx<FocusNode> passwordConfirmFocus = FocusNode().obs;

  late RegisterRepository registerRepository;

  @override
  Future<void> onInit() async {
    userNameConfirm.text = appController.qrUserInformation.documentNumber ?? "";
    registerRepository = RegisterRepository(this);
    super.onInit();
  }

  Future<void> registerInfo() async {
    if (formKey.currentState?.validate() ?? false) {
      RegisterRequestModel registerRequestModel = RegisterRequestModel(
        username: userNameConfirm.text,
        email: emailConfirm.text.isEmpty ? null : emailConfirm.text,
        password: password.text,
        fullName: appController.sendNfcRequestGlobalModel.nameVNM,
        citizenNumber: appController.sendNfcRequestGlobalModel.numberVMN,
        dateOfBirth: convertDateToString(
            convertStringToDate(
                appController.sendNfcRequestGlobalModel.dob, pattern5),
            patternDefault),
        gender: appController.sendNfcRequestGlobalModel.sexVMN?.toUpperCase() ==
                "NAM"
            ? "MALE"
            : "FEMALE",
        nationality: appController.sendNfcRequestGlobalModel.nationalityVMN,
        nativeLand: appController.sendNfcRequestGlobalModel.nationalityVMN,
        ethnic: appController.sendNfcRequestGlobalModel.nationalityVMN,
        religion: appController.sendNfcRequestGlobalModel.religionVMN,
        address: appController.sendNfcRequestGlobalModel.residentVMN,
        issueDate: convertDateToString(
            convertStringToDate(
                appController.sendNfcRequestGlobalModel.registrationDateVMN,
                pattern1),
            patternDefault),
        issuePlate: LocaleKeys.nfcInformationUserPage_locationTitle.tr,
        expiredDate: convertDateToString(
            convertStringToDate(
                appController.sendNfcRequestGlobalModel.doe, pattern5),
            patternDefault),
        identification: appController.sendNfcRequestGlobalModel.otherPaper,
        phone: phoneNumberConfirm.text,
        // secretKey: GetPlatform.isAndroid
        //     ? androidDeviceInfo?.id
        //     : iosDeviceInfo?.identifierForVendor,
      );
      showLoading();
      await registerRepository
          .registerRepository(registerRequestModel)
          .then((value) async {
        if (value.status) {
          LoginController login = Get.find();
          login.passwordController.text = password.text;
          login.userNameController.text = userNameConfirm.text;
          // appController.clearData();
          await login.confirmLogin();
          showFlushNoti(
            LocaleKeys.dialog_registerSuccess.tr,
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
