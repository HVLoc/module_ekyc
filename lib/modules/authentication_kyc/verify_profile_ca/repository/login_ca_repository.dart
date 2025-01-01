import 'package:dio/dio.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/values/app_api.dart';
import 'package:module_ekyc/modules/login/login.src.dart';

import '../../../../core/enum/enum_request_method.dart';
import '../verify_profile_ca_src.dart';

class LoginCaRepository extends BaseRepository {
  LoginCaRepository(super.controller);

  Future<BaseResponseBE<LoginCaResponseModel>> loginAppRepository(
      LoginCaRequestModel loginCaRequestModel) async {
    FormData formData = FormData.fromMap(loginCaRequestModel.toJson());
    var response = await baseCallApi(AppApi.loginApp, EnumRequestMethod.post,
        jsonMap: formData, isHaveVersion: false, isToken: false);
    return BaseResponseBE.fromJson(
      response,
      func: (x) => LoginCaResponseModel.fromJson(x),
    );
  }

  Future<BaseResponseBE<UserInfoModel>> getUserInfo() async {
    var response = await baseCallApi(
      AppApi.getUserInfo,
      EnumRequestMethod.get,
      isHaveVersion: false,
    );
    return BaseResponseBE.fromJson(
      response,
      func: (x) => UserInfoModel.fromJson(x),
    );
  }
}
