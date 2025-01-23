import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/nfc_kyc/nfc_kyc.src.dart';

import '../../../sdk/sdk.src.dart';

class NfcRepository extends BaseRepository {
  NfcRepository(super.controller);

  Future<BaseResponseBE<NfcResponseModel>> sendNfcRepository(
      SendNfcRequestModel sendNfcRequestModel) async {
    var response = await baseCallApi(
      AppApi.sendNfcData,
      EnumRequestMethod.post,
      jsonMap: sendNfcRequestModel.toJsonBase64(),
      isHaveVersion: false,
    );
    return BaseResponseBE.fromJson(
      response,
      func: (x) => NfcResponseModel.fromJson(x),
    );
  }

  Future<BaseResponseBE<NfcResponseModel>> sendNfcVerify(
    SendNfcRequestModel sendNfcRequestModel,
    SdkRequestAPI sdkRequestAPI,
  ) async {
    var response = await baseCallApi(
      AppApi.verifyC06,
      EnumRequestMethod.post,
      jsonMap: sendNfcRequestModel.toJsonVerify(),
      queryParameters: sdkRequestAPI.toJson(),
      isHaveVersion: false,
    );
    return BaseResponseBE.fromJson(
      response,
      func: (x) => NfcResponseModel.fromJson(x),
    );
  }
}
