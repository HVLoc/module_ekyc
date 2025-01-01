import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/modules/overview/overview.src.dart';

import '../../../../shares/shares.src.dart';
import '../../../generated/locales.g.dart';

part 'overview_view.dart';

class OverviewPage extends BaseGetWidget<OverviewController> {
  const OverviewPage(this.tabController, {super.key});
  final TabController tabController;

  @override
  OverviewController get controller =>
      Get.put(OverviewController(tabController));

  @override
  Widget buildWidgets(context) {
    return Scaffold(
      body: SizedBox(
        height: Get.height,
        width: Get.width,
        child: _body(controller, tabController),
      ),
    );
  }
}
