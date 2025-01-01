import 'package:flutter/material.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/user_info/user_info.src.dart';
import 'package:module_ekyc/shares/widgets/form/base_form_login.dart';

import '../../../../shares/shares.src.dart';

part 'user_info_view.dart';

class UserInfoPage extends BaseGetWidget<UserInfoController> {
  const UserInfoPage({super.key});

  @override
  UserInfoController get controller => Get.put(UserInfoController());

  @override
  Widget buildWidgets(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Scaffold(
      backgroundColor: AppColors.basicWhite,
      appBar: BackgroundAppBar.buildAppBar(
        LocaleKeys.home_accountInfo.tr,
        isColorGradient: false,
        centerTitle: false,
        leading: true,
        backgroundColor: AppColors.colorTransparent,
      ),
      body: SizedBox(
          height: Get.height, width: Get.width, child: _itemBody(controller)),
    );
  }
}
