import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/const.dart';

import '../../shares/shares.src.dart';
import '../authentication_kyc/nfc_kyc/nfc_kyc.src.dart';
import 'sdk.src.dart';

class ModulesEkyc {
  static Future<SendNfcRequestModel?> readOnlyNFC({
    GuidNFC? guidNFC,
  }) async {
    AppController appController = Get.put(AppController());

    appController.isOnlyNFC = true;
    appController.guidNFC = guidNFC;
    Assets.isFromModules = true;
    var result = await appController.checkPermissionApp();
    Get.delete<AppController>();
    return result;
  }

  static Future<SendNfcRequestModel?> checkEKYC(
    SdkRequestModel sdkRequestModel, {
    GuidNFC? guidNFC,
  }) async {
    AppController appController = Get.put(AppController());
    Assets.isFromModules = true;
    appController.sdkModel = sdkRequestModel;
    appController.guidNFC = guidNFC;
    AppConstSDK.apiKey = appController.sdkModel.apiKey;
    var result = await appController.checkPermissionApp();
    Get.delete<AppController>();
    return result;
  }
}
