import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/verify_profile_ca/verify_profile_ca_src.dart';
import 'package:module_ekyc/shares/shares.src.dart';

part 'authentication_guide_view.dart';

class AuthenticationGuidePage extends BaseGetWidget {
  const AuthenticationGuidePage({super.key});

  @override
  AuthenticationGuideController get controller =>
      Get.put(AuthenticationGuideController());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      appBar: BackgroundAppBar.buildAppBar(
        LocaleKeys.registerCa_tileAppbarCa.tr,
        isColorGradient: false,
        centerTitle: false,
        leading: true,
        backgroundColor: AppColors.colorTransparent,
      ),
      body: _buildBody().paddingSymmetric(horizontal: AppDimens.padding16),
      bottomNavigationBar: _buildButton(controller),
    );
  }
}
