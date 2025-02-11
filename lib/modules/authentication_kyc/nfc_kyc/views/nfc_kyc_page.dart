import 'package:flutter/material.dart';
import 'package:module_ekyc/assets.dart';
import 'package:module_ekyc/base_app/base_app.src.dart';
import 'package:module_ekyc/core/core.src.dart';
import 'package:module_ekyc/generated/locales.g.dart';
import 'package:module_ekyc/modules/authentication_kyc/nfc_kyc/nfc_kyc.src.dart';
import 'package:module_ekyc/shares/shares.src.dart';
import 'package:module_ekyc/shares/widgets/form/base_form_login.dart';

part 'nfc_kyc_view.dart';

class ScanNfcKycPage extends BaseGetWidget<ScanNfcKycController> {
  const ScanNfcKycPage({super.key});

  @override
  ScanNfcKycController get controller => Get.put(ScanNfcKycController());

  @override
  Widget buildWidgets(BuildContext context) {
    return Scaffold(
      appBar: BackgroundAppBar.buildAppBar(
        "Cung cấp thông tin QR",
        isColorGradient: false,
        centerTitle: false,
        leading: true,
        textColor: AppColors.colorVTS,
        backButtonColor: AppColors.colorVTS,
        backgroundColor: AppColors.basicWhite,
      ),
      body: _body(controller),
    );
  }
}
