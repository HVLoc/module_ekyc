import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/modules/support/model/support_model.dart';
import 'package:module_ekyc/modules/support/support.src.dart';

import '../../../../shares/shares.src.dart';

class SupportController extends BaseGetxController {
  AppController appController = Get.find<AppController>();
  late SupportRepository supportRepository = SupportRepository(this);
  SupportModel supportModel = SupportModel();
  List<String> listPhone = [];

  @override
  Future<void> onInit() async {
    showLoading();
    await supportRepository.getSupportRepository().then((value) {
      supportModel = value.data ?? SupportModel();
      if (supportModel.phone != null) {
        listPhone = supportModel.phone?.split(",") ?? [];
      }
    });
    hideLoading();
    super.onInit();
  }
}
