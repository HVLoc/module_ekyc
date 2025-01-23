import 'package:module_ekyc/modules/sdk/sdk.src.dart';
import 'package:module_ekyc/shares/utils/utils.src.dart';

import '../../../modules/authentication_kyc/nfc_kyc/nfc_kyc.src.dart';

class CreatePararmSDK {
  static SdkRequestAPI sdkRequestAPI(
    SdkRequestModel sdkRequestModel,
    SendNfcRequestModel sendNfcRequestModel,
  ) {
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    String transactionId = IdGenerator.randomIKey;

    String hash = VerificationUtils.buildRequestHash(
      sdkRequestModel.key,
      sdkRequestModel.secretKey,
      transactionId,
      timestamp,
      sendNfcRequestModel.dg1DataB64 ?? "",
    );

    SdkRequestAPI sdkRequestAPI = SdkRequestAPI(
      apiKey: sdkRequestModel.key,
      transactionId: transactionId,
      timestamp: timestamp,
      hash: hash,
    );
    return sdkRequestAPI;
  }
}
