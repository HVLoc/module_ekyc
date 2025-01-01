import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/values/app_api.dart';
import 'package:module_ekyc/modules/register_info/register_info.src.dart';

import '../../../../core/enum/enum_request_method.dart';

class RegisterRepository extends BaseRepository {
  RegisterRepository(super.controller);

  Future<BaseResponseBE> registerRepository(
      RegisterRequestModel registerRequestModel) async {
    var response = await baseCallApi(
      AppApi.getRegister,
      EnumRequestMethod.post,
      jsonMap: registerRequestModel.toJson(),
    );
    return BaseResponseBE.fromJson(
      response,
    );
  }
}
