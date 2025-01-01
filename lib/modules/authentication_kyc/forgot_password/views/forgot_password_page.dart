import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/forgot_password/forgot_password.src.dart';
import 'package:module_ekyc/shares/widgets/form/base_form_login.dart';

import '../../../../shares/shares.src.dart';

part 'forgot_password_view.dart';

class ForgotPasswordPage extends BaseGetWidget<ForgotPasswordController> {
  const ForgotPasswordPage({super.key});

  @override
  ForgotPasswordController get controller =>
      Get.put(ForgotPasswordController());

  @override
  Widget buildWidgets(BuildContext context) {
    return _buildBody();
  }

  Widget _buildBody() {
    return Scaffold(
      backgroundColor: AppColors.basicWhite,
      appBar: BackgroundAppBar.buildAppBar(
        LocaleKeys.home_changePassword.tr,
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
