import 'package:permission_handler/permission_handler.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/modules/provision/provision.src.dart';

import '../../../../shares/shares.src.dart';

class ProvisionController extends BaseGetxController {
  AppController appController = Get.find<AppController>();
  late ProvisionRepository provisionRepository = ProvisionRepository(this);
  String html = "";

  @override
  Future<void> onInit() async {
    showLoading();
    await provisionRepository.getPolicyRepository().then((value) {
      html = value.data ?? "";
    });
    hideLoading();
    super.onInit();
  }

  Future<void> checkPermissionApp({Function? goTo}) async {
    PermissionStatus permissionStatus =
        await checkPermission([Permission.camera]);
    switch (permissionStatus) {
      case PermissionStatus.granted:
        {
          Get.toNamed(AppRoutes.routeQrKyc);
        }
        break;
      case PermissionStatus.permanentlyDenied:
        ShowDialog.openAppSetting();
        break;
      default:
        return;
    }
  }
}
