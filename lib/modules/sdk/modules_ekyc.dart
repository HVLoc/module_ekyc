import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';

import '../../shares/shares.src.dart';
import '../authentication_kyc/nfc_kyc/nfc_kyc.src.dart';
import 'sdk.src.dart';

class ModulesEkyc {
  static Future<SendNfcRequestModel?> readOnlyNFC() async {
    AppController appController = Get.put(AppController());

    appController.isOnlyNFC = true;
    // Assets.isFromModules = true;
    var result = await appController.checkPermissionApp();
    Get.delete<AppController>();
    return result;
  }

  static Future<SendNfcRequestModel?> checkEKYC(
      SdkRequestModel sdkRequestModel) async {
    AppController appController = Get.put(AppController());
    // Assets.isFromModules = true;
    appController.sdkModel = sdkRequestModel;
    var result = await appController.checkPermissionApp();
    Get.delete<AppController>();
    return result;
  }
}
