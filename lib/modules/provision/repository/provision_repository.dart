import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/values/app_api.dart';

import '../../../../core/enum/enum_request_method.dart';

class ProvisionRepository extends BaseRepository {
  ProvisionRepository(super.controller);

  Future<BaseResponseBE<String>> getPolicyRepository() async {
    var response = await baseCallApi(
      AppApi.getProvision,
      EnumRequestMethod.get,
      // jsonMap: registerRequestModel.toJson(),
    );
    return BaseResponseBE.fromJson(
      response,
    );
  }
}
