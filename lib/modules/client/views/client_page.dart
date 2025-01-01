import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/modules/client/client.src.dart';
import 'package:module_ekyc/shares/utils/time/date_utils.dart';

import '../../../../shares/shares.src.dart';
import '../../../generated/locales.g.dart';

part 'client_view.dart';

class ClientPage extends BaseGetWidget<ClientController> {
  const ClientPage({super.key});

  @override
  ClientController get controller => Get.put(ClientController());

  @override
  Widget buildWidgets(context) {
    return Scaffold(
      appBar: BackgroundAppBar.buildAppBarSearch(controller.searchTextEdit,
          functionSearch: () async {
        await controller.searchDocument();
      }, onTap: () {
        controller.visibleFloatButton(visible: true);
      }),
      body: buildLoadingOverlay(() => _body(controller)),
    );
  }
}
