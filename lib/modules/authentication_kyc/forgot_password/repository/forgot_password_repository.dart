import 'package:module_ekyc/core/values/app_api.dart';

import '../../../../base_app/base_app.src.dart';
import '../../../../core/enum/enum_request_method.dart';
import '../../../../shares/shares.src.dart';

class ForgotPasswordRepository extends BaseRepository {
  ForgotPasswordRepository(super.controller);

  Future<BaseResponseBE> forgotPassRepository(
      String username, String newPassword) async {
    var data = {
      "username": username,
      "newPassword": newPassword,
      // "secretKey": GetPlatform.isAndroid
      //     ? androidDeviceInfo?.id
      //     : iosDeviceInfo?.identifierForVendor
    };
    var encodedData = data.entries.map((entry) {
      return '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value ?? "")}';
    }).join('&');
    var response = await baseCallApi(
      AppApi.forgotPassWord,
      EnumRequestMethod.post,
      jsonMap: encodedData,
      contentType: Headers.formUrlEncodedContentType,
    );
    return BaseResponseBE.fromJson(
      response,
    );
  }

  Future<BaseResponseBE> changePassRepository(
      String newPassword, String oldPassword) async {
    var data = {
      "newPassword": newPassword,
      "oldPassword": oldPassword,
    };
    var encodedData = data.entries.map((entry) {
      return '${Uri.encodeComponent(entry.key)}=${Uri.encodeComponent(entry.value ?? "")}';
    }).join('&');
    var response = await baseCallApi(
      AppApi.changePassWord,
      EnumRequestMethod.post,
      jsonMap: encodedData,
      contentType: Headers.formUrlEncodedContentType,
    );
    return BaseResponseBE.fromJson(
      response,
    );
  }
}
