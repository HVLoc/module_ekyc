import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/get_core.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/live_ness/live_ness_kyc.src.dart';
import 'package:module_ekyc/shares/package/export_package.dart';
import 'package:module_ekyc/shares/shares.src.dart';

part 'live_ness_kyc_view.dart';

class LiveNessKycPage extends BaseGetWidget<LiveNessKycController> {
  const LiveNessKycPage({Key? key}) : super(key: key);

  @override
  LiveNessKycController get controller => Get.put(LiveNessKycController());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      body: buildLoadingOverlay(
        () => _body(controller),
      ),
    );
  }
}
