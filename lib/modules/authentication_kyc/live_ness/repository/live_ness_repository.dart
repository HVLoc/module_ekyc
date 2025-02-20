import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/base_app/model/base_response_sdk.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/modules/authentication_kyc/live_ness/live_ness_kyc.src.dart';

class LiveNessRepository extends BaseRepository {
  LiveNessRepository(super.controller);

  Future<BaseResponseBESDK<FaceMatchingModel>> loginAppRepository(
      {required img1, required img2}) async {
    var response =
        await baseCallApi(AppApi.faceMatching, EnumRequestMethod.post,
            jsonMap: {
              "img1": img1,
              "img2": img2,
            },
            isHaveVersion: false,
            isToken: false);
    return BaseResponseBESDK.fromJson(
      response,
      func: (x) => FaceMatchingModel.fromJson(x),
    );
  }

  Future<BaseResponseBESDK<FaceMatchSDKResponse>> faceMatching({
    required img1,
    required img2,
    required bool isProd,
    required String merchantKey,
  }) async {
    var response = await baseCallApi(
      AppApi.faceMatching,
      EnumRequestMethod.post,
      jsonMap: {
        "img1": img1,
        "img2": img2,
      },
      isHaveVersion: false,
      queryParameters: {
        "merchantKey": merchantKey,
      },
      urlOther:
          isProd ? AppApi.faceMatchingOtherProd : AppApi.faceMatchingOther,
    );
    return BaseResponseBESDK<FaceMatchSDKResponse>.fromJson(
      response,
      func: (x) => FaceMatchSDKResponse.fromJson(x),
    );
  }
}
