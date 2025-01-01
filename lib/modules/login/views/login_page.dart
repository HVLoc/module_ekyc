import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/login/controllers/login_controller.dart';
import 'package:module_ekyc/shares/widgets/text/font_style.dart';

import '../../../shares/shares.src.dart';
import '../../../shares/widgets/form/base_form_login.dart';

part 'login_view.dart';

class LoginPage extends BaseGetWidget<LoginController> {
  const LoginPage({super.key});

  @override
  LoginController get controller => Get.put(LoginController());

  @override
  Widget buildWidgets(context) {
    return Scaffold(
      body: _body(controller),
      bottomNavigationBar:
          _buildDevelopBy(controller).paddingOnly(bottom: AppDimens.padding5),
    );
  }
}
