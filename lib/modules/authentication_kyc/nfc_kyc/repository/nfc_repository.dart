import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/nfc_kyc/nfc_kyc.src.dart';

import '../../../sdk/sdk.src.dart';
import '../model/verify_sdk_response.dart';

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

  Future<VerifyResponse> sendNfcVerify(
    SendNfcRequestModel sendNfcRequestModel,
    SdkRequestAPI sdkRequestAPI,
    bool isProd,
  ) async {
    var response = await baseCallApi(
      isProd ? AppApi.verifyC06Prod : AppApi.verifyC06,
      EnumRequestMethod.post,
      urlOther: isProd ? AppApi.verifyC06Prod : AppApi.verifyC06,
      jsonMap: sendNfcRequestModel.toJsonVerify(),
      queryParameters: sdkRequestAPI.toJson(),
      isHaveVersion: false,
    );
    return VerifyResponse.fromJson(response);
  }
}
