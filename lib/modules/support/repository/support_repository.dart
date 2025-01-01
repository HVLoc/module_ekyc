import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/values/app_api.dart';
import 'package:module_ekyc/modules/support/model/support_model.dart';

import '../../../../core/enum/enum_request_method.dart';

class SupportRepository extends BaseRepository {
  SupportRepository(super.controller);

  Future<BaseResponseBE<SupportModel>> getSupportRepository() async {
    var response = await baseCallApi(
      AppApi.getSupport,
      EnumRequestMethod.get,
      // jsonMap: registerRequestModel.toJson(),
    );
    return BaseResponseBE.fromJson(
      response,
      func: (x) => SupportModel.fromJson(x),
    );
  }
}
